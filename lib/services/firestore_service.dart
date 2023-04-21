import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {

  //Future<QuerySnapshot> getData(String tableName);
  Stream<QuerySnapshot<Object?>> getData(String tableName);

  Future<DocumentSnapshot> getDocumentById(String tableName, String id);

  Future<bool> addDocument(String tableName, dynamic data);

  Future<bool> updateDocument(String tableName, String referenceId, dynamic data);
}