import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/ui/providers/ThemeProvider.dart';
import 'package:project3/ui/ui_helper/ThemeSwitcher.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    )
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
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              actions: const [ThemeSwitcher()],
              title: Text('ExchangeBS'),
              centerTitle: true,
            ),
            body: Container(),
          ),
        ),
      );
    });
  }
}
