import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserBasket {
  const UserBasket({
    required this.userId,
    required this.productList,
  });
  final String userId;
  final List<Product> productList;

  UserBasket.fromJson(Map json)
      : userId = json['userId'],
        productList = json['productList'];

  Map toJson() {
    return {
      'userId': userId,
      'productList': productList,
    };
  }
}

class ProductBasketNotifier extends StateNotifier<List<Product>> {
  ProductBasketNotifier() : super([]);

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(String productId) {
    state = [
      for (final product in state)
        if (product.id != productId) product,
    ];
  }
}

final productBasketProvider =
    StateNotifierProvider<ProductBasketNotifier, List<Product>>((ref) {
  return ProductBasketNotifier();
});
