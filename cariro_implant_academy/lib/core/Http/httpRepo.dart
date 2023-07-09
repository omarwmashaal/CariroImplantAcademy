import 'dart:convert';

import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:http/http.dart' as http;

class StandardHttpResponse {
  final String body;
  final int statusCode;
  final String? errorMessage;

  StandardHttpResponse({required this.body, required this.statusCode, this.errorMessage});

  factory StandardHttpResponse.fromHttpResponse(http.Response response) {
    Map<String, dynamic> map = json.decode(response.body);
    return StandardHttpResponse(
      body: map['result']!=null?json.encode(map['result'] as Map<String,dynamic>):"{}",
      statusCode: response.statusCode,
      errorMessage: response.statusCode != 200 ? map['errorMessage'] : "",
    );
  }
}

abstract class HttpRepo {
  Future<StandardHttpResponse> get({required String host});

  Future<StandardHttpResponse> post({required String host, Map<String, dynamic>? body});

  Future<StandardHttpResponse> put({required String host, Map<String, dynamic>? body});
}

class HttpClientImpl implements HttpRepo {
  @override
  Future<StandardHttpResponse> get({required String host}) async {
    try {
      final result = await http.get(Uri.parse(host), headers: await headers());
      return StandardHttpResponse.fromHttpResponse(result);
    } on Exception {
      throw Exception();
    }
  }

  @override
  Future<StandardHttpResponse> post({required String host, Map<String, dynamic>? body}) async {
    try {
      final result = await http.post(Uri.parse(host), headers: await headers(), body: json.encode(body));
      return StandardHttpResponse.fromHttpResponse(result);
    } on Exception {
      throw Exception();
    }
  }

  @override
  Future<StandardHttpResponse> put({required String host, Map<String, dynamic>? body}) async {
    try {
      final result = await http.put(Uri.parse(host), headers: await headers(), body: json.encode(body));
      return StandardHttpResponse.fromHttpResponse(result);
    } on Exception {
      throw Exception();
    }
  }
}
