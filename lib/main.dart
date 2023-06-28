import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/ui/ui_helper/ThemeSwitcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyMaterialApp());
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({super.key});

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  }
}
