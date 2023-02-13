import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  static const path = 'admin';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Admin Page")),
    );
  }
}
