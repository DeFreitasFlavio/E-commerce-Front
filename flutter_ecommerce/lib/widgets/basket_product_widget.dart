import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/basket.dart';
import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketProductWidget extends ConsumerWidget {
  const BasketProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(children: [
        card(
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ResponsiveImage(aspectRaito: 2.5, imageUrl: product.image),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                child: Text(product.name),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5, bottom: 10, top: 5, left: 10),
                    child: card(
                        color: Colors.blueGrey,
                        child: Row(
                          children: [
                            GestureDetector(
                              // onTap: () => increment product number,
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                            // Text(product.number)
                            GestureDetector(
                              onTap: () {
                                ref
                                    .watch(productBasketProvider.notifier)
                                    .removeProduct(productId: product.id);
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10, bottom: 10, top: 5, left: 5),
                    child: card(
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "${product.price}€",
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Card card({required MaterialColor color, required Widget child}) {
    return Card(
      color: color,
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: child,
    );
  }
}
