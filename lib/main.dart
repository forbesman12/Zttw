import 'package:flutter/material.dart';
import 'package:online_shop/Utils/bottomnav.dart';
import 'package:online_shop/screens/Profile/Provider/profile_provider.dart';
import 'package:online_shop/screens/provider/product_provider.dart';
import 'package:online_shop/auth/register/register_screen.dart';
import 'package:online_shop/auth/login/login_page.dart';
import 'package:online_shop/storage/prefs.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init(); // Initialize shared preferences
  await Prefs.initCheck(); // Check if initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CreateAccountPage(),
      ),
    );
  }
}
