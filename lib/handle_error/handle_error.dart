import 'dart:convert';
import 'package:http/http.dart' as http;

class ErrorHandler {
  static String handleError(http.Response response) {
    final responseData = jsonDecode(response.body);

    switch (response.statusCode) {
      case 400:
        return 'Bad Request: ${responseData['message']}';
      case 401:
        return 'Unauthorized: ${responseData['message']}';
      case 403:
        return responseData != null && responseData['errors'] != null
            ? 'Failed to login: ${responseData['errors'][0]}'
            : 'Forbidden: ${response.body}';
      case 404:
        return 'Not Found: ${responseData['message']}';
      case 406:
        return responseData != null && responseData['error'] != null
            ? 'Validation error: ${responseData['error'].values.first[0]}'
            : 'Not Acceptable: ${response.body}';
      case 500:
        return 'Internal Server Error: ${responseData['message']}';
      default:
        return 'Unexpected error: ${response.body}';
    }
  }
}
