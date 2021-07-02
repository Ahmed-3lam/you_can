import 'package:flutter/material.dart';
import 'package:you_can/AuthenticationView/login_view.dart';
import 'package:you_can/AuthenticationView/signup_view.dart';
import 'package:you_can/Constants/color_constants.dart';

class InitView extends StatelessWidget {
  const InitView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      height: 300,
                      width: 300,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ColorsConstants.lightBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: ColorsConstants.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 70,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     color: primaryColor,
                  //   ),
                  //   child: MaterialButton(
                  //     onPressed: () {
                  //       Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => LoginView()),
                  //         (Route<dynamic> route) => false,
                  //       );
                  //     },
                  //     child: Text(
                  //       'Login',
                  //       style: TextStyle(color: Colors.white, fontSize: 25),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpView()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ColorsConstants.lightBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: ColorsConstants.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //   width: double.infinity,
                  //   height: 70,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     color: primaryColor,
                  //   ),
                  //   child: MaterialButton(
                  //     onPressed: () {
                  //       Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => SignUpView()),
                  //         (Route<dynamic> route) => false,
                  //       );
                  //     },
                  //     child: Text(
                  //       'Sign Up',
                  //       style: TextStyle(color: Colors.white, fontSize: 25),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )));
  }
}
