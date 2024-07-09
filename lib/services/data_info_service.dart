import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_week2/models/response_model.dart';

Future<ResponseModel> fetchResponseFromApi() async {
  final response = await http.get(Uri.parse('https://dev-farmbook.cammob.ovh/api/v01/mobile/auth/configuration'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return ResponseModel.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load data');
  }
}
