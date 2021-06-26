import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_can/AuthenticationView/login_view.dart';
import 'package:you_can/HomeView/home_page.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/auth.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBase = Provider.of<AuthBase>(context, listen: false);
    final dataBase = Provider.of<FireStoreDatabase>(context, listen: false);
    return StreamBuilder(
        stream: authBase.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            MyUser user = snapshot.data;
            if (user == null) {
              return LoginView();
            }
            print(authBase.isNewUser);
            return StreamBuilder<MyUser>(
              stream: dataBase.userStream(userId: user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Provider.value(
                    value: snapshot.data,
                    child: HomePage(),
                  );
                } else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
