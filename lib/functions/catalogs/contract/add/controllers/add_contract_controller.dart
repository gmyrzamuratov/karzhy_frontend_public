import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/models/contract.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class AddContractController extends GetxController {

  var contract = Contract().obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = tableContracts;
  String parentTableName = tableClients;

  AddContractController({Contract? initialContract}) {
    if(initialContract!=null) {
      contract = initialContract.obs;
    }
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  add() async {

    var data = contract.toJson();
    String companyId = Get.arguments["clientId"];
    db.addDocumentWithParentTable(parentTableName, companyId, tableName, data);
  }

  updateContract() async {

    var data = contract.toJson();
    String companyId = Get.arguments["clientId"];
    db.updateDocumentWithParentTable(parentTableName, companyId, tableName,
        contract.value.documentId!, data);
  }

}