import 'package:flutter/material.dart';
import 'package:front_ecommerce/Screen/HomeScreen.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Lottie.asset('assets/41256-skateboarding.json'),
                ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }, 
                  child: Text("Page Home"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
