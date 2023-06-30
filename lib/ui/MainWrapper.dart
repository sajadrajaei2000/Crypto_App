import 'package:flutter/material.dart';
import 'package:project3/ui/Homepage.dart';
import 'package:project3/ui/MarketViewPage.dart';
import 'package:project3/ui/ProfilePage.dart';
import 'package:project3/ui/WatchListPage.dart';
import 'package:project3/ui/ui_helper/BottomNav.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.compare_arrows_outlined), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(controller: _myPage),
      body: PageView(
        controller: _myPage,
        children: const [
          Homepage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage()
        ],
      ),
    );
  }
}
