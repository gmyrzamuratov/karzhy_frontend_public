import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/models/bank.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class BankListController extends GetxController {

  var banks = <Bank>[].obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = tableBanks;
  late Stream<QuerySnapshot<Object?>> stream;

  @override
  void onInit() {
    super.onInit();
    loadBanks();
  }

  Future<void> loadBanks() async {
    stream = db.getCommonData(tableName);
    stream.listen((snapshot) {
      var list = <Bank>[];
      isLoading.value = true;
      snapshot.docs.forEach((element) {
        var account = Bank.fromFirestore(element);
        list.add(account);
      });
      banks.value = list;
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