import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateBnb {
  static const String apiUrl = String.fromEnvironment('API_URL');

  static Future<http.Response> createBnb(Map<String, dynamic> bnbData) async {
    final url = Uri.parse('$apiUrl/bnb');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bnbData),
    );
    return response;
  }
}
