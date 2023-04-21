import 'package:get/get.dart';
import 'package:karzhy_frontend/models/client.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class AddClientController extends GetxController {

  var client = Client(name: '').obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = "clients";
  String parentTableName = "companies";

  AddClientController({Client? initialClient}) {
    if(initialClient!=null) {
      client = initialClient.obs;
    }
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  add() async {
    var data = {
      "name": client.value.name,
      "bin": client.value.bin,
      "address": client.value.address
    };
    String companyId = Get.arguments["companyId"];
    db.addDocumentWithParentTable(parentTableName, companyId, tableName, data);
  }

  updateClient() async {
    var data = {
      "name": client.value.name,
      "bin": client.value.bin,
      "address": client.value.address
    };
    String companyId = Get.arguments["companyId"];
    db.updateDocumentWithParentTable(parentTableName, companyId, tableName, client.value.documentId!, data);
  }

}