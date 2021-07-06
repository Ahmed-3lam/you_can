import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/comment_model.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key key,
    @required this.model,
  }) : super(key: key);

  final CommentModel model;

  @override
  Widget build(BuildContext context) {
    var dataBase = Provider.of<FireStoreDatabase>(context, listen: false);
    return StreamBuilder<MyUser>(
      stream: dataBase.userStream(userId: model.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorsConstants.lightBlueColor,
                  backgroundImage: snapshot.data.photoUrl != null
                      ? NetworkImage(snapshot.data.photoUrl)
                      : AssetImage("assets/images/avatar.png"),
                  radius: 25,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data.name),
                          SizedBox(height: 10),
                          Text(model.body),
                          Text(
                            Jiffy(model.time).fromNow(),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
