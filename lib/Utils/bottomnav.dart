import 'package:flutter/material.dart';
import 'package:online_shop/screens/Cart/cart_page.dart';
import 'package:online_shop/screens/Categories/categories.dart';
import 'package:online_shop/screens/Home/home.dart';
import 'package:online_shop/screens/Profile/profile_page.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedIndex = 0;
  static const List<Widget> _bottomNavCategories = [
    HomePage(),
    Categories(),
    CartPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color.fromARGB(255, 247, 226, 226),
      body: _bottomNavCategories.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 20),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.category, 'Categories', 1),
            _buildNavItem(Icons.shopping_cart_outlined, 'cart', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
  return GestureDetector(
    onTap: () => _onItemTapped(index),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: _selectedIndex == index ? Color(0xFFFFA726) : Colors.grey,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: _selectedIndex == index ? Color(0xFFFFA726) : Colors.grey,
          ),
        ),
      ],
    ),
  );
}
}


