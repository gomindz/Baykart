import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri_tech/models/user.dart';

class AuthProvider extends ChangeNotifier {
  User _user = User(
    fullname: '',
    phone: '',
    language: '',
    id: '',
    org: '',
    acceptedTerms: true,
  );

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user.language = language;
    prefs.setString('user', jsonEncode(_user.toJson()));
    notifyListeners();
  }
}
