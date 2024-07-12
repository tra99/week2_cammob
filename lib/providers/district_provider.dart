import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_week2/models/register_data/response_model.dart';

Future<List<ResponseModel>> fetchProvincesFromApi() async {
  final response = await http.get(Uri.parse('https://dev-farmbook.cammob.ovh/api/v01/mobile/auth/configuration'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> responseJson = jsonResponse['data'];
    return responseJson.map((json) => ResponseModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load provinces');
  }
}
