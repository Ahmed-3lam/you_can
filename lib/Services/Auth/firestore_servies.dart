import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreService {
  //private constructor
  FireStoreService._();
  static final instance = FireStoreService._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print("$path : $data");
    await reference.set(data);
  }

  Future<void> updateData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print("$path : $data");
    await reference.update(data);
  }

  Future<void> setDataWithoutPath({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path);
    print("$path : $data");
    await reference.add(data);
  }

  Future<void> setItemToList({
    @required String path,
    @required String docId,
    @required String listName,
    @required String data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path).doc(docId);
    print("$path : $docId");
    await reference.update({
      listName: FieldValue.arrayUnion([data])
    });
  }

  Future<void> removeItemFromList({
    @required String path,
    @required String docId,
    @required String listName,
    @required String data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path).doc(docId);
    print("$path : $docId");
    await reference.update({
      listName: FieldValue.arrayRemove([data])
    });
  }

  Future<String> setDataSnap({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print("$path : $data");
    await reference.set(data);
    return reference.id;
  }

  Future<String> setDataWithoutPathSnap({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path);
    print("$path : $data");
    DocumentReference ref = await reference.add(data);
    return ref.id.toString();
  }

  // Stream<List<T>> collectionStream<T>({
  //   @required String path,
  //   @required T builder(Map<String, dynamic> data, String documentId),
  // }) {
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map((snapshot) => snapshot.docs
  //       .map(
  //         (snapshot) => builder(snapshot.data(), snapshot.id),
  //       )
  //       .toList());
  // }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

//
//   Stream<T> documentReferenceStream<T>({
//     @required DocumentReference path,
//     @required T builder(Map<String, dynamic> data, String documentID),
//   }) {
//     final DocumentReference reference = path;
//     final Stream<DocumentSnapshot> snapshots = reference.snapshots();
//     return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
//   }
//
//   Stream<T> docStream<T>({
//     @required String path,
//     @required T builder(Map<String, dynamic> data, String documentID),
//   }) {
//     final DocumentReference reference = FirebaseFirestore.instance.doc(path);
//     final Stream<DocumentSnapshot> snapshots = reference.snapshots();
//     return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
//   }
//
//   Stream<List<T>> collectionStream<T>({
//     @required String path,
//     @required T builder(Map<String, dynamic> data, String documentID),
//     Query queryBuilder(Query query),
//     int sort(T lhs, T rhs),
//   }) {
//     Query query = FirebaseFirestore.instance.collection(path);
//     if (queryBuilder != null) {
//       query = queryBuilder(query);
//     }
//     try {
//       final Stream<QuerySnapshot> snapshots = query.snapshots();
//       return snapshots.map((snapshot) {
//         final result = snapshot.docs
//             .map((snapshot) => builder(snapshot.data(), snapshot.id))
//             .where((value) => value != null)
//             .toList();
// //        if (sort != null) {
// //          result.sort(sort);
// //        }
//         return result;
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
}
