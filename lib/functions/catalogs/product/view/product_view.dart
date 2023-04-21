import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/core/utils/custom_number_formatter.dart';
import '../controllers/product_controller.dart';

class ProductView extends StatefulWidget {

  static const routeNamed = "/product/add";

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  controller.name.value = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Unit',
                ),
                onChanged: (value) {
                  controller.unit.value = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [CustomNumberTextInputFormatter()],
                decoration: InputDecoration(
                  labelText: 'Count',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  var sum = value;
                  sum = sum.replaceAll(" ", "");
                  sum = sum.replaceAll(",", ".");
                  controller.quantity.value = double.parse(sum);
                  controller.calculateSum();
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                inputFormatters: [CustomNumberTextInputFormatter()],
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  var sum = value;
                  sum = sum.replaceAll(" ", "");
                  sum = sum.replaceAll(",", ".");
                  controller.price.value = double.parse(sum);
                  controller.calculateSum();
                },
              ),
              SizedBox(height: 16.0),
              Obx(() => Text(
                    'Sum: ${controller.sum.value}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Get.back(result: controller.get());
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
