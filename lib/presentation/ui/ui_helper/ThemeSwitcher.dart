import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project3/logic/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var switchIcon = Icon(themeProvider.isDarkmode
        ? CupertinoIcons.moon_fill
        : CupertinoIcons.sun_max_fill);
    return IconButton(
      icon: switchIcon,
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
