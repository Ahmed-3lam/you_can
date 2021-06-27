import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/comment_model.dart';
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
  Future<void> addLikePost({String postId, String userId});
  Future<void> removeLikePost({String postId, String userId});
  Stream<ArticleModel> articleStream({@required String id});
  Stream<List<PostModel>> postsStream();
  Stream<List<PostModel>> userPostsStream(String uid);
  Future<String> setComment(CommentModel model);
  Future<void> addCommentToPost({String postId, String commentId});
  Stream<CommentModel> commentStream({@required String commentId});
  Stream<PostModel> postStream({@required String pid});

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

  @override
  Stream<List<PostModel>> postsStream() => _service.collectionStream(
        path: APIPath.posts(),
        builder: (data, documentId) => PostModel.fromMap(data, documentId),
      );

  @override
  Future<void> addLikePost({String postId, String userId}) =>
      _service.setItemToList(
          path: APIPath.posts(),
          docId: postId,
          listName: "likes",
          data: userId);

  @override
  Future<void> removeLikePost({String postId, String userId}) =>
      _service.removeItemFromList(
          path: APIPath.posts(),
          docId: postId,
          listName: "likes",
          data: userId);

  @override
  Stream<List<PostModel>> userPostsStream(String uid) =>
      _service.collectionStream<PostModel>(
        path: APIPath.posts(),
        queryBuilder:
            uid != null ? (query) => query.where('uid', isEqualTo: uid) : null,
        builder: (data, documentID) => PostModel.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );

  @override
  Future<String> setComment(CommentModel model) async {
    String reference = await _service.setDataWithoutPathSnap(
      path: APIPath.comments(),
      data: model.toMap(),
    );
    return reference;
  }

  @override
  Future<void> addCommentToPost({String postId, String commentId}) =>
      _service.setItemToList(
          path: APIPath.posts(),
          docId: postId,
          listName: "comments",
          data: commentId);

  @override
  Stream<CommentModel> commentStream({String commentId}) =>
      _service.documentStream(
        path: APIPath.comment(commentId),
        builder: (data, documentId) => CommentModel.fromMap(data, documentId),
      );

  @override
  Stream<PostModel> postStream({String pid}) =>
      _service.documentStream(
        path: APIPath.post(pid),
        builder: (data, documentId) => PostModel.fromMap(data, documentId),
      );
}
