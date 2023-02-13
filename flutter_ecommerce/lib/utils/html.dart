import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Data> fetchData() async {
  final response =
      await http.get(Uri.parse('https://pokebuildapi.fr/api/v1/pokemon'));
  if (response.statusCode == 200) {
    // print("coucou");
    return const Data(userId: 2);
  } else {
    throw Exception('Failed to load Data');
  }
}

class Data {
  final int userId;

  const Data({
    required this.userId,
  });
}
