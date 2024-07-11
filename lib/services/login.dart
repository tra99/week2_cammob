import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> login(String phone, String password) async {
  final url = Uri.parse('${dotenv.env['BASE_URL']}/auth/user/login');
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData != null && responseData['data'] != null) {
        print('Logged in successfully');
        print('Token: ${responseData['data']['token']}');
        print('User: ${responseData['data']['user']}');
        return true;
      } else {
        print('Unexpected response format: ${response.body}');
        return false;
      }
    } else {
      print('Failed to login: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error during login: $e');
    return false;
  }
}
