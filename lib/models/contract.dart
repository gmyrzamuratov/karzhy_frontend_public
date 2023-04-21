import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karzhy_frontend/models/bank.dart';

class Contract {
  String? documentId;
  String? name;

  Contract({
    this.documentId,
    this.name
  });

  Contract.FromDoucmentSnapshot({
    required DocumentSnapshot documentSnapshot
  }) {
    documentId = documentSnapshot.id;
    name = documentSnapshot["name"];
  }

  factory Contract.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Contract(
        documentId: doc.id,
        name: data['name'] ?? ''
    );
  }

  Contract.fromJson(Map<String, dynamic> json) {
    documentId = json["documentId"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() => {
    "documentId": documentId,
    "name": name
  };

}