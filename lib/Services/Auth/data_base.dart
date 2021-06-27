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
  Future<void> updateUser(MyUser user, String uid);
  Future<void> updateUserImage(MyUser user, String uid);
  Stream<List<ArticleModel>> articlesStream();
  Future<void> addSavedArticle({String articleId, String userId});
  Future<void> removeSavedArticle({String articleId, String userId});
  Stream<ArticleModel> articleStream({@required String id});
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

  @override
  Future<void> updateUser(MyUser user, String uid) async =>
      await _service.updateData(
        path: APIPath.users(uid),
        data: user.withOutImageToMap(),
      );

  @override
  Future<void> updateUserImage(MyUser user, String uid) async =>
      await _service.updateData(
        path: APIPath.users(uid),
        data: user.imageToMap(),
      );

  @override
  Stream<List<ArticleModel>> articlesStream() => _service.collectionStream(
        path: APIPath.articles(),
        builder: (data, documentId) => ArticleModel.fromMap(data, documentId),
      );

  @override
  Future<void> addSavedArticle({String articleId, String userId}) =>
      _service.setItemToList(
          path: APIPath.user(),
          docId: userId,
          listName: "savedArticles",
          data: articleId);

  @override
  Future<void> removeSavedArticle({String articleId, String userId}) =>
      _service.removeItemFromList(
          path: APIPath.user(),
          docId: userId,
          listName: "savedArticles",
          data: articleId);

  @override
  Stream<ArticleModel> articleStream({String id}) => _service.documentStream(
        path: APIPath.article(id),
        builder: (data, documentId) => ArticleModel.fromMap(data, documentId),
      );
}
