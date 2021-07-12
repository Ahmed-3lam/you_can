import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/post_model.dart';
import 'package:you_can/PostsView/post_item.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataBase = Provider.of<FireStoreDatabase>(context, listen: false);
    var user = Provider.of<MyUser>(context, listen: false);
    print("${user.uid}  is user in post page");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "You Can",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<PostModel>>(
          stream: dataBase.postsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => PostItem(
                  model: snapshot.data[index],
                  // user: user,
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
