import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateBnb {
  static const String apiUrl = String.fromEnvironment('API_URL');

  static Future<http.Response> updateBnb(String id, Map<String, dynamic> bnbData) async {
    final url = Uri.parse('$apiUrl/bnbs/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bnbData),
    );
    return response;
  }
}