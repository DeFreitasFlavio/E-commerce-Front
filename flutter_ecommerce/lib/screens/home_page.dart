import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/product.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const path = '/home';

  final bool needUpdate = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(productBasketProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("SkateShop"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => context.go('/home/user'),
              icon: const Icon(Icons.account_circle, size: 40),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart, size: 40),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ref.watch(productsProvider).when(data: (products) {
              return Text(products[1].name!);
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
}
