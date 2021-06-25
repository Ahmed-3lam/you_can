import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_can/Constants/color_contants.dart';
import 'package:you_can/Constants/string_contants.dart';
import 'package:you_can/HomeView/home_page.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/auth.dart';
import 'package:you_can/Services/Auth/data_base.dart';
import 'package:you_can/Services/valdiation.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController specialController = TextEditingController();

  bool isDoctor = false;
  bool retypePassword = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    Auth auth = Auth();
    FireStoreDatabase database = FireStoreDatabase();
    try {
      isLoading = true;
      setState(() {});
      var user = await auth.createUserWithEmailAndPassword(
          emailController.text, passwordController.text);

      var myUser = MyUser(
          uid: user.uid,
          email: user.email,
          name: user.email,
          isDoctor: isDoctor,
          photoUrl: null,
          bio: null,
          specialization: specialController.text);

      await database.setUser(myUser, user.uid);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      print('//////////////');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } on FirebaseException catch (e) {
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                StringConstants.signUp,
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
                StringConstants.signUpMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Full name"),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        hintText: "name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter correct name';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Email Address"),
                    ),
                    TextFormField(
                      controller: emailController,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Retype Password"),
                    ),
                    TextFormField(
                      controller: retypePasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "password",
                      ),
                      validator: (value) {
                        if (value == null ||
                            passwordController.text !=
                                retypePasswordController.text ||
                            value.isEmpty) {
                          return 'password does not match';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("Please select: "),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: Checkbox(
                            value: isDoctor,
                            onChanged: (value) {
                              isDoctor = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text("doctor or specialist"),
                        ),
                      ],
                    ),
                    Offstage(
                      offstage: !isDoctor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("specialization"),
                          ),
                          TextFormField(
                            controller: specialController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.title_outlined),
                              hintText: "specialization",
                            ),
                            validator: (value) {
                              if (isDoctor &&
                                  (value == null || value.isEmpty)) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
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
                          "Sign Up",
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
                  Text("have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
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
