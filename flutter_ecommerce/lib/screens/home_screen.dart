// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Api/Pokemon-API.dart';
import 'package:flutter_ecommerce/Api/PokemonData.dart';
import '../components/Header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpService httpService = HttpService();

  @override
  void initState() {
    /* _getPokedex(); */
    super.initState();
  }

  /* _getPokedex() {
    CallApi().getPokemonData().then((response) {
      Iterable list = json.decode(response.body);
      pokemons = list.map((model) => PokemonData.fromJson(model)).toList();
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: const Header(),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 40,
              color: Colors.grey[200],
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                ),
              ),
            )
          ]),
        ),
        Expanded(
            child: FutureBuilder(
          future: httpService.getPokemonData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PokemonData>> snapshot) {
            if (snapshot.hasData) {
              List<PokemonData> pokemons = snapshot.data;

              return ListView(
                children: pokemons
                    .map((PokemonData pokemondata) => ListTile(
                          title: Text(pokemondata.name),
                        ))
                    .toList(),
              );
            }
            return CircularProgressIndicator();
          },
        ))
      ]),
    );
  }

  /*  Widget ListSkate = SingleChildScrollView(
    child: Column(
        children: pokemons.map((pokemon) {
      return Row(
        children: [
          Container(
            height: 30,
            child: const Text('Skateboard'),
          ),
        ],
      );
    }).toList()),
    [
          Container(
              height: 200,
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                        width: 170, color: Colors.orange, child: Text('')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                ],
              )),
          Container(
              height: 200,
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.green,
                    ),
                  ),
                ],
              )),
          Row(
            children: [
              Container(
                height: 30,
                child: const Text('LongBoard'),
              ),
            ],
          ),
          Container(
              height: 200,
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.purple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.purple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.purple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.purple,
                    ),
                  ),
                ],
              )),
          Row(
            children: [
              Container(
                height: 30,
                child: const Text('LongBoard'),
              ),
            ],
          ),
          Container(
              height: 200,
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 170,
                      color: Colors.orange,
                    ),
                  ),
                ],
              )),
        ],
  ); */
}
