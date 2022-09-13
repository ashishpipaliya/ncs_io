import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncs_io_example/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
        home: const Home(),
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.deepPurple));
  }
}
