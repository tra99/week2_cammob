import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_week2/models/register_model.dart';

class RegisterService {
  Future<bool> register(RegisterModel data) async {
    final url = '${dotenv.env['BASE_URL']}/auth/user/register';
    final headers = {'content-Type': 'application/json'};
    final body = json.encode(data.toJson());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if(response.statusCode==200){
        return true;
      }
      else{
        print('Register failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return false;
    }
  }
}