import 'dart:convert';
import 'package:flutter_ecommerce/Api/PokemonData.dart';
import 'package:http/http.dart';

class HttpService {
  final String pokedexUrl = "https://pokebuildapi.fr/api/v1/pokemon";

  Future<List<PokemonData>> getPokemonData() async {
    Response res = await get(pokedexUrl as Uri);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<PokemonData> data =
          body.map((dynamic item) => PokemonData.fromJson(item)).toList();

      return data;
    } else {
      throw "Can't get data";
    }
  }
}
/* getPokemonData() async {
    http.Response response = await http.get(Uri.parse(_url));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed ${response.statusCode}';
      }
    } catch (e) {
      print(e);
      return 'failed ${response.statusCode}';
    }
  } */