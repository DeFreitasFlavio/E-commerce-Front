import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_ecommerce/entities/user_role.dart';
import 'package:flutter_ecommerce/utils/app_exceptions.dart';
import 'package:flutter_ecommerce/utils/http.dart';
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

  void addProduct({required Product newProduct, required User user}) {
    if (user.role == UserRole.user) {
      post(
        route: '/carts/add-to-cart',
        body: {"productId": newProduct.id},
        headers: {'Authorization': 'Bearer ${user.jwt}'},
      );
    }

    if (state.contains(newProduct)) {
      state[state.indexOf(newProduct)].quantity++;
    } else {
      state = [...state, newProduct];
    }
  }

  void convertToCart({required User user}) {
    if (user.role == UserRole.user) {
      final List<String> productList = [for (final product in state) product.id];
      post(
        route: '/carts/add-to-cart',
        body: {"productId": productList},
        headers: {'Authorization': 'Bearer ${user.jwt}'},
      );
    } else {
      throw AppException(code: 501, message: "cannot convert to cart, user not authentificated");
    }
  }

  void removeProduct({required String productId, required User user}) {
    if (user.role == UserRole.user) {
      delete(
        route: '/carts/remove-to-cart',
        body: {"productId": productId},
        headers: {'Authorization': 'Bearer ${user.jwt}'},
      );
    }
    for (final product in state) {
      if (product.id == productId) {
        product.quantity = product.quantity - 1;
      }
    }
    state = [
      for (final product in state)
        if (product.quantity >= 1) product,
    ];
  }

  void removeAllProduct() {
    state = [];
  }
}

final productBasketProvider = StateNotifierProvider<ProductBasketNotifier, List<Product>>((ref) {
  return ProductBasketNotifier();
});
