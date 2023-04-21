import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String? documentId;
  String? name;
  String? bin;
  String? address;

  Client({
    this.documentId,
    this.name,
    this.bin,
    this.address
  });

  Client.FromDoucmentSnapshot({
    required DocumentSnapshot documentSnapshot
  }) {
    this.documentId = documentSnapshot.id;
    this.name = documentSnapshot["name"];
    this.bin = documentSnapshot["bin"];
    this.address = documentSnapshot["address"];
  }

  factory Client.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Client(
        documentId: doc.id,
        name: data['name'] ?? '',
        bin: data['bin'] ?? '',
        address: data['address'] ?? ''
    );
  }

  Client.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    name = json['name'];
    bin = json['bin'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() => {
    "documentId": documentId,
    "name": name,
    "bin": bin,
    "address": address,
  };

}