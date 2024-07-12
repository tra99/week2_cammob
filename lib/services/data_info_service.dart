import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:test_week2/models/register_data/response_model.dart';

Future<ResponseModel> fetchResponseFromApi() async {
  final response = await http.get(Uri.parse('${dotenv.env['BASE_URL']}/auth/configuration'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return ResponseModel.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load data');
  }
}
