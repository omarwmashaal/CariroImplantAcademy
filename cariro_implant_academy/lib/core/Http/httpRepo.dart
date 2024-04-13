import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/pages/authentication_page.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/routing/routingBloc.dart';
import 'package:cariro_implant_academy/core/routing/routing_Bloc_Events.dart';
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
        errorMessage: (response.statusCode != 200
                ? map['errorMessage'] ??
                    () {
                      String error = "";
                      try {
                        if (map["errors"] != null) {
                          try {
                            List<String> errors = (map["errors"] as List<dynamic>).map((e) => e as String).toList();
                            if (errors.length > 1)
                              error = errors[1];
                            else
                              error = errors[0];
                          } catch (e) {
                            Map<String, dynamic> errors = (map["errors"] as Map<String, dynamic>);
                            if (errors.values.length > 1)
                              error = errors.values.toList()[1].toString();
                            else
                              error = errors.values.first.toString();
                          }
                        }
                      } catch (e) {
                        error = map['title'] ?? "";
                      }
                      if (error.contains(r"$.")) {
                        error = "Error in " + error.split(" ").firstWhere((element) => element.contains(r"$.")).replaceAll(r"$.", "");
                      }
                      return error;
                    }()
                : "")
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", ""));
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

  Future<StandardHttpResponse> post({required String host, dynamic? body});

  Future<StandardHttpResponse> put({required String host, dynamic? body});
  Future<StandardHttpResponse> delete({required String host, dynamic? body});

  Future<StandardHttpResponse> uploadImage({required String url, required Uint8List imageBytes});
}

class HttpClientImpl implements HttpRepo {
  @override
  Future<StandardHttpResponse> get({required String host}) async {
    late http.Response result;
    try {
      result = await http.get(Uri.parse(host), headers: headers());
      print(result.statusCode);
      if (result.statusCode == 401) sl<RoutingBloc>().add(RoutingBlocEvent_UnAuthorized());
      return StandardHttpResponse.fromHttpResponse(result);
    } on Exception {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
    }
  }

  @override
  Future<StandardHttpResponse> post({required String host, dynamic? body}) async {
    late http.Response result;
    try {
      result = await http.post(Uri.parse(host), headers: headers(), body: json.encode(body));
      if (result.statusCode == 401) sl<RoutingBloc>().add(RoutingBlocEvent_UnAuthorized());
      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
    }
  }

  @override
  Future<StandardHttpResponse> put({required String host, dynamic? body}) async {
    late http.Response result;
    print("put");
    try {
      result = await http.put(Uri.parse(host), headers: headers(), body: json.encode(body));
      print(result);
      if (result.statusCode == 401) sl<RoutingBloc>().add(RoutingBlocEvent_UnAuthorized());
      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
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

  @override
  Future<StandardHttpResponse> delete({required String host, body}) async {
    late http.Response result;
    try {
      result = await http.delete(Uri.parse(host), headers: headers(), body: json.encode(body));
      print(result);
      if (result.statusCode == 401) sl<RoutingBloc>().add(RoutingBlocEvent_UnAuthorized());
      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
    }
  }
}
