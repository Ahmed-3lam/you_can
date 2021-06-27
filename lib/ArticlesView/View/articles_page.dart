import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/ArticlesView/Widgets/article_item.dart';
import 'package:you_can/ArticlesView/Widgets/slider_item.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/data_base.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key key}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  int _current;

  List<String> abouts = ["health", "sport", "inspiration", "time"];
  List<String> aboutImage = [
    "assets/images/health.png",
    "assets/images/sports.png",
    "assets/images/inspiration.png",
    "assets/images/time.png"
  ];
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FireStoreDatabase>(context, listen: false);
    var currentUser = Provider.of<MyUser>(context, listen: false);
    print("${currentUser.uid}  is user in artilce page");
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Articles',
                style: TextStyle(
                  color: ColorsConstants.blackColor,
                )),
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
                  Text("Find Your ", style: TextStyle(fontSize: 22)),
                  Text("Favorite Article", style: TextStyle(fontSize: 22)),
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
                    itemCount: abouts.length,
                    itemBuilder: (context, index, first) {
                      return SliderItem(
                        current: _current,
                        index: index,
                        about: abouts[index],
                        sliderImage: aboutImage[index],
                        dataBase: database,
                        currentUser: currentUser,
                      );
                    },
                    // items: imageSliders,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("latest", style: TextStyle(fontSize: 18)),
                  ),
                  StreamBuilder<List<ArticleModel>>(
                      stream: database.articlesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ArticleItem(
                                  model: snapshot.data[index],
                                  currentUser: currentUser,
                                );
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
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
