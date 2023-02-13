import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  static const path = 'user';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("User Page")),
    );
  }
}
