import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_week2/models/register_data/register_model.dart';
import 'package:test_week2/handle_error/handle_error.dart';

class RegisterService {
  Future<Map<String, dynamic>> register(RegisterModel data) async {
    final url = '${dotenv.env['BASE_URL']}/auth/user/register';
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(data.toJson());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData
        };
      } else {
        final errorMessage = ErrorHandler.handleError(response);  
        print('Register failed: $errorMessage');
        return {
          'success': false,
          'error': errorMessage
        };
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return {
        'success': false,
        'error': e.toString()
      };
    }
  }
}
