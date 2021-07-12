import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/comment_model.dart';
import 'package:you_can/PostsView/Models/post_model.dart';
import 'package:you_can/PostsView/comment_item.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    Key key,
    // @required this.list,
    @required this.user,
    @required this.postId,
  }) : super(key: key);

  // final List list;
  final MyUser user;
  final String postId;
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var dataBase = Provider.of<FireStoreDatabase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "comments",
          style: TextStyle(
            color: ColorsConstants.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsConstants.whiteColor,
        iconTheme: IconThemeData(
          color: ColorsConstants.blackColor,
        ),
      ),
      backgroundColor: ColorsConstants.whiteColor,
      body: StreamBuilder<PostModel>(
        stream: dataBase.postStream(pid: widget.postId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data.comments;
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 12,
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<CommentModel>(
                            stream: dataBase.commentStream(
                              commentId: list[index],
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CommentItem(model: snapshot.data);
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      )),
                  Positioned(
                    bottom: 0,
                    height: 70,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 70,
                      child: Center(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorsConstants.lightBlueColor,
                              backgroundImage: widget.user.photoUrl != null
                                  ? NetworkImage(widget.user.photoUrl)
                                  : AssetImage("assets/images/avatar.png"),
                              radius: 25,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText: "enter your comment",
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        CommentModel model = CommentModel(
                                          uid: widget.user.uid,
                                          body: commentController.text,
                                          time:
                                              DateTime.now().toIso8601String(),
                                        );
                                        String ref =
                                            await dataBase.setComment(model);
                                        await dataBase.addCommentToPost(
                                            postId: widget.postId,
                                            commentId: ref);
                                        commentController.text = "";
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        color: ColorsConstants.lightBlueColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
