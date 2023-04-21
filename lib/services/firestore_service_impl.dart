import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karzhy_frontend/constants.dart';

import 'firestore_service.dart';

class FirestoreServiceImpl implements FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String userTable = "users";

  @override
  Stream<QuerySnapshot<Object?>> getCommonData(String tableName) {
    CollectionReference list = firestore
        .collection(tableName);

    return list.snapshots();
  }

  @override
  Stream<QuerySnapshot<Object?>> getData(String tableName) {
    CollectionReference list = firestore
        .collection(userTable)
        .doc(auth.currentUser!.uid)
        .collection(tableName);

    return list.snapshots();
  }

  @override
  Stream<QuerySnapshot<Object?>> getDataWithParentTable(
      String tableName, String parentTableName, String parentTableId) {
    CollectionReference list = firestore
        .collection(userTable)
        .doc(auth.currentUser!.uid)
        .collection(parentTableName)
        .doc(parentTableId)
        .collection(tableName);

    return list.snapshots();
  }

  @override
  Future<DocumentSnapshot> getDocumentById(String tableName, String id) async {
    CollectionReference users = firestore.collection(tableName);
    DocumentSnapshot snapshot = await users.doc(id).get();

    return snapshot;
  }

  @override
  Future<bool> addDocument(String tableName, dynamic data) async {
    CollectionReference table = firestore
        .collection(userTable)
        .doc(auth.currentUser!.uid)
        .collection(tableName);
    await table.add(data);

    return true;
  }

  @override
  Future<bool> updateDocument(
      String tableName, String referenceId, dynamic data) async {
    CollectionReference table = firestore
        .collection(userTable)
        .doc(auth.currentUser!.uid)
        .collection(tableName);
    await table.doc(referenceId).set(data);
    return true;
  }

  @override
  Future<bool> addDocumentWithParentTable(String parentTableName,
      String parentTableId, String tableName, dynamic data) async {
    CollectionReference table = firestore
        .collection(userTable)
        .doc(auth.currentUser!.uid)
        .collection(parentTableName)
        .doc(parentTableId)
        .collection(tableName);
    await table.add(data);

    return true;
  }

  @override
  Future<bool> updateDocumentWithParentTable(String parentTableName,
      String parentTableId, String tableName, String documentId, dynamic data) async {
    CollectionReference table = firestore
        .collection(userTable)
        .doc(auth.currentUser!.uid)
        .collection(parentTableName)
        .doc(parentTableId)
        .collection(tableName);
    await table.doc(documentId).set(data);

    return true;
  }

}
