import 'package:http/http.dart' as http;

class DeleteBnb {
  static const String apiUrl = String.fromEnvironment('API_URL');
  static Future<bool> deleteBnb(String id) async {
    final url = Uri.parse('$apiUrl/bnbs/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
