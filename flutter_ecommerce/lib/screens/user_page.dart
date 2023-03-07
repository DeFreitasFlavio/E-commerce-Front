import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});
  static const relativePath = 'user';
  static const path = '/home/user';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil de ${user.firstname ?? "inconnu"}"),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(user.firstname ?? "inconnu"),
            Text(user.id ?? "pas d'id"),
          ],
        ),
      ),
    );
  }
}
