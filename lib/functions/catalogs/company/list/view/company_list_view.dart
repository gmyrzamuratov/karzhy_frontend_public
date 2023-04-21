import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/company/add/view/add_company_view.dart';
import 'package:karzhy_frontend/functions/catalogs/company/list/controllers/company_list_controller.dart';
import 'package:karzhy_frontend/widgets/loading_view.dart';

class CompanyListView extends StatelessWidget {
  CompanyListView({Key? key}) : super(key: key);

  final CompanyListController controller = Get.put(CompanyListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Компанияларым')),
      body: Obx(() {
        return controller.isLoading.value == true
            ? loadingView()
            : ListView.builder(
                itemCount: controller.companies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.companies[index].name!),
                    subtitle: Text(controller.companies[index].bin!),
                    trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.to(AddCompanyView(
                              company: controller.companies[index]));
                        }),
                    onTap: () {
                      Get.back(result: controller.companies[index]);
                    },
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddCompanyView());
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
  }
}
