// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project3/ui/ui_helper/ThemeSwitcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:project3/ui/ui_helper/HomePageView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marquee/marquee.dart';

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
  Widget build(BuildContext context) {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
