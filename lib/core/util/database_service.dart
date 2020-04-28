import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ut_social/core/util/globals.dart';

// class DocumentField<T> {
//   final Firestore _db = Firestore.instance;
//   final String docPath;
//   DocumentReference ref = Global.docRefs[T];
//   final String field = Global.userFieldRefs[T];

//   DocumentField({this.docPath}){
//    // ref = _db.document(docPath);
//   }

//   Future<T> getData() {
//     return ref.get().then((v) => Global.models[T](v.data[field]) as T);
//   }

//   Stream<T> streamData() {
//     return ref.snapshots().map((v) => Global.models[T](v.data[field]) as T);
//   }

//   Future<List<String>> getListDataIds() async {
//     var temp = await ref.get();
//     if (temp.data.containsKey(field)) {
//       return (temp.data[field] as List).map((v) => v.toString()).toList();
//     }
//     return List<String>();
//   }

//   Future<void> upsert(dynamic data) {
//     return ref.updateData({field : data});
//   }
// }

class Document<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  DocumentReference ref;

  Document({this.path}) {
    ref = _db.document(path);
  }

  Future<T> getData() {
    return ref.get().then(
        (v) => Global.models[T](v.data..addAll({'id': v.documentID})) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map(
        (v) => Global.models[T](v.data..addAll({'id': v.documentID})) as T);
  }

  Future<void> upsert(Map data) {
    return ref.setData(
        Map<String, dynamic>.from(data..removeWhere((k, v) => k == 'id')),
        merge: true);
  }
}

class Collection<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    final QuerySnapshot snapshots = await ref.getDocuments();
    return snapshots.documents
        .map((DocumentSnapshot doc) => Global.models[T](doc.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((QuerySnapshot list) => list.documents
        .map((DocumentSnapshot doc) => Global.models[T](doc.data) as T)
        .toList());
  }
}

class UserData<T> {
  //final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({this.collection});

  // Stream<T> get documentStream {
  //   // return Observable(_auth.onAuthStateChanged).switchMap((user) {
  //   //   if (user != null) {
  //   //       Document<T> doc = Document<T>(path: '$collection/${user.uid}');
  //   //       return doc.streamData();
  //   //   } else {
  //   //       return Observable<T>.just(null);
  //   //   }
  //   });  //.shareReplay(maxSize: 1).doOnData((d) => print('777 $d'));// as Stream<T>;
  // }

  Future<T> getDocument() async {
    final FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      final Document<T> doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map<String, dynamic> data) async {
    final FirebaseUser user = await _auth.currentUser();
    final Document<T> ref = Document<T>(path: '$collection/${user.uid}');
    return ref.upsert(data);
  }
}
