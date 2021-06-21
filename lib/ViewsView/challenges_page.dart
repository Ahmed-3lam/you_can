import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkOutScreen extends StatefulWidget {
  const WorkOutScreen({key}) : super(key: key);

  @override
  _WorkOutScreenState createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen> {
  String btnText = "Start Training";
  Color primaryColor = Color.fromRGBO(76, 104, 218, 1);

  bool trainingEnable = true;
  String trainingImage = "Tummy.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: primaryColor,
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/$trainingImage'),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ))),
          SizedBox(
            height: 150,
          ),
                  )
              )
          ),
          SizedBox(height: 150,),
          Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: primaryColor,
            ),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  if (trainingEnable) {
                    trainingImage = "Seated.png";
                    trainingEnable = false;
                    btnText = "One";
                  } else {
                  }
                  else {
                    trainingImage = "Tummy.png";
                    trainingEnable = true;
                    btnText = "Two";
                  }
                });
              },
              child: Text(
                '$btnText',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
