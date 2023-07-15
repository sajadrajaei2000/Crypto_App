import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/ui/MainWrapper.dart';
import 'package:project3/ui/SignUpScreen.dart';
import 'package:project3/ui/providers/CryptoDataProvider.dart';
import 'package:project3/ui/providers/MarketViewProvider.dart';
import 'package:project3/ui/providers/ThemeProvider.dart';
import 'package:project3/ui/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CryptoDataProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => MarketViewProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserDataProvider(),
    ),
  ], child: const MyMaterialApp()));
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({super.key});

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('fa'), // Spanish
        ],
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(body: SignUpScreen()
              //MainWrapper(),
              ),
        ),
      );
    });
  }
}
