import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/bank/list/controller/bank_list_controller.dart';
import 'package:karzhy_frontend/widgets/loading_view.dart';

class BankListView extends StatelessWidget {

  static const routeNamed = "/banks";

  BankListView({Key? key}) : super(key: key);

  var controller = Get.put(BankListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Банктер')),
      body: Obx(() {
        return controller.isLoading.value == true
            ? loadingView()
            : ListView.builder(
          itemCount: controller.banks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.banks[index].name!),
              subtitle: Text(controller.banks[index].swift!),
              onTap: () {
                Get.back(result: controller.banks[index]);
              },
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
  }
}