import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token = '';
  late DateTime _expiryDate = DateTime.now();
  late String _userId = '';

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
      //update the user interface have to do trigger consumer in main.dart
      notifyListeners();
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
}
