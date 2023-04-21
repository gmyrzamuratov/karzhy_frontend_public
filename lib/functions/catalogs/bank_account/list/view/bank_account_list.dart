import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/bank_account/list/controller/bank_account_list_controller.dart';
import 'package:karzhy_frontend/widgets/loading_view.dart';

class BankAccountListView extends StatelessWidget {

  static const routeNamed = "/bank_accounts";

  BankAccountListView({Key? key}) : super(key: key);

  var controller = Get.put(BankAccountListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Банк шоттары')),
      body: Obx(() {
        return controller.isLoading.value == true
            ? loadingView()
            : ListView.builder(
          itemCount: controller.bankAccounts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.bankAccounts[index].iban!),
              subtitle: Text(controller.bankAccounts[index].bank!.name!),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    controller.goToAddBankAccountView(controller.bankAccounts[index]);
                  }),
              onTap: () {
                Get.back(result: controller.bankAccounts[index]);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.goToAddBankAccountView(null);
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
  }
}