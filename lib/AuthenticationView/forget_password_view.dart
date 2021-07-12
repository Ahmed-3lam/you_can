import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Constants/string_constants.dart';
import 'package:you_can/Services/Auth/auth.dart';
import 'package:you_can/Services/valdiation.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key key}) : super(key: key);

  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> _submit() async {
    Auth auth = Auth();
    try {
      isLoading = true;
      setState(() {});
      await auth.resetPassword(emailController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print('//////////////');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsConstants.whiteColor,
        iconTheme: IconThemeData(color: ColorsConstants.blackColor),
      ),
      backgroundColor: ColorsConstants.whiteColor,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              StringConstants.forgetPassword,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              StringConstants.forgetPasswordMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Email Address"),
                )
              ],
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline_outlined),
                    hintText: "example@gmail.com",
                  ),
                  validator: (value) {
                    if (value == null || !Validations.emailValidation(value)) {
                      return 'Please enter valid email';
                    }
                    return null;
                  }),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Complete Data ')));
                  } else {
                    _submit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: ColorsConstants.lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: ColorsConstants.whiteColor)
                    : Text(
                        "send email",
                        style: TextStyle(
                          color: ColorsConstants.whiteColor,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
