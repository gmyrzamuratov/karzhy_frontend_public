import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/client/add/view/add_client_view.dart';
import 'package:karzhy_frontend/functions/catalogs/client/list/controllers/client_list_controller.dart';
import 'package:karzhy_frontend/widgets/loading_view.dart';

class ClientListView extends StatelessWidget {

  static const routeNamed = "/clients";

  ClientListView({Key? key}) : super(key: key);

  var controller = Get.put(ClientListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Клиенттер')),
      body: Obx(() {
        return controller.isLoading.value == true
            ? loadingView()
            : ListView.builder(
          itemCount: controller.clients.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.clients[index].name!),
              subtitle: Text(controller.clients[index].bin!),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    controller.goToAddClientView(controller.clients[index]);
                  }),
              onTap: () {
                Get.back(result: controller.clients[index]);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.goToAddClientView(null);
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
  }
}