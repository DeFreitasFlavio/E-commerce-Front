import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_ecommerce/entities/product.dart';

class HomeData {
  const HomeData({
    required this.user,
    required this.isAuth,
    required this.products,
  });
  final User user;
  final bool isAuth;
  final List<Product> products;
}
