import 'dart:convert';
import 'package:http/http.dart' as http;


class HttpResult {
  final String message;
  final dynamic data;
  final int statusCode;

  HttpResult({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  // Factory method to create HttpResult from a response
  factory HttpResult.fromResponse(http.Response response) {
    final Map<String, dynamic> parsed = jsonDecode(response.body);
    final String message = parsed['message'] ?? '';
    final dynamic data = parsed['data'];
    
    return HttpResult(
      message: message,
      data: data,
      statusCode: response.statusCode,
    );
  }
}
