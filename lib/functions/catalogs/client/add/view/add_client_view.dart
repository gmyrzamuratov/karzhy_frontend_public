import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/client/add/controllers/add_client_controller.dart';
import 'package:karzhy_frontend/models/client.dart';

class AddClientView extends StatelessWidget {

  static const routeNamed = "/client/add/";

  const AddClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Customer')),
      body: GetBuilder<AddClientController>(
        init: AddClientController(initialClient: Get.arguments["client"]),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Аты'),
                initialValue: Get.arguments["client"]?.name,
                onChanged: (value) {
                  controller.client.value.name = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'ЖСН'),
                initialValue: Get.arguments["client"]?.bin,
                onChanged: (value) {
                  controller.client.value.bin = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Мекен-жайы'),
                initialValue: Get.arguments["client"]?.address,
                onChanged: (value) {
                  controller.client.value.address = value;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if(Get.arguments["client"] == null) {
                    controller.add();
                  } else {
                    controller.updateClient();
                  }
                },
                child: Text('Сақтау'),
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