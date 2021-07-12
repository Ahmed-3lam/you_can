import 'package:flutter/foundation.dart';

class PostModel {
  PostModel({
    @required this.uid,
    this.id,
    this.body,
    this.haveImage,
    this.imageUrl,
    this.time,
    this.likes,
    this.comments,
  });

  final String id;
  final String uid;
  final String body;
  final bool haveImage;
  final String imageUrl;
  final String time;
  final List likes;
  final List comments;

  factory PostModel.fromMap(Map<dynamic, dynamic> value, String id) {
    return PostModel(
      id: id,
      uid: value['uid'],
      body: value['body'],
      haveImage: value['haveImage'],
      imageUrl: value['imageUrl'],
      time: value['time'],
      likes: value['likes'],
      comments: value['comments'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'body': body,
      'haveImage': haveImage,
      'imageUrl': imageUrl,
      'time': time,
      'likes': likes,
      'comments': comments
    };
  }
}
