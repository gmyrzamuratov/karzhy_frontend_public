import 'package:get/get.dart';
import 'package:karzhy_frontend/models/company.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class AddCompanyController extends GetxController {

  var company = Company().obs;

  RxBool isLoading = false.obs;

  var db = FirestoreServiceImpl();
  String tableName = "companies";

  AddCompanyController({Company? initialCompany}) {
    if(initialCompany!=null) {
      company = initialCompany.obs;
    }
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  add() async {
    var data = company.value.toJson();
    db.addDocument(tableName, data);
  }

  updateCompany() async {
    var data = company.value.toJson();
    db.updateDocument(tableName, company.value.documentId!, data);
  }

}