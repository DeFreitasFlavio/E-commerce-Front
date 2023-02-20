// ignore_for_file: prefer_initializing_formals

import 'package:flutter/foundation.dart';

class PokemonData {
  final int id;
  final int pokedexId;
  final String name;
  final String image;

  PokemonData(
      {required this.id,
      required this.pokedexId,
      required this.name,
      required this.image});

  factory PokemonData.fromJson(Map<String, dynamic> json) {
    return PokemonData(
      id: json['id'] as int,
      pokedexId: json['pokedexId'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  /* PokemonData(int id, int pokedexId, String name, String image) {
    this.id = id;
    this.pokedexId = pokedexId;
    this.name = name;
    this.image = image;
  }
  PokemonData.fromJson(Map json)
      : id = json['id'],
        pokedexId = json['pokedex_id'],
        name = json['name'],
        image = json['image']; */
}
