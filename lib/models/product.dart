class Product {
  String name;
  String unit;
  double quantity;
  double price;

  Product({required this.name, required this.unit, required this.quantity, required this.price});

  double get sum => quantity * price;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json["name"],
        unit: json["unit"],
        quantity: json["quantity"],
        price: json["price"]);
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "unit": unit,
    "quantity": quantity,
    "price": price,
    "sum": sum
  };

}

class ProductList {

  List<Product> productList;

  ProductList({required this.productList});

  Map<String, dynamic> toJson() => {

  };

}