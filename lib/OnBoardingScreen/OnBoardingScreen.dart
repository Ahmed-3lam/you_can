import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:you_can/AuthenticationView/init_view.dart';
import 'package:you_can/Constants/color_constants.dart';

import 'Models.dart';
import 'Widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  var boardController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => InitView()),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(color: ColorsConstants.blackColor),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: ColorsConstants.lightBlueColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: ColorsConstants.lightBlueColor,
                  onPressed: () {
                    if (isLast) {
                      print("Go to Login");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => InitView()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.slowMiddle,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
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

// Container(
//
//
// color: Colors.white,
//
// child: Stack(
//
// children: [
// PageView.builder(
// physics: BouncingScrollPhysics(),
// controller: boardController,
// onPageChanged: (int index) {
// if (index == boarding.length - 1) {
// setState(() {
// isLast = true;
// });
// } else {
// setState(() {
// isLast = false;
// });
// }
// },
// itemBuilder: (context, index) =>
// buildBoardingItem(boarding[index]),
// itemCount: boarding.length,
// ),
// Positioned(
// bottom: 50,
// left: 150,
// child: Column(
// children: [
// Container(
// width: 70,
// height:70,
//
// child:FloatingActionButton(
// backgroundColor: Colors.white,
// onPressed: () {
// if (isLast) {
// print("Go to Login");
// } else {
// boardController.nextPage(
// duration: Duration(
// milliseconds: 750,
// ),
// curve: Curves.easeOutCirc,
// );
// }
// },
// child: Icon(
// Icons.arrow_forward_ios,
// color: Colors.black,
// ),
// ),
// ),
//
// TextButton(onPressed: (){
//
// },
// child: Text(
// "Skip",
// style: TextStyle(color: Colors.white, fontSize: 20),
// ))
// ],
// ),
// )
//
//
//
//
// ],
// ),
// );
