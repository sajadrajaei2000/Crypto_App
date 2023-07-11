// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';
import 'package:project3/models/CryptoModel/CryptoData.dart';
import 'package:project3/ui/providers/CryptoDataProvider.dart';
import 'package:project3/ui/ui_helper/ThemeSwitcher.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:project3/ui/ui_helper/HomePageView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project3/network/ResponseModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  List<String> _choiceChips = ['Top MarketCaps', 'Top Gainers', 'Top Losers'];
  var defaultChoiceIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.firstPage),
        titleTextStyle: textTheme.titleLarge,
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: const [ThemeSwitcher()],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SmoothPageIndicator(
                              effect: const ExpandingDotsEffect(
                                  dotHeight: 10, dotWidth: 10),
                              controller: _pageViewController,
                              onDotClicked: (index) =>
                                  _pageViewController.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut),
                              count: 4),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: ' 📪 This is the place to show news!',
                  style: textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      child: Text('buy'),
                      onPressed: () {},
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.red[700],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      child: Text('sell'),
                      onPressed: () {},
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: List.generate(_choiceChips.length, (index) {
                        return ChoiceChip(
                          label: Text(_choiceChips[index],
                              style: textTheme.titleSmall),
                          selected: defaultChoiceIndex == index,
                          selectedColor: Colors.blue,
                          onSelected: (value) {
                            setState(() {
                              defaultChoiceIndex =
                                  value ? index : defaultChoiceIndex;
                            });
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 400,
                  child: Consumer<CryptoDataProvider>(
                      builder: (context, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: 80,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.white,
                              child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 8, right: 8),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                        Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, left: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        Flexible(
                                            child: SizedBox(
                                          height: 40,
                                          width: 70,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white),
                                          ),
                                        )),
                                        Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, right: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    );
                                  })),
                        );
                      case Status.COMPLETED:
                        return ListView.separated(
                          itemBuilder: (contex, index) {
                            List<CryptoData>? model = cryptoDataProvider
                                .dataFuture.data!.cryptoCurrencyList;
                            var number = index + 1;
                            var tokenId = model![index].id;
                            return SizedBox(
                              height: height * 0.075,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      number.toString(),
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 15),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 500),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      height: 32,
                                      width: 32,
                                      imageUrl:
                                          "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                    ),
                                  ),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model[index].name!,
                                            style: textTheme.bodySmall,
                                          ),
                                          Text(
                                            model[index].symbol!,
                                            style: textTheme.labelSmall,
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            );
                          },
                          itemCount: 10,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        );
                      case Status.ERROR:
                        return Text(cryptoDataProvider.state.massege);
                      default:
                        return Container();
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
