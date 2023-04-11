import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/basket.dart';
import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketPage extends ConsumerWidget {
  const BasketPage({super.key});
  static const relativePath = 'basket';
  static const path = '/home/basket';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(productBasketProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 25),
                  child: IconButton(
                    onPressed: () {
                      ref.watch(userProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout, size: 25),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 33),
                  child: Text("Se déconnecter"),
                )
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(children: [
              for (var product in basket)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: BasketProductWidget(product: product),
                ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, 'OK'),
              child: Container(
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadiusDirectional.circular(15)),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Payer'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BasketProductWidget extends ConsumerWidget {
  const BasketProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Card(
          color: Colors.blue,
          elevation: 5,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ResponsiveImage(aspectRaito: 2.5, imageUrl: product.image),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5),
                child: Text(product.name),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(product.quantity.toString()),
                        GestureDetector(
                          onTap: () => ref.watch(productBasketProvider.notifier).addProduct(
                                newProduct: product,
                                user: ref.watch(userProvider),
                              ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => ref
                              .watch(productBasketProvider.notifier)
                              .removeProduct(productId: product.id, user: ref.watch(userProvider)),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(product.price),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
