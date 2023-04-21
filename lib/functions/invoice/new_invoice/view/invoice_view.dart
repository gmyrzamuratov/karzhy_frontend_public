import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/company/list/view/company_list_view.dart';
import 'package:karzhy_frontend/functions/catalogs/product/view/product_view.dart';
import 'package:karzhy_frontend/models/company.dart';

import '../../../../models/product.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends StatelessWidget {

  static const routeNamed = "/invoice/add";

  final InvoiceController controller = Get.put(InvoiceController(initialInvoice: Get.arguments["invoice"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Төлем шотын құру'),
        actions: [
          IconButton(onPressed: () {
            controller.goToInvoicePreviewView();
          }, icon: Icon(Icons.print))
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text("Төлеу шоты ${controller.docNumber}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("${controller.date} құрылды"),
              ),
              const Divider(height: 3.0,),
              ListTile(
                leading: const Icon(Icons.business, color: Colors.indigo,),
                title: const Text("Компания", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(controller.company.value.name == null ? "Компанияны қосыңыз": controller.company!.value.name!),
                trailing: controller.company.value.name == null ? const Icon(Icons.arrow_forward_ios)
                : const Icon(Icons.done, color: Colors.indigo),
                onTap: () async {
                  var company = await Get.to<Company>(CompanyListView());
                  if(company!=null) {
                    controller.company.value = company;
                  }
                },
              ),
              const Divider(height: 3.0,),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet_rounded, color: Colors.indigo),
                title: const Text("Шот", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(controller.bankAccount.value.name == null ? "Шотты қосыңыз" : controller.bankAccount.value.name!),
                trailing: controller.bankAccount.value.name == null ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(Icons.done, color: Colors.indigo),
                onTap: () {
                  controller.goToBankAccountListView();
                },
              ),
              const Divider(height: 3.0,),
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.indigo),
                title: const Text("Клиент", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(controller.client.value.name == null ? "Клиентті қосыңыз" : controller.client.value.name!),
                trailing: controller.client.value.name == null ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(Icons.done, color: Colors.indigo),
                onTap: () {
                  controller.goToClientListView();
                },
              ),
              const Divider(height: 3.0,),
              ListTile(
                leading: const Icon(Icons.article, color: Colors.indigo),
                title: const Text("Келісім-шарт", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(controller.contract.value.name == null ? "Келісім-артты қосыңыз" : controller.contract.value.name!),
                trailing: controller.contract.value.name == null ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(Icons.done, color: Colors.indigo),
                onTap: () {
                  controller.goToContractListView();
                },
              ),
              const Divider(height: 3.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Obx(() => ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controller.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            var product = controller.products[index];
                            return Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 5),
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Саны: ${product.quantity} ${product.unit} x ${product.price}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Сомасы: ${product.price * product.quantity} тг',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        IconButton(icon: Icon(Icons.delete), onPressed: () {
                                          controller.deleteProduct(index);
                                        },)
                                      ],
                                    ),
                                  ),
                                  onTap: () {

                                  },
                                ),
                            );
                          },
                        )
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final newItem = await Get.to<Product>(ProductView());
                        if (newItem != null) {
                          controller.addProduct(newItem);
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Тауар н/е қызмет қосу'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Барлығы: ${controller.total} тг',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 70.0
              )
            ],
          ),
        ),
      ),
      bottomSheet: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        child: const Text("Сақтау"),
        onPressed: () {
          controller.addInvoice();
        },
      ),
    );
  }
}
