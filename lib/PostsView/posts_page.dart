import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:you_can/PostsView/Widgets.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("You Can", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Colors.black,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.near_me_sharp,color: Colors.black,)),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: (context,index)=>postItemBuilder(),
            separatorBuilder: (context,index)=>
                Container(width: double.infinity, height:10,color: Colors.grey[100],),
            itemCount: 10)
            ,

      ),

    );

  }
}
