import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/ArticlesView/Widgets/article_item.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class MySaved extends StatelessWidget {
  final MyUser user;
  final FireStoreDatabase database;
  const MySaved({Key key, this.database, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My saved article',
                style: TextStyle(
                  color: ColorsConstants.blackColor,
                )),
            iconTheme: IconThemeData(
              color: ColorsConstants.blackColor,
            ),
            backgroundColor: ColorsConstants.whiteColor,
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            color: ColorsConstants.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("latest", style: TextStyle(fontSize: 18)),
                  ),
                  StreamBuilder<MyUser>(
                      stream: database.userStream(userId: user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.savedArticles.isEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 250),
                              child: Center(
                                child: Text("you havn\'t saved yet"),
                              ),
                            );
                          }

                          List data = snapshot.data.savedArticles;
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<ArticleModel>(
                                    stream:
                                        database.articleStream(id: data[index]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ArticleItem(
                                          model: snapshot.data,
                                          currentUser: user,
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    });
                              });
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
