import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.amber,
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () {},
          ),
          Image.asset('assets/ShopTaBoard.png'),
          GestureDetector(
            onTap: () {},
            child: Lottie.network(
              'https://assets3.lottiefiles.com/packages/lf20_xkraio55.json',
              height: 40,
              width: 40,
              animate: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
