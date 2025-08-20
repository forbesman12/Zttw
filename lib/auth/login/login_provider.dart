import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop/Utils/bottomnav.dart';
import 'package:online_shop/services/api_services.dart';
import 'package:online_shop/storage/prefs.dart';

class SignProvider extends ChangeNotifier {
  Future<void> signin(context, String email, String password) async {
    final url = ApiServices.authUrl;
    final body = jsonEncode({'email': email, 'password': password});
    var response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'},body: body,);
    if (response.statusCode == 201) {

      var data =jsonDecode(response.body);

      await Prefs.setAccessToken(data['access_token']);

      print(data['access_token']);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Registration')),
      );
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.body}')),
      );
    }

    notifyListeners();
  }
}
