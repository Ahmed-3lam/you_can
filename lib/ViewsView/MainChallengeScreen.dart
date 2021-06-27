import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_can/ViewsView/Widgets/challengesWidgets.dart';

class MainChallengeScreen extends StatefulWidget {
  const MainChallengeScreen({Key key}) : super(key: key);

  @override
  _MainChallengeScreenState createState() => _MainChallengeScreenState();
}

class _MainChallengeScreenState extends State<MainChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> headText= [
      "Biceps",
      "Triceps",
      "Delts",
      "Core",
      "BodyWeight"
    ];
    List<String> image=[
      "assets/images/biceps.jpg",
      "assets/images/triceps.jpg",
      "assets/images/delts.jpg",
      "assets/images/core.jpg",
      "assets/images/bodyWeight.jpg"
    ];
    List<String> workoutImages=[
      "assets/gif/2.gif",
      "assets/gif/3.gif",
      "assets/gif/4.gif",
      "assets/gif/5.gif",
      "assets/gif/6.gif"
    ];

    return Scaffold(

      body: ListView.builder(
          itemBuilder: (context,index)=>challengeBuildItem(context,headText[index],image[index],workoutImages,index),

          itemCount: 5
      )

    );
  }
}
