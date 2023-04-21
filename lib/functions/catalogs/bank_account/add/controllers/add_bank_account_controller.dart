import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/functions/catalogs/bank/list/view/bank_list_view.dart';
import 'package:karzhy_frontend/models/bank.dart';
import 'package:karzhy_frontend/models/bank_account.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class AddBankAccountController extends GetxController {

  var bankAccount = BankAccount().obs;
  var bank = Bank().obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = tableBankAccounts;
  String parentTableName = tableCompanies;

  AddBankAccountController({BankAccount? initialBankAccount}) {
    if(initialBankAccount!=null) {
      bankAccount = initialBankAccount.obs;
    }
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  add() async {

    var data = bankAccount.toJson();
    String companyId = Get.arguments["companyId"];
    db.addDocumentWithParentTable(parentTableName, companyId, tableName, data);
  }

  updateBankAccount() async {

    var data = bankAccount.toJson();
    String companyId = Get.arguments["companyId"];
    db.updateDocumentWithParentTable(parentTableName, companyId, tableName,
        bankAccount.value.documentId!, data);
  }

  goToBankListView() async {
    var selectedBank = await Get.toNamed(BankListView.routeNamed);
    if(selectedBank != null) {
      bankAccount.value.bank = selectedBank;
      bank.value = selectedBank;
    }
  }

}