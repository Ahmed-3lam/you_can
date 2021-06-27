import 'package:flutter/material.dart';
import 'package:you_can/Constants/color_constants.dart';

class FloatingAddPostButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData icon;
  final Color backGround;
  final Color forGround;
  const FloatingAddPostButton(
      {Key key,
      this.onPressed,
      this.title,
      this.icon,
      this.backGround,
      this.forGround})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: backGround, elevation: 2, fixedSize: Size(130, 40)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                icon,
                color: forGround,
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: ColorsConstants.blackColor),
            )
          ],
        ));
  }
}
