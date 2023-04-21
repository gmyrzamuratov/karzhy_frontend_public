import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/bank_account/add/controllers/add_bank_account_controller.dart';

class AddBankAccountView extends StatelessWidget {

  static const routeNamed = "/bank_account/add/";

  const AddBankAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Банк шотын қосу')),
      body: GetBuilder<AddBankAccountController>(
        init: AddBankAccountController(initialBankAccount: Get.arguments["bank_account"]),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() =>
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_balance, color: Colors.indigo),
                  title: const Text("Банк"),
                  subtitle: Text(controller.bankAccount.value.bank!.documentId == null
                      ? "Банкты таңдаңыз" : controller.bankAccount.value.bank!.name!),
                  trailing: controller.bankAccount.value.bank!.documentId == null
                      ? const Icon(Icons.arrow_forward_ios)
                      : const Icon(Icons.done, color: Colors.indigo),
                  onTap: () {
                    controller.goToBankListView();
                  },
                ),
                const Divider(height: 3.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'IBAN'),
                  initialValue: Get.arguments["bank_account"]?.iban,
                  onChanged: (value) {
                    controller.bankAccount.value.iban = value;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if(Get.arguments["bank_account"] == null) {
                      controller.add();
                    } else {
                      controller.updateBankAccount();
                    }
                  },
                  child: const Text('Сақтау'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
  }
}