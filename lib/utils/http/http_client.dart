import 'dart:convert';
import 'package:http/http.dart' as http;

class EHttpHelper {
  static const String _baseUrl = 'https://restcountries.com/v3.1/all';

  // Helper method to make a GET request
  static Future<List> get() async {
    final response = await http.get(Uri.parse(_baseUrl));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static List _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
