import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:you_can/WorkoutView/colors.dart';

Widget challengeBuildItem(context, String headText, String image,
        List<String> trainingImage, int index) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => workOutGif(trainingImage[index]),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("$image"),
                      fit: BoxFit.cover,
                    ),
                    color: Color(0xFF74BDCB),
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("$headText", style: TextStyle(fontSize: 16)),
                      // SizedBox(height: 8),
                      // Text("fgfg", style: TextStyle(fontSize: 20))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );

Widget workOutGif(String trainingImage) => Scaffold(
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
            child: Container(
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
                        trainingImage = "assets/gif/2.gif";
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
                        trainingImage = "assets/gif2/3.gif";
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
