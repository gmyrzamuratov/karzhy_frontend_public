import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/core/controllers/auth_controller.dart';
import 'package:karzhy_frontend/functions/home/controllers/home_controller.dart';
import 'package:karzhy_frontend/functions/invoice/new_invoice/view/invoice_view.dart';
import 'package:karzhy_frontend/widgets/loading_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Шоттар"),
        actions: [
          IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Obx(() {
        return controller.isLoading.value == true
            ? loadingView()
            : ListView.builder(
          itemCount: controller.invoices.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.invoices[index].client.name!,
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(controller.invoices[index].total.toStringAsFixed(2),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.invoices[index].number!),
                  Text(controller.invoices[index].created.toString()),
                ],
              ),
              onTap: () {
                controller.goToAddInvoiceView(controller.invoices[index]);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(InvoiceView());
          //Get.to(ProductView());
        },
      ),
    );
  }

}
