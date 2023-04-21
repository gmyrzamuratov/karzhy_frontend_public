import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/functions/catalogs/bank_account/add/view/add_bank_account_view.dart';
import 'package:karzhy_frontend/models/bank_account.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class BankAccountListController extends GetxController {

  var bankAccounts = <BankAccount>[].obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = tableBankAccounts;
  String parentTableName = tableCompanies;
  late String parentTableId;
  late Stream<QuerySnapshot<Object?>> stream;

  @override
  void onInit() {
    super.onInit();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    parentTableId = Get.arguments["companyId"]!;
    stream = db.getDataWithParentTable(tableName, parentTableName, parentTableId);
    stream.listen((snapshot) {
      var list = <BankAccount>[];
      isLoading.value = true;
      snapshot.docs.forEach((element) {
        var account = BankAccount.fromFirestore(element);
        list.add(account);
      });
      bankAccounts.value = list;
      isLoading.value = false;
    });
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  goToAddBankAccountView(BankAccount? bankAccount) {
    parentTableId = Get.arguments["companyId"]!;
    Get.toNamed(AddBankAccountView.routeNamed, arguments: {"companyId": parentTableId, "bank_account": bankAccount});
  }

}