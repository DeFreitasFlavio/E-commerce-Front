import 'dart:convert';

import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

const String url = "http://161.97.90.183:8000";

Future<Data> fetchData(String dataUrl) async {
  final response =
      await http.get(Uri.parse('https://pokebuildapi.fr/api/v1/pokemon'));
  if (response.statusCode == 200) {
    // print("coucou");
    return const Data(userId: 2);
  } else {
    throw Exception('Failed to load Data');
  }
}

Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('$url/products'));
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    List<Product> products =
        list.map((model) => Product.fromJson(model)).toList();
    return products;
  } else {
    throw Exception('ERROR:Failed to get products');
  }
}

User getUser() {
  return const User(
      id: 1, displayName: "test", email: "test@mail.com", token: "token");
}

class Data {
  final int userId;

  const Data({
    required this.userId,
  });
}
