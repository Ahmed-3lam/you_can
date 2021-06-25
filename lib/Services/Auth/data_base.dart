import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/post_model.dart';
import 'package:you_can/Services/Auth/api_path.dart';
import 'package:you_can/Services/Auth/firestore_servies.dart';

abstract class Database {
  Future<void> setUser(MyUser user, String uid);
  Future<void> setPost(PostModel model);
  Future<void> setArticle(ArticleModel model);
  Stream<MyUser> userStream({@required String userId});
}

class FireStoreDatabase implements Database {
  final _service = FireStoreService.instance;

  @override
  Future<void> setUser(MyUser user, String uid) async => await _service.setData(
        path: APIPath.users(uid),
        data: user.toMap(),
      );

  @override
  Future<void> setPost(PostModel model) async =>
      await _service.setDataWithoutPath(
        path: APIPath.posts(),
        data: model.toMap(),
      );

  @override
  Future<void> setArticle(ArticleModel model) async =>
      await _service.setDataWithoutPath(
        path: APIPath.articles(),
        data: model.toMap(),
      );

  @override
  Stream<MyUser> userStream({@required String userId}) =>
      _service.documentStream(
        path: APIPath.users(userId),
        builder: (data, documentId) => MyUser.fromMap(data, documentId),
      );
}
