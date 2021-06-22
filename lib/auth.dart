import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authform extends StatefulWidget {
  const Authform({Key key}) : super(key: key);

  @override
  _AuthformState createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "enter your email",
                hintText: "ex: user@gmail.com ",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "enter your password",
                //hintText: "8 digits",
              ),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.end ,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "forget password ?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
