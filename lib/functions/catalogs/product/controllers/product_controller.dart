import 'package:get/get.dart';
import 'package:karzhy_frontend/models/product.dart';

class ProductController extends GetxController {
  var name = ''.obs;
  var unit = ''.obs;
  var quantity = 0.0.obs;
  var price = 0.0.obs;
  var sum = 0.0.obs;

  /*
  ProductController(Product? initialProduct) {
    if(initialProduct!=null) {
      name = initialProduct.name.obs;
      unit = initialProduct.unit.obs;
      quantity = initialProduct.quantity.obs;
      price = initialProduct.price.obs;
    }
  }*/

  void calculateSum() {
    sum.value = quantity.value * price.value;
  }

  get() {
    return Product(
        name: name.value,
        unit: unit.value,
        quantity: quantity.value,
        price: price.value);
  }

}