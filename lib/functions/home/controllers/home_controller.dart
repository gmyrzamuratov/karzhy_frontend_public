import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/functions/invoice/new_invoice/view/invoice_view.dart';
import 'package:karzhy_frontend/models/invoice.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class HomeController extends GetxController {

  RxList<Invoice> invoices = <Invoice>[].obs;

  var db = FirestoreServiceImpl();
  late Stream<QuerySnapshot<Object?>> stream;
  String tableName = tableInvoices;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInvoices();
  }

  Future<void> loadInvoices() async {
    stream = db.getData(tableName);
    stream.listen((snapshot) {
      var list = <Invoice>[];
      isLoading.value = true;
      snapshot.docs.forEach((element) {
        var invoice = Invoice.fromFirestore(element);
        list.add(invoice);
      });
      invoices.value = list;
      isLoading.value = false;
    });
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  goToAddInvoiceView(Invoice? invoice) {
    Get.toNamed(InvoiceView.routeNamed, arguments: {"invoice": invoice});
  }

}