import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/contract/list/controller/contract_list_controller.dart';
import 'package:karzhy_frontend/widgets/loading_view.dart';

class ContractListView extends StatelessWidget {

  static const routeNamed = "/contracts";

  ContractListView({Key? key}) : super(key: key);

  var controller = Get.put(ContractListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Келісім-шарттар')),
      body: Obx(() {
        return controller.isLoading.value == true
            ? loadingView()
            : ListView.builder(
          itemCount: controller.contracts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.contracts[index].name!),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    controller.goToAddContractView(controller.contracts[index]);
                  }),
              onTap: () {
                Get.back(result: controller.contracts[index]);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.goToAddContractView(null);
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
  }
}