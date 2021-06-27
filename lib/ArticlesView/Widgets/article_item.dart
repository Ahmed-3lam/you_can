import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/ArticlesView/View/aricle_detail.dart';
import 'package:you_can/Models/user.dart';

class ArticleItem extends StatelessWidget {
  final ArticleModel model;
  final MyUser currentUser;
  const ArticleItem({Key key, @required this.model, this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleDetail(
                    model: model,
                    currentUser: currentUser,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: model.haveImage
                          ? NetworkImage(model.imageUrl)
                          : AssetImage("assets/images/Group.png"),
                    ),
                    color: Color(0xFF74BDCB),
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(model.about, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text(model.title, style: TextStyle(fontSize: 20))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
