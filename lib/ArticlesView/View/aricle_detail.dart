import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class ArticleDetail extends StatefulWidget {
  final ArticleModel model;
  final MyUser currentUser;

  const ArticleDetail({Key key, @required this.model, this.currentUser})
      : super(key: key);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  bool isSaved;
  @override
  void initState() {
    super.initState();
    isSaved = widget.currentUser.savedArticles.contains(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FireStoreDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsConstants.blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            onTap: () async {
              print("users/${widget.currentUser.uid}");
              if (isSaved) {
                await database.removeSavedArticle(
                    userId: widget.currentUser.uid, articleId: widget.model.id);
                isSaved = false;
                setState(() {});
              } else {
                await database.addSavedArticle(
                    userId: widget.currentUser.uid, articleId: widget.model.id);
                isSaved = true;
                setState(() {});
              }
            },
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(width: 25)
        ],
      ),
      body: StreamBuilder<MyUser>(
        stream: database.userStream(userId: widget.model.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.model.about, style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(widget.model.title,
                        style: TextStyle(fontSize: 24)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorsConstants.lightBlueColor,
                        backgroundImage: snapshot.data.photoUrl != null
                            ? NetworkImage(snapshot.data.photoUrl)
                            : AssetImage("assets/images/avatar.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 25),
                      Text(snapshot.data.name, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Jiffy(widget.model.time).fromNow(),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Offstage(
                    offstage: !widget.model.haveImage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: widget.model.haveImage
                                  ? NetworkImage(widget.model.imageUrl)
                                  : AssetImage("assets/images/Group.png"),
                            )),
                      ),
                    ),
                  ),
                  Text(widget.model.body),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
