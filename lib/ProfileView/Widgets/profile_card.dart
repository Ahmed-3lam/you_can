import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData iconData;

  const ProfileCard({
    Key key,
    @required this.onTap,
    @required this.title,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                iconData ?? Icons.arrow_forward_ios,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
