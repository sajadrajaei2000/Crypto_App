// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  var controller;
  HomePageView({super.key, required this.controller});

  @override
  State<HomePageView> createState() => _HomePAaeVIewState();
}

class _HomePAaeVIewState extends State<HomePageView> {
  var images = [
    'images/a1.png',
    'images/a2.png',
    'images/a3.png',
    'images/a4.png'
  ];
  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.controller,
      scrollDirection: Axis.horizontal,
      children: [
        myPages(images[0]),
        myPages(images[1]),
        myPages(images[2]),
        myPages(images[3]),
      ],
    );
  }

  Widget myPages(String image) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Image.asset(image, fit: BoxFit.fill),
    );
  }
}
