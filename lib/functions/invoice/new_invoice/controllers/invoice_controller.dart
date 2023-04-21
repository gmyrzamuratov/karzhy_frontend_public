import 'package:get/get.dart';
import 'package:karzhy_frontend/constants.dart';
import 'package:karzhy_frontend/functions/catalogs/bank_account/list/view/bank_account_list.dart';
import 'package:karzhy_frontend/functions/catalogs/client/list/view/client_list_view.dart';
import 'package:karzhy_frontend/functions/catalogs/contract/list/view/contract_list.dart';
import 'package:karzhy_frontend/functions/catalogs/product/view/product_view.dart';
import 'package:karzhy_frontend/functions/invoice/invoice_preview/view/invoice_preview_view.dart';
import 'package:karzhy_frontend/models/bank_account.dart';
import 'package:karzhy_frontend/models/client.dart';
import 'package:karzhy_frontend/models/company.dart';
import 'package:karzhy_frontend/models/contract.dart';
import 'package:karzhy_frontend/models/invoice.dart';
import 'package:karzhy_frontend/models/product.dart';
import 'package:karzhy_frontend/services/firestore_service_impl.dart';

class InvoiceController extends GetxController {
  String? documentId;
  var docNumber = ''.obs;
  var date = DateTime.now().obs;
  var client = Client().obs;
  var company = Company().obs;
  var bankAccount = BankAccount().obs;
  var contract = Contract().obs;
  var total = 0.00.obs;
  RxList<Product> products = <Product>[].obs;
  var db = FirestoreServiceImpl();
  String tableName = tableInvoices;

  InvoiceController({Invoice? initialInvoice}) {
    if(initialInvoice!=null) {
      documentId = initialInvoice.documentId;
      docNumber = initialInvoice.number.obs;
      date = initialInvoice.created.obs;
      company = initialInvoice.company.obs;
      client = initialInvoice.client.obs;
      bankAccount = initialInvoice.bankAccount.obs;
      contract = initialInvoice.contract.obs;
      total = initialInvoice.total.obs;
      products = initialInvoice.products.obs;
    }
  }

  void addProduct(Product product) {
    products.add(product);
    EvaluateTotal();
  }

  void editProduct(int index, Product product) {
    products[index] = product;
    EvaluateTotal();
  }

  void deleteProduct(int index) {
    products.removeAt(index);
    EvaluateTotal();
  }

  void EvaluateTotal() {
    double amount = 0;
    products.forEach((product) {
      amount += product.quantity*product.price;
    });
    total.value = amount;
  }

  Future<void> goToInvoicePreviewView() async {

    var invoice = Invoice(number: docNumber.value);
    invoice.documentId = documentId;
    invoice.company = company.value;
    invoice.bankAccount = bankAccount.value;
    invoice.client = client.value;
    invoice.contract = contract.value;
    invoice.created = date.value;
    invoice.total = total.value;
    invoice.products = products.value;

    Get.toNamed(InvoicePreviewView.routeNamed,
        arguments: {"invoice": invoice});
  }

  Future<void> goToClientListView() async {
    var selectedClient = await Get.toNamed(ClientListView.routeNamed,
        arguments: {"companyId": company.value.documentId!});
    if(selectedClient != null) {
      client.value = selectedClient;
    }
  }

  Future<void> goToBankAccountListView() async {
    var selectedAccount = await Get.toNamed(BankAccountListView.routeNamed,
        arguments: {"companyId": company.value.documentId!});
    if(selectedAccount != null) {
      bankAccount.value = selectedAccount;
    }
  }

  Future<void> goToContractListView() async {
    var selectedContract = await Get.toNamed(ContractListView.routeNamed,
        arguments: {"clientId": client.value.documentId!});
    if(selectedContract != null) {
      contract.value = selectedContract;
    }
  }

  Future<void> goToProductView(int? index) async {
    var product = index!=null ? products[index] : null;
    var selectedProduct = await Get.toNamed(ProductView.routeNamed,
        arguments: {"product": product});
    if(selectedProduct != null) {
      if(index == null) {
        addProduct(selectedProduct);
      } else {
        editProduct(index!, selectedProduct);
      }
    }
  }

  addInvoice() async {
    var invoice = Invoice(number: docNumber.value);
    invoice.company = company.value;
    invoice.bankAccount = bankAccount.value;
    invoice.client = client.value;
    invoice.contract = contract.value;
    invoice.created = date.value;
    invoice.total = total.value;
    invoice.products = products.value;
    var data = invoice.toJson();
    if(documentId == null) {
      db.addDocument(tableName, data);
    } else {
      db.updateDocument(tableName, documentId!, data);
    }
  }

}