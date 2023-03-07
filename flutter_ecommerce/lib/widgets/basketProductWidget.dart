import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/utils/image/responsive_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketProductWidget extends ConsumerWidget {
  const BasketProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      Card(
        color: Colors.blue,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ResponsiveImage(aspectRaito: 2.5, imageUrl: product.image),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5),
              child: Text(product.name),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(product.price),
                ),
              ],
            )
          ],
        ),
      ),
      Card(
          color: Colors.blueGrey,
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                // onTap: () => decrement ,
                child: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ),
            ],
          )),
    ]);
  }
}
