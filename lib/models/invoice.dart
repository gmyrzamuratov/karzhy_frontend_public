import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karzhy_frontend/models/bank_account.dart';
import 'package:karzhy_frontend/models/client.dart';
import 'package:karzhy_frontend/models/company.dart';
import 'package:karzhy_frontend/models/contract.dart';
import 'package:karzhy_frontend/models/product.dart';

class Invoice {
  String? documentId;
  late String number;
  late DateTime created;
  late bool isDone;
  late Company company;
  late BankAccount bankAccount;
  late Client client;
  late Contract contract;
  late double total;
  late List<Product> products;

  Invoice({
    required this.number
  });

  Invoice.FromDoucmentSnapshot({
    required DocumentSnapshot documentSnapshot
  }) {
    this.documentId = documentSnapshot.id;
    this.number = documentSnapshot["number"];
    this.created = documentSnapshot["created"];
  }

  factory Invoice.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Timestamp created = data['created'];
    final List<dynamic> jsonList = json.decode(data["products"]);

    final List<Product> products = [];
    jsonList.forEach((element) {
      products.add(Product.fromJson(element));
    });

    var invoice = Invoice(
        number: data['number'],
    );
    invoice.documentId = doc.id;
    invoice.company = Company.fromJson(data['company']);
    invoice.bankAccount = BankAccount.fromJson(data['bankAccount']);
    invoice.client = Client.fromJson(data['client']);
    invoice.contract = Contract.fromJson(data["contract"]);
    invoice.created = created.toDate();
    invoice.total = data["total"];
    invoice.products = products;
    return invoice;
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "created": created,
    "company": company.toJson(),
    "client": client.toJson(),
    "bankAccount": bankAccount.toJson(),
    "contract": contract.toJson(),
    "total": total,
    "products": jsonEncode(products)
  };

}