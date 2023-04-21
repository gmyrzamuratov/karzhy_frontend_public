import 'package:cloud_firestore/cloud_firestore.dart';

class Bank {
  String? documentId;
  String? name;
  String? swift;

  Bank({
    this.documentId,
    this.name,
    this.swift
  });

  Bank.FromDoucmentSnapshot({
    required DocumentSnapshot documentSnapshot
  }) {
    this.documentId = documentSnapshot.id;
    this.name = documentSnapshot["name"];
    this.swift = documentSnapshot["swift"];
  }

  factory Bank.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Bank(
        documentId: doc.id,
        name: data['name'] ?? '',
        swift: data['swift'] ?? ''
    );
  }

  Map<String, dynamic> toJson() => {
    "documentId": documentId,
    "name": name,
    "swift": swift,
  };

}