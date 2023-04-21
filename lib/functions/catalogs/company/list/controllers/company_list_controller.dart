import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/models/company.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class CompanyListController extends GetxController {

  var companies = <Company>[].obs;

  RxBool isLoading = true.obs;

  var db = FirestoreServiceImpl();
  String tableName = "companies";
  late Stream<QuerySnapshot<Object?>> stream;

  @override
  void onInit() {
    super.onInit();
    loadCompanies();
  }

  Future<void> loadCompanies() async {
    stream = db.getData(tableName);
    stream.listen((snapshot) {
      var list = <Company>[];
      isLoading.value = true;
      snapshot.docs.forEach((element) {
        var company = Company.fromFirestore(element);
        list.add(company);
      });
      companies.value = list;
      isLoading.value = false;
    });
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

}