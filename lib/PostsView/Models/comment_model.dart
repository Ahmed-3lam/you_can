import 'package:flutter/foundation.dart';

class CommentModel {
  CommentModel({
    @required this.uid,
    this.id,
    this.body,
    this.time,
  });

  final String id;
  final String uid;
  final String body;
  final String time;

  factory CommentModel.fromMap(Map<dynamic, dynamic> value, String id) {
    return CommentModel(
      id: id,
      uid: value['uid'],
      body: value['body'],
      time: value['time'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'body': body,
      'time': time,
    };
  }
}
