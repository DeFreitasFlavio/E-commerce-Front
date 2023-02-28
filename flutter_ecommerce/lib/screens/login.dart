import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});
  static const relativePath = 'login';
  static const path = '/home/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SkateShop"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Login Page"),
            ElevatedButton(
              onPressed: () async {
                ref.watch(userProvider.notifier).login(
                      "test@test.com",
                      "Password!",
                    );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
