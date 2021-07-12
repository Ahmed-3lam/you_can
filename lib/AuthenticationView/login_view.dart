import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_can/AuthenticationView/forget_password_view.dart';
import 'package:you_can/AuthenticationView/signup_view.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Constants/string_constants.dart';
import 'package:you_can/Services/Auth/auth.dart';
import 'package:you_can/Services/valdiation.dart';
import 'package:you_can/landing_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _submit() async {
    Auth auth = Auth();
    try {
      isLoading = true;
      setState(() {});
      await auth.signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      isLoading = false;
      setState(() {});

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      setState(() {});
      print('//////////////');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                StringConstants.signIn,
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
                StringConstants.signInMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Email Address"),
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                        hintText: "example@gmail.com",
                      ),
                      validator: (value) {
                        if (value == null ||
                            !Validations.emailValidation(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Password"),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "password",
                      ),
                      validator: (value) {
                        if (value == null ||
                            !Validations.passwordValidation(value)) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordView()));
                          },
                          child: Text(
                            "forget password ?",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
                          "Sign in",
                          style: TextStyle(
                            color: ColorsConstants.whiteColor,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpView()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: ColorsConstants.lightBlueColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
