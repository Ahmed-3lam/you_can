import 'package:flutter/foundation.dart';

class ArticleModel {
  ArticleModel({
    this.id,
    @required this.uid,
    this.title,
    this.body,
    this.haveImage,
    this.imageUrl,
    this.time,
    this.about,
  });
  final String id;
  final String uid;
  final String title;
  final String body;
  final bool haveImage;
  final String imageUrl;
  final String time;
  final String about;

  factory ArticleModel.fromMap(Map<dynamic, dynamic> value, String id) {
    return ArticleModel(
      id: id,
      uid: value['uid'],
      title: value['title'],
      body: value['body'],
      haveImage: value['haveImage'],
      imageUrl: value['imageUrl'],
      time: value['time'],
      about:  value['about'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'body': body,
      'haveImage': haveImage,
      'imageUrl': imageUrl,
      'time': time,
      'about': about,
    };
  }
}
