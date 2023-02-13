import 'package:flutter_ecommerce/entities/user.dart';

class HomeData {
  const HomeData({
    required this.user,
    required this.isAuth,
  });
  final User user;
  final bool isAuth;
}
