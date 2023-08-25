import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class StandardHttpResponse {
  final Object? body;
  final int statusCode;
  final String? errorMessage;

  StandardHttpResponse({this.body, required this.statusCode, this.errorMessage});

  factory StandardHttpResponse.fromHttpResponse(http.Response response) {
    final map = json.decode(response.body);
    return StandardHttpResponse(
      body: map['result'],
      statusCode: response.statusCode,
      errorMessage: response.statusCode != 200 ? map['errorMessage'] : "",
    );
  }

  factory StandardHttpResponse.fromDIOResponse(dio.Response response) {
    final map = (response.data);
    return StandardHttpResponse(
      body: () {
        try {
          return map['result'] != null ? json.encode(map['result']) : null;
        } catch (e) {
          return map['result'].toString();
        }
      }(),
      statusCode: response.statusCode ?? 400,
      errorMessage: response.statusCode != 200 ? map['errorMessage'] : "",
    );
  }
}

abstract class HttpRepo {
  Future<StandardHttpResponse> get({required String host});

  Future<StandardHttpResponse> post({required String host, Map<String, dynamic>? body});

  Future<StandardHttpResponse> put({required String host, Map<String, dynamic>? body});

  Future<StandardHttpResponse> uploadImage({required String url, required Uint8List imageBytes});
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
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<StandardHttpResponse> put({required String host, Map<String, dynamic>? body}) async {
    try {
      final result = await http.put(Uri.parse(host), headers: await headers(), body: json.encode(body));
      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<StandardHttpResponse> uploadImage({required String url, required Uint8List imageBytes}) async {
    try {
      var formData = dio.FormData.fromMap({'FileUpload': await dio.MultipartFile.fromBytes(imageBytes, filename: 'image')});
      var _dio = dio.Dio();
      var response = await _dio.put(
        "$url",
        data: formData,
      );
      return StandardHttpResponse.fromDIOResponse(response);
    } catch (e) {
      throw e;
    }
  }
}
