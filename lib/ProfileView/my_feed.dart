import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/post_model.dart';
import 'package:you_can/PostsView/post_item.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class MyFeed extends StatelessWidget {
  final MyUser user;
  const MyFeed({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataBase = Provider.of<FireStoreDatabase>(context, listen: false);
    print("${user.uid}  is user in post page");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsConstants.blackColor),
        title: Text(
          "MyFeed",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<PostModel>>(
          stream: dataBase.userPostsStream(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("you havn\'t posts yet"),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => PostItem(
                  model: snapshot.data[index],
                  // userUID: user.uid,
                  database: dataBase,
                ),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey[100],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
