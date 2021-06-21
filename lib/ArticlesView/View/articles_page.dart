import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:you_can/ArticlesView/Widgets/article_item.dart';
import 'package:you_can/ArticlesView/Widgets/slider_item.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  int _current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Color(0xFFAAD6A0).withOpacity(0.5),
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.search),
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              color: Color(0xFFAAD6A0).withOpacity(0.5),
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              color: Color(0xFFAAD6A0).withOpacity(0.5),
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color(0xFFAAD6A0).withOpacity(0.5)),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          )),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: CircleAvatar(
                        radius: 25, backgroundColor: Color(0xFF74BDCB)),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  Text("Find Your ", style: TextStyle(fontSize: 26)),
                  Text("Favorite Article", style: TextStyle(fontSize: 26)),
                  SizedBox(height: 10),
                  CarouselSlider.builder(
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        aspectRatio: 1.5,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        pageSnapping: true),
                    itemCount: 5,
                    itemBuilder: (context, index, first) {
                      return SliderItem(current: _current, index: index);
                    },
                    // items: imageSliders,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child:
                        Text("Recommended for you", style: TextStyle(fontSize: 20)),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return ArticleItem();
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
