import 'package:flutter_ecommerce/utils/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.brand,
      required this.description,
      required this.stock,
      required this.reduction,
      required this.category,
      required this.size,
      this.quantity = 1});
  final String id;
  final String name;
  final String image;
  final String price;
  final String brand;
  final String description;
  final int stock;
  final int reduction;

  final String category;
  final String size;

  final int quantity;

  Product.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        price = json['price'],
        brand = json['brand'],
        description = json['description'],
        stock = json['stock'],
        reduction = json['reduction'],
        category = json['category'],
        quantity = 1,
        size = json['size'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'brand': brand,
      'description': description,
      'stock': stock,
      'reduction': reduction,
      'category': category,
      'size': size,
    };
  }
}

final productsProvider = FutureProvider<List<Product>>((ref) async {
  return await getProducts();
});
