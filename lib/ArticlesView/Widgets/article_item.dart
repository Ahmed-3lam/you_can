import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/View/aricle_detail.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleDetail()),
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
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Group.png"),
                    ),
                    color: Color(0xFF74BDCB),
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Health", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text("10 tips To improve your health",
                          style: TextStyle(fontSize: 20))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.bookmark_border_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
