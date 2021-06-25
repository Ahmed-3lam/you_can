import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models.dart';

Widget buildBoardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage('${model.image}'),

        width: double.infinity,
      ),
    ),
    SizedBox(
      height: 30.0,
    ),
     Column(
        children: [
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      )



  ],
);

Widget buildBoardingItem2(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage('${model.image}'),

        width: double.infinity,
      ),
    ),

    Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.black87,
      ),
      child: 
      Container(
        padding: EdgeInsets.all(30),
        child:Column(
          children: [
            Text(
              '${model.title}',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              '${model.body}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ), 
      )
      
    )



  ],
);