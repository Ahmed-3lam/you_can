import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/post_model.dart';
import 'package:you_can/PostsView/comments_page.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    Key key,
    @required this.model,
    // @required this.user,
    @required this.database,
  }) : super(key: key);

  final PostModel model;
  // final MyUser user;
  final FireStoreDatabase database;

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<MyUser>(context, listen: false);
    bool isLiked = widget.model.likes.contains(user.uid);
    return StreamBuilder<MyUser>(
      stream: widget.database.userStream(userId: widget.model.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentsPage(
                    // list: widget.model.comments,
                    user: user,
                    postId: widget.model.id,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  postHeader(snapshot),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model.body,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Offstage(
                    offstage: !widget.model.haveImage,
                    child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: widget.model.haveImage
                                    ? NetworkImage(widget.model.imageUrl)
                                    : AssetImage('assets/images/cover.jpeg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              print("users/${user.uid}");
                              if (isLiked) {
                                await widget.database.removeLikePost(
                                    userId: user.uid, postId: widget.model.id);
                                isLiked = false;
                                setState(() {});
                              } else {
                                await widget.database.addLikePost(
                                    userId: user.uid, postId: widget.model.id);
                                isLiked = true;
                                setState(() {});
                              }
                            },
                            child: isLiked
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border_outlined,
                                    color: ColorsConstants.blackColor),
                          ),
                          Text(
                            widget.model.likes.length.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.message, color: Colors.grey),
                          Text(
                            widget.model.comments.length.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                        ],
                      )),
                      Text(
                        Jiffy(widget.model.time).fromNow(),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return SkeletonAnimation(
            child: skeleton(),
          );
        }
      },
    );
  }

  Row postHeader(AsyncSnapshot<MyUser> snapshot) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorsConstants.lightBlueColor,
                backgroundImage: snapshot.data.photoUrl != null
                    ? NetworkImage(snapshot.data.photoUrl)
                    : AssetImage("assets/images/avatar.png"),
                // radius: MediaQuery.of(context).size.width * 0.15,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Offstage(
                    offstage: !snapshot.data.isDoctor,
                    child: Text(
                      snapshot.data.specialization,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget skeleton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.grey[300]),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "",
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
