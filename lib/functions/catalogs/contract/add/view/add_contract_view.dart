import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/contract/add/controllers/add_contract_controller.dart';

class AddContractView extends StatelessWidget {
  static const routeNamed = "/contract/add/";

  const AddContractView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Келісім-шарт қосу')),
      body: GetBuilder<AddContractController>(
        init: AddContractController(initialContract: Get.arguments["contract"]),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Divider(height: 3.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Аты'),
                initialValue: Get.arguments["contract"]?.name,
                onChanged: (value) {
                  controller.contract.value.name = value;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (Get.arguments["contract"] == null) {
                    controller.add();
                  } else {
                    controller.updateContract();
                  }
                },
                child: const Text('Сақтау'),
              ),
            ],
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
