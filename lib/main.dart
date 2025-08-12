import 'package:flutter/material.dart';
import 'package:online_shop/Utils/bottomnav.dart';
import 'package:online_shop/provider/product_provider.dart';
import 'package:online_shop/auth/register/register_screen.dart';
import 'package:online_shop/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/create-account',
        routes: {
          '/create-account': (context) => const CreateAccountPage(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
