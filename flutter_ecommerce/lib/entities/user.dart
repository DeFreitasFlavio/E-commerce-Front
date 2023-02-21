import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/entities/user_role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  const User({
    this.role = UserRole.guest,
    this.id,
    this.firstname,
    this.email,
    this.password,
    this.token,
  });
  final UserRole role;
  final String? id;
  final String? firstname;
  final String? email;
  final String? password;
  final String? token;

  User.fromJson(Map json, this.role)
      : id = json['id'],
        firstname = json['firstname'],
        email = json['email'],
        password = json['password'],
        token = json['token'];

  Map toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  User copyWith({
    required UserRole role,
    String? id,
    String? firstname,
    String? email,
    String? password,
    String? token,
  }) {
    return User(
      role: role,
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}

class ProductBasketNotifier extends StateNotifier<List<Product>> {
  ProductBasketNotifier() : super([]);

  void addProduct(Product todo) {
    state = [...state, todo];
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
