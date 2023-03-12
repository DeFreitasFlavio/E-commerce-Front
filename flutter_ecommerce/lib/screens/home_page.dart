import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_ecommerce/widgets/basket_product_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_ecommerce/widgets/header_widget.dart';
import 'package:lottie/lottie.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const path = '/home';

  final bool needUpdate = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(productBasketProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: const Header(),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: const Color(0xFFE0E0E0)),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              ref
                  .watch(productBasketProvider.notifier)
                  .addProduct(const Product(
                    id: "1",
                    brand: "brand",
                    name: "name",
                    description: "description",
                    category: 'category',
                    image: 'image',
                    price: 'price',
                    size: 'size',
                    stock: 1,
                    reduction: 1,
                  ));
              ref
                  .watch(productBasketProvider.notifier)
                  .addProduct(const Product(
                    id: "2",
                    brand: "brand",
                    name: "name2",
                    description: "description",
                    category: 'category',
                    image: 'image',
                    price: 'price',
                    size: 'size',
                    stock: 1,
                    reduction: 1,
                  ));

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Center(child: Text('Panier')),
                  content: Column(children: [
                    for (var product in basket)
                      BasketProductWidget(product: product)
                  ]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        ref
                            .watch(productBasketProvider.notifier)
                            .removeAllProduct();
                        Navigator.pop(context, 'Cancel');
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('Payer'),
                    ),
                  ],
                ),
              );
            },
            child: Lottie.network(
              'https://assets3.lottiefiles.com/packages/lf20_xkraio55.json',
              height: 40,
              width: 40,
              animate: true,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ref.watch(productsProvider).when(data: (products) {
              return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Image(
                                      image:
                                          NetworkImage(products[index].image),
                                      width: 70,
                                    ),
                                    Text(products[index].name,
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                          ],
                        ),
                      );
                    },
                  ));
            }, loading: () {
              return const CircularProgressIndicator();
            }, error: (error, stack) {
              return Text('$error\n$stack');
            }),
            ElevatedButton(
              onPressed: () {
                ref.watch(userProvider.notifier).logout();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

/*   Widget ListSkate = SingleChildScrollView(
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
            ],
          )),
    ],
  ); */
}
