import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/api/api_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = true;

  bool get isAuthenticated => _isAuthenticated;

  bool get isLoading => _isLoading;

  //when app start then try to auto login
  AuthProvider() {
    _tryAutoLogin();
  }

  //Auto Login Provider
  Future<void> _tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    //find access token in memory
    if (!pref.containsKey('access_token')) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    //if access token find in memory then user is authenticated and go to HomePage
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
  }

  //logn provider
  Future<bool> login(String username, String password) async {
    //loading start
    _isLoading = true;
    notifyListeners();
    try {
      //send username and password to database
      final response = await ApiService.login(username, password);
      //find access token feom db and save it phone memory and _isAuthenticated true
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access']);
        await prefs.setString('refresh_token', data['refresh']);
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }else{
        //if error then _isAuthenticated false
        _isAuthenticated = false;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  //logout
  Future<void> logout() async {
    //clear all data from memory and _isAuthenticated false
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _isAuthenticated = false;
    notifyListeners();
  }
}
