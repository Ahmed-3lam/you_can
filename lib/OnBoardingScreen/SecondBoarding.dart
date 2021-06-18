import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Models.dart';
import 'Widgets.dart';

class SecondBoardScreen extends StatefulWidget {
  const SecondBoardScreen({Key? key}) : super(key: key);

  @override
  _SecondBoardScreenState createState() => _SecondBoardScreenState();
}

class _SecondBoardScreenState extends State<SecondBoardScreen> {
  bool isLast = false;
  var boardController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:Stack(
          children: [
            PageView.builder(
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
                  buildBoardingItem2(boarding[index]),
              itemCount: boarding.length,
            ),
            Positioned(
              bottom: 50,
              left: 150,
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height:70,

                    child:FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        if (isLast) {
                          print("Go to Login");
                        } else {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 1000,
                            ),
                            curve: Curves.easeInCubic,
                          );
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  TextButton(onPressed: (){

                  },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
            ),
            Positioned(
              bottom: 120,
              left: 10,
              child:
            SmoothPageIndicator(
              controller: boardController,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,

                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0,
              ),
              count: boarding.length,
            ),
            )





          ],
        ),



    );

  }

}












