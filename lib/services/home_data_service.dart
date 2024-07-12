import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:test_week2/models/home_data/reponse_home_data.dart';
import 'package:http/http.dart' as http;
import 'package:test_week2/services/login.dart';

Future<ReponseHomeData> fetchHomeData(BuildContext context) async {
  final token = context.read<LoginProvider>().token;
  final url = Uri.parse('${dotenv.env['BASE_URL']}/home');
  
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse != null && jsonResponse['data'] != null && jsonResponse['data']['total_services'] != null) {
      return ReponseHomeData.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Unexpected response format');
    }
  } else {
    throw Exception('Failed to load data');
  }
}
