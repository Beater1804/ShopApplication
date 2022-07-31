import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  late String _token = '';
  late DateTime _expiryDate = DateTime.now();
  late String _userId = '';
  Timer? _authTimer;

  //check Authentication for display in ProductOverview or AuthScreen
  bool get isAuth {
    return token.isNotEmpty;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate.toString().isNotEmpty &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token.isNotEmpty) {
      return _token;
    } else {
      return '';
    }
  }

  // Function model use for sign in and sign up in application
  Future<void> _authentication(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBFQDQ6BPrbitxKdB0el7r5JXLe6iIKZe4';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true.toString(),
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      //get token, userid and expiresIn from the response, then save in local Data
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      //update the user interface have to do trigger consumer in main.dart
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  // Future<void> logout() async {
  //   _token.isNotEmpty ? null : null;
  //   _userId.isNotEmpty ? null : null;
  //   _expiryDate.toIso8601String().isNotEmpty ? null : null;
  //   if (_authTimer != null) {
  //     _authTimer?.cancel();
  //     _authTimer = null;
  //   }
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   // remove the userData
  //   prefs.clear();
  // }

  Future<void> logout() async {
    Future.wait([_logoutApp()]);
    notifyListeners();
    //final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    //prefs.clear();
  }

  Future<void> _logoutApp() async {
    _token.isNotEmpty ? null : null;
    _userId.isNotEmpty ? null : null;
    _expiryDate.toIso8601String().isNotEmpty ? null : null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    // notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // remove the userData
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
