import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_can/HomeView/Provider/home_provider.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:you_can/Services/Auth/auth.dart';
import 'package:you_can/Services/Auth/data_base.dart';
import 'package:you_can/landing_page.dart';

int initScreen;
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        Provider<MyUser>(create: (context) => MyUser()),
        Provider<AuthBase>(create: (context) => Auth()),
        Provider<FireStoreDatabase>(create: (context) => FireStoreDatabase()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        title: 'You can',
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Container(
                  color: Colors.red,
                  height: 200,
                ),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              if(initScreen==0 || initScreen == null ){
                return OnBoardingScreen();
              } else{
                return LandingPage();
              }


            }
            // Otherwise, show something whilst waiting for initialization to complete
            return Container(
              color: Colors.white,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
