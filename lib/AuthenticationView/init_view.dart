import 'package:flutter/material.dart';
import 'package:you_can/AuthenticationView/login_view.dart';
import 'package:you_can/AuthenticationView/signup_view.dart';

class InitView extends StatelessWidget {
  const InitView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor =Color.fromRGBO(76, 104, 218, 1);
    return Scaffold(
        backgroundColor: Colors.white,


        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Image.asset("assets/images/board3.jpg",height: 300, width: 300,),
                  SizedBox(height: 50,),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: primaryColor,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginView()),
                        (Route<dynamic> route) => false,);

                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: primaryColor,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpView()),
                              (Route<dynamic> route) => false,);

                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            )


        )
    );
  }
}
