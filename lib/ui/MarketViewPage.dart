import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project3/ui/providers/MarketViewProvider.dart';
import 'package:project3/ui/ui_helper/ShimmerMarketWidget.dart';
import 'package:provider/provider.dart';

import '../helpers/decimalRounder.dart';
import '../models/CryptoModel/CryptoData.dart';
import '../network/ResponseModel.dart';

class MarketViewPage extends StatefulWidget {
  const MarketViewPage({super.key});

  @override
  State<MarketViewPage> createState() => _MarketViewPageState();
}

class _MarketViewPageState extends State<MarketViewPage> {
  late Timer timer;
  @override
  void initState() {
    super.initState();

    final marketViewProvider =
        Provider.of<MarketViewProvider>(context, listen: false);
    marketViewProvider.getCryptoData();
    timer = Timer.periodic(const Duration(seconds: 20),
        (timer) => marketViewProvider.getCryptoData());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var textTheme = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height;
    var bordeColor = Theme.of(context).secondaryHeaderColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: primaryColor,
          title: Text(
            'Market View',
            style: textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(child: Consumer<MarketViewProvider>(
                builder: (context, marketViewProvider, child) {
                  switch (marketViewProvider.state.status) {
                    case Status.LOADING:
                      return const ShimmerMarketWidget();
                    case Status.COMPLETED:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10),
                            child: TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  hintStyle: textTheme.bodySmall,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: bordeColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: bordeColor)),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (contex, index) {
                                List<CryptoData>? model = marketViewProvider
                                    .dataFuture.data!.cryptoCurrencyList;
                                var number = index + 1;
                                var tokenId = model![index].id;
                                MaterialColor filterColor =
                                    DecimalRounder.setColorFilter(model[index]
                                        .quotes![0]
                                        .percentChange24h);
                                var finalPrice =
                                    DecimalRounder.removePriceDecimals(
                                        model[index].quotes![0].price);
                                Icon percentIcon =
                                    DecimalRounder.setPercentChangesIcon(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                var percentChange =
                                    DecimalRounder.removePercentDecimals(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                Color percentColor =
                                    DecimalRounder.setPercentChangesColor(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                return SizedBox(
                                  height: height * 0.075,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                                              const Duration(milliseconds: 500),
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
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
                                          )),
                                      Flexible(
                                          fit: FlexFit.tight,
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                filterColor, BlendMode.srcATop),
                                            child: SvgPicture.network(
                                                'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg'),
                                          )),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$$finalPrice',
                                            style: textTheme.bodySmall,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              percentIcon,
                                              Text(
                                                '$percentChange%',
                                                style: GoogleFonts.ubuntu(
                                                    color: percentColor,
                                                    fontSize: 13),
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                );
                              },
                              itemCount: 1000,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          ),
                        ],
                      );
                    case Status.ERROR:
                      return Text(marketViewProvider.state.massege);
                    default:
                      return Container();
                  }
                },
              ))
            ],
          ),
        ));
  }
}
