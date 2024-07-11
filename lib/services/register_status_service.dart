import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterStatusService {
  Future<Map<String, dynamic>> checkRegisterStatus(String phoneNumber) async {
    final url = '${dotenv.env['BASE_URL']}/auth/user/register-status';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'phone_number': phoneNumber});

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to check register status');
    }
  }
}
