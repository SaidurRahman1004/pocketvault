import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.0.100:8000/api';

  //get tocken from Sharepref /_getToken use for find acces token from memory and use in header
  static Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('access_token');
  }

  //Create Header for Each Api Req ,If token Find then add Authorization Headers
  static Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    if (token != null) {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
    }
    return {'Content-Type': 'application/json; charset=UTF-8'};
  }

  //Auth login
  static Future<http.Response> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/token/');
    return await http.post(
      url,
      //header carry Token if find
      headers: await _getHeaders(),
      //sent object to database
      body: jsonEncode({'username': username, 'password': password}),
    );
  }

  //Auth Register
  static Future<http.Response> register(
    String username,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$_baseUrl/users/');
    return await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
  }

  //CURD Operations

  //get All List
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint/');
    return await http.get(url, headers: await _getHeaders());
  }

  //Add New Item
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$_baseUrl/$endpoint/');
    return await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
  }

  //Delete
  static Future<http.Response> delete(String endpoint, int id) async {
    final url = Uri.parse('$_baseUrl/$endpoint/$id/');
    return await http.delete(url, headers: await _getHeaders());
  }
}
