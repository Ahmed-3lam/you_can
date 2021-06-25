import 'package:flutter/foundation.dart';

class ArticleModel {
  ArticleModel({
    @required this.uid,
    this.body,
    this.haveImage,
    this.imageUrl,
    this.time,
    this.about,
  });

  final String uid;
  final String body;
  final bool haveImage;
  final String imageUrl;
  final String time;
  final String about;

  factory ArticleModel.fromMap(Map<dynamic, dynamic> value, String id) {
    return ArticleModel(
      uid: value['uid'],
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
      'body': body,
      'haveImage': haveImage,
      'imageUrl': imageUrl,
      'time': time,
      'about': about,
    };
  }
}
