import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bnb.dart';

class FetchBnb {
  static const String apiUrl = 'http://10.0.2.2:8000/api';

  static Future<Bnb> fetchBnb(int id) async {
    final url = Uri.parse('$apiUrl/bnbs/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Bnb.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Bnbs');
    }
  }
}
