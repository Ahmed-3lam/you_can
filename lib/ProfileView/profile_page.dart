import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_can/Constants/color_contants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/ProfileView/Widgets/profile_card.dart';
import 'package:you_can/Services/Auth/auth.dart';
import 'package:you_can/landing_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<MyUser>(context, listen: false);
    final authBase = Provider.of<AuthBase>(context, listen: false);

    print(user.uid);
    print(user.name);
    print(user.isDoctor);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile",
          style: TextStyle(color: ColorsConstants.blackColor),
        ),
        centerTitle: true,
        backgroundColor: ColorsConstants.whiteColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CircleAvatar(
                backgroundColor: ColorsConstants.lightBlueColor,
                backgroundImage: user.photoUrl != null
                    ? NetworkImage(user.photoUrl)
                    : AssetImage("assets/images/avatar.png"),
                radius: MediaQuery.of(context).size.width * 0.15,
              ),
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Offstage(
                offstage: !user.isDoctor,
                child: Text(
                  user.specialization,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            user.bio != null ? Text(user.bio) : Container(),
            SizedBox(
              height: 15,
            ),
            ProfileCard(title: "My feed", onTap: () {}),
            ProfileCard(title: "My saved", onTap: () {}),
            ProfileCard(title: "Edit profile", onTap: () {}),
            ProfileCard(
              title: "Logout",
              onTap: () async {
                try {
                  await authBase.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      (route) => false);
                } catch (e) {
                  print('//////////////');
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.message)));
                }
              },
              iconData: Icons.logout_outlined,
            )
          ],
        ),
      ),
    );
  }
}
