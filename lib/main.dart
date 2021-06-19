import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_can/HomeView/Provider/home_provider.dart';
import 'package:you_can/HomeView/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'You can',
        home: HomePage(),
      ),
    );
  }
}
