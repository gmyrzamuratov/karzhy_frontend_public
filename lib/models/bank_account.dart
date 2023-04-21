import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karzhy_frontend/models/bank.dart';

class BankAccount {
  String? documentId;
  //String? name;
  String? iban;
  Bank? bank;

  BankAccount({
    this.documentId,
    //this.name,
    this.iban,
    this.bank
  });

  BankAccount.FromDoucmentSnapshot({
    required DocumentSnapshot documentSnapshot
  }) {
    documentId = documentSnapshot.id;
    //name = documentSnapshot["name"];
    iban = documentSnapshot["iban"];
    bank = Bank(
        documentId: documentSnapshot["bank_id"],
      name: documentSnapshot["bank_name"],
      swift: documentSnapshot["bank_swift"],
    );
  }

  factory BankAccount.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BankAccount(
        documentId: doc.id,
        //name: data['name'] ?? '',
        iban: data['iban'] ?? '',
        bank: Bank(
          documentId: data["bank_id"],
          name: data["bank_name"],
          swift: data["bank_swift"],
        )
    );
  }

  BankAccount.fromJson(Map<String, dynamic> json) {
    documentId = json["documentId"];
    iban = json["iban"];
    bank = Bank(
      documentId: json["bank_id"],
      name: json["bank_name"],
      swift: json["bank_swift"],
    );
  }

  Map<String, dynamic> toJson() => {
    "documentId": documentId,
    "name": name,
    "iban": iban,
    "bank_id": bank!.documentId,
    "bank_name": bank!.name,
    "bank_swift": bank!.swift
  };

  String? get name => iban == null || bank == null || bank!.name == null ? null :
  "${iban!} (${bank?.name!})";

}