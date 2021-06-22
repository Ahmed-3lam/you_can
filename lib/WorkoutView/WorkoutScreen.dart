import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class WorkOutScreen extends StatefulWidget {
  const WorkOutScreen({key}) : super(key: key);

  @override
  _WorkOutScreenState createState() => _WorkOutScreenState();
}

class _WorkOutScreenState extends State<WorkOutScreen> {
  String trainingImage = "assets/images/victory1.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey[20],
                  image: new DecorationImage(
                    image: new AssetImage('$trainingImage'),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ))),
          
          Expanded(
            child:Container(
              padding: EdgeInsets.all(50),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),

              child: Column(
                children: [
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
                          trainingImage = "assets/gif2/1.gif";
                        });
                      },
                      child: Text(
                        'Biceps',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
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
                          trainingImage = "assets/gif2/2.gif";
                        });
                      },
                      child: Text(
                        'Triceps',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )


        ],
      ),
    );
  }
}
