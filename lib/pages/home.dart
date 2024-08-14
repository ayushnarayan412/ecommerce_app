import 'package:ecommerce_app/pages/cart.dart';
import 'package:ecommerce_app/pages/favorites.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pages=[
    const HomePage(),
    const Profile(),
    const Favorites(),
    const Cart()
  ];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BottomNavigationBar(
          iconSize: 20,
          selectedFontSize: 10
          ,unselectedFontSize: 10,
        backgroundColor: Colors.transparent,
        elevation: 0,
        useLegacyColorScheme: false,
        currentIndex: pageIndex,
        onTap: (value) {
          pageIndex = value;
        },
         selectedItemColor: const Color.fromARGB(255, 180, 39, 187),
          type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems()
      ),
      ),
      body: pages[pageIndex],
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems() {
    return [
       BottomNavigationBarItem(icon: IconButton(icon: const Icon(Icons.home),onPressed: () =>setState(() {
        pageIndex=0;
      })), label: 'Home',),
       BottomNavigationBarItem(icon: IconButton(icon: const Icon(Icons.person),onPressed: () =>setState(() {
        pageIndex=1;
      })),label: 'Profile'),
       BottomNavigationBarItem(icon: IconButton(icon: const Icon(Icons.favorite),onPressed: () =>setState(() {
        pageIndex=2;
      })),label: 'Favorites'),
       BottomNavigationBarItem(icon: IconButton(icon: const Icon(Icons.shopping_cart),onPressed: () =>setState(() {
        pageIndex=3;
      })), label: 'Cart'),

    ];
  }
}
