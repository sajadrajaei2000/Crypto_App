import 'package:flutter/material.dart';
import 'package:project3/ui/Homepage.dart';
import 'package:project3/ui/MarketViewPage.dart';
import 'package:project3/ui/ProfilePage.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: PageView(
        controller: _myPage,
        children: const [Homepage(), MarketViewPage(), ProfilePage()],
      ),
    );
  }
}
