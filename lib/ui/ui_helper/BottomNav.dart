// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return BottomAppBar(
      height: 63,
      notchMargin: 5,
      color: primaryColor,
      shape: CircularNotchedRectangle(),
      child: SizedBox(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: Icon(
                      Icons.home,
                      size: 28,
                    )),
                IconButton(
                    onPressed: () {
                      controller.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: Icon(
                      Icons.bar_chart_rounded,
                      size: 28,
                    ))
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.animateToPage(2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: Icon(
                      Icons.person,
                      size: 28,
                    )),
                IconButton(
                    onPressed: () {
                      controller.animateToPage(3,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: Icon(
                      Icons.panorama_vertical_select,
                      size: 28,
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
