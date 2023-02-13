import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_ecommerce/state/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage(this.user, {super.key});
  static const path = '/home';

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("SkateShop")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Home Page"),
            Text(user.displayName),
            ElevatedButton(
              onPressed: () {
                ref.watch(authNotifierProvider.notifier).logout();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
