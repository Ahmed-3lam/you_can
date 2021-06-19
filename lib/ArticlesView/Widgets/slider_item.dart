import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key key,
    @required int current,
    this.index,
  })  : _current = current,
        super(key: key);

  final int _current;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _current == index ? Colors.black12 : Color(0xFF74BDCB),
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Positioned(
            child: SvgPicture.asset(
              "assets/images/inspire.svg",
              height: 200,
            ),
            bottom: 0,
            right: 10,
            width: 200,
          ),
          ListView(
            padding: EdgeInsets.all(14),
            children: [
              Text("Daily Life",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text("How to mange your time",
                  style: TextStyle(fontSize: 18, color: Colors.white))
            ],
          )
        ],
      ),
    );
  }
}
