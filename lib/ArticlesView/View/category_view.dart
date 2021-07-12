import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/ArticlesView/Widgets/article_item.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key key,
    this.database,
    this.currentUser,
    this.about,
  }) : super(key: key);

  final FireStoreDatabase database;
  final MyUser currentUser;
  final String about;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          about,
          style: TextStyle(color: ColorsConstants.blackColor),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorsConstants.blackColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: StreamBuilder<List<ArticleModel>>(
            stream: database.articlesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data
                    .where((element) => element.about == about)
                    .toList();
                if (data.isEmpty) {
                  return Center(
                    child: Text("there is no articles right now"),
                  );
                }
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ArticleItem(
                        model: data[index],
                        currentUser: currentUser,
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
