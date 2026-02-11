import 'package:flutter/material.dart';
import 'package:mini_product_showcase_app/features/products/presentation/pages/cart_screen.dart';
import 'package:mini_product_showcase_app/features/products/presentation/pages/home_screen.dart';

class BottomNaviagtionBar extends StatefulWidget {
  const BottomNaviagtionBar({super.key});

  @override
  State<BottomNaviagtionBar> createState() => _BottomNaviagtionBarState();
}

class _BottomNaviagtionBarState extends State<BottomNaviagtionBar> {
  final List<Widget> items = [const HomeScreen(), const CartScreen()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: items),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
