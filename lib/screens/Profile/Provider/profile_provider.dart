import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop/screens/Profile/Model/profile_model.dart';
import 'package:online_shop/services/api_services.dart';
import 'package:online_shop/storage/prefs.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  Future<void> getProfile() async {
    //define the url
    final url = ApiServices.profileUrl;
    //get the token from preferences
    final token = await Prefs.getAccessToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print the response for debugging
    print('status code ${response.statusCode}');
    print('---====---= body: ${response.body}');

    //check if the response is successful
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final data = ProfileModel.fromJson(body);
      _profileModel = data;
      notifyListeners();
    } else {
      print('Failed to load profile: ${response.statusCode}');
      throw Exception('Failed to load profile');
    }
  }
}
