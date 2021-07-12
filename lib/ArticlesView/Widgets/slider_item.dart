import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/View/category_view.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key key,
    @required int current,
    this.index,
    this.about,
    this.sliderImage,
    this.dataBase,
    this.currentUser,
  })  : _current = current,
        super(key: key);

  final int _current;
  final int index;
  final String about;
  final String sliderImage;
  final FireStoreDatabase dataBase;
  final MyUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryView(
                database: dataBase,
                currentUser: currentUser,
                about: about,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: _current == index ? Colors.black12 : Color(0xFF74BDCB),
              borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Positioned(
                child: Image.asset(
                  sliderImage ?? "assets/images/inspire.svg",
                  height: 200,
                ),
                bottom: 0,
                right: 10,
                width: 200,
              ),
              ListView(
                padding: EdgeInsets.all(14),
                children: [
                  Text(about,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(height: 8),
                  // Text("How to mange your time",
                  //     style: TextStyle(fontSize: 18, color: Colors.white))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
