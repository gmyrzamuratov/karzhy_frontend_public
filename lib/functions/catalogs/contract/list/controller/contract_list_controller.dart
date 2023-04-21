import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/functions/catalogs/contract/add/view/add_contract_view.dart';
import 'package:karzhy_frontend/models/contract.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class ContractListController extends GetxController {

  var contracts = <Contract>[].obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = tableContracts;
  String parentTableName = tableClients;
  late String parentTableId;
  late Stream<QuerySnapshot<Object?>> stream;

  @override
  void onInit() {
    super.onInit();
    loadContracts();
  }

  Future<void> loadContracts() async {
    parentTableId = Get.arguments["clientId"]!;
    stream = db.getDataWithParentTable(tableName, parentTableName, parentTableId);
    stream.listen((snapshot) {
      var list = <Contract>[];
      isLoading.value = true;
      snapshot.docs.forEach((element) {
        var contract = Contract.fromFirestore(element);
        list.add(contract);
      });
      contracts.value = list;
      isLoading.value = false;
    });
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  goToAddContractView(Contract? contract) {
    parentTableId = Get.arguments["clientId"]!;
    Get.toNamed(AddContractView.routeNamed, arguments: {"clientId": parentTableId, "contract": contract});
  }

}