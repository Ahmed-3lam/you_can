import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(20),
              )
          ),
          child: Row(
            children: [
              SizedBox(width: 70,),
              Column(
                children: [
                  Text("Chest Training",style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: 10,),
                  Row(

                    children: [
                      Container(
                        width: 80.0,
                        decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius:
                        BorderRadius.circular(10)),
                        child: Text("beginer",textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                        ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 50.0,
                        decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius:
                        BorderRadius.circular(10)),
                        child: Text("8m",textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                        ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Image.asset("images/chair1.png",width: 150,height: 150,),
            ],
          ),
        ),
      ],
    );
  }
}
