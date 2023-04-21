import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String? documentId;
  String? name;
  String? bin;
  String? address;
  String? kbe;
  String? bankName;
  String? bankAccount;
  int? companyType = 0;

  Company({
    this.documentId,
    this.name,
    this.bin,
    this.address,
    this.kbe,
    this.bankName,
    this.bankAccount,
    this.companyType
  });

  Company.FromDoucmentSnapshot({
    required DocumentSnapshot documentSnapshot
  }) {
    this.documentId = documentSnapshot.id;
    this.name = documentSnapshot["name"];
    this.bin = documentSnapshot["bin"];
    this.address = documentSnapshot["address"];
    this.kbe = documentSnapshot["kbe"];
    this.bankName = documentSnapshot["bankName"];
    this.bankAccount = documentSnapshot["bankAccount"];
    this.companyType = documentSnapshot["companyType"];
  }

  factory Company.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Company(
      documentId: doc.id,
      name: data['name'] ?? '',
      bin: data['bin'] ?? '',
      address: data['address'] ?? '',
      kbe: data['kbe'] ?? '',
      bankName: data['bankName'] ?? '',
      bankAccount: data['bankAccount'] ?? '',
      companyType: data['companyType']
    );
  }

  Company.fromJson(Map<String, dynamic> json) {
    documentId = json["id"];
    name = json["name"];
    bin = json["bin"];
    address = json["address"];
    kbe = json["kbe"];
    bankName = json["bankName"];
    bankAccount = json["bankAccount"];
    companyType = json["companyType"];
  }

  Map<String, dynamic> toJson() => {
    "documentId": documentId,
    "name": name,
    "bin": bin,
    "address": address,
    "kbe": kbe,
    "bankName": bankName,
    "bankAccount": bankAccount,
    "companyType": companyType
  };

}