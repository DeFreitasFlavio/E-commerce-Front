import 'dart:convert';

import 'package:flutter_ecommerce/entities/user_role.dart';
import 'package:flutter_ecommerce/utils/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  const User({
    this.role = UserRole.guest,
    this.id,
    this.firstname,
    this.name,
    this.email,
    this.jwt,
  });
  final UserRole role;
  final String? id;
  final String? firstname;
  final String? name;
  final String? email;
  final String? jwt;

  User.fromJson(Map json, this.role)
      : id = json['id'],
        firstname = json['firstname'],
        name = json['name'],
        email = json['email'],
        jwt = json['jwt'];

  Map toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'name': name,
      'email': email,
      'jwt': jwt,
    };
  }

  User copyWith({
    required UserRole role,
    String? id,
    String? firstname,
    String? name,
    String? email,
    String? password,
    String? jwt,
  }) {
    return User(
      role: role,
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      name: name ?? this.name,
      email: email ?? this.email,
      jwt: jwt ?? this.jwt,
    );
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(const User());

  void login(String email, String password) async {
    final responseBody = await post(
      route: '/users/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    state = User.fromJson(jsonDecode(responseBody), UserRole.user);
  }

  void logout() {
    state = const User();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
