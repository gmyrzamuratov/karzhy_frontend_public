import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/client/add/view/add_client_view.dart';
import 'package:karzhy_frontend/models/client.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class ClientListController extends GetxController {

  var clients = <Client>[].obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = "clients";
  String parentTableName = "companies";
  late String parentTableId;
  late Stream<QuerySnapshot<Object?>> stream;

  @override
  void onInit() {
    super.onInit();
    loadClients();
  }

  Future<void> loadClients() async {
    parentTableId = Get.arguments["companyId"]!;
    stream = db.getDataWithParentTable(tableName, parentTableName, parentTableId);
    stream.listen((snapshot) {
      var list = <Client>[];
      isLoading.value = true;
      snapshot.docs.forEach((element) {
        var client = Client.fromFirestore(element);
        list.add(client);
      });
      clients.value = list;
      isLoading.value = false;
    });
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  goToAddClientView(Client? client) {
    parentTableId = Get.arguments["companyId"]!;
    Get.toNamed(AddClientView.routeNamed, arguments: {"companyId": parentTableId, "client": client});
  }

}