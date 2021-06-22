import 'package:flutter/material.dart';

import 'auth.dart';
class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "sign in now",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please enter your information below ",
              style:
              TextStyle(

                color: Colors.black,
                fontSize: 20,
                //fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "in order to login your account",
              style:
              TextStyle(

                color: Colors.black,
                fontSize: 20,
                //fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 100,),
            //Image.asset("logo/cherry.png", height: 250),
            Authform(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                Text("don't have ann account ?"),
                TextButton(onPressed: (){},
                  child: Text("create now", style: TextStyle(color: Colors.blue),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
