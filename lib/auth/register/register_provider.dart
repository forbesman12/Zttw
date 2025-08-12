import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop/services/api_services.dart';

class RegisterProvider extends ChangeNotifier {
  Future<void> register(
    String name,
    String email,
    String password,
    String avatar,
  ) async {
    //define the url
    final url = ApiServices.baseUrl;
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'avatar': avatar,
      }),
    );
    print('response.body');
    print('response.status code');
    if (response.statusCode == 200) {
      print('success');
    } else {
      print('something went wrong');
    }
    notifyListeners();
  }
}
