import 'package:flutter/material.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});
  static const path = 'guest';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Guest Page")),
    );
  }
}
