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
        theme: ThemeData(

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[200],
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        title: 'You can',
        home: HomePage(),
      ),
    );
  }
}
