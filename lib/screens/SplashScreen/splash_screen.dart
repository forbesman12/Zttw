import 'package:flutter/material.dart';
import 'package:online_shop/Utils/bottomnav.dart';
import 'package:online_shop/auth/login/login_page.dart';
import 'package:online_shop/storage/prefs.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Wait for 2 seconds for the splash screen to show
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      // Check if access token exists
      final String? accessToken = await Prefs.getAccessToken();
      
      if (accessToken != null && accessToken.isNotEmpty) {
        // User is logged in, navigate to main app
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottomnav()),
        );
      } else {
        // User is not logged in, navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      // If there's any error, default to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 200, color: Colors.deepPurple),
            Text('Welcome to Online Shop',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}