import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/API/MicrosoftAPI_Response.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:http/http.dart';

import '../Constants/Connection.dart';
import '../Models/API_Response.dart';
import 'package:logging/logging.dart';

import '../core/constants/remoteConstants.dart';

class HTTPRequest {
  static Future<API_Response> Get(String url) async {
    Logger("Called Server").log(Level.INFO, "$url");
    API_Response apiResponse = API_Response();
    Response response = await get(Uri.parse("$serverHost/$url"),
            headers: {"Authorization": "Bearer ${await siteController.getToken()}", "Site": siteController.getSite().index.toString()})
        .onError((error, stackTrace) {
      apiResponse = API_Response(errorMessage: error.toString() + " or server is unreachable", statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse = API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r = MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
      if (r.title != null || r.errors != null)
        apiResponse.errorMessage = r.title! + " " + r.errors.toString();
      else
        apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
      return apiResponse;
    }
    try {
      apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      apiResponse = API_Response(errorMessage: "Internal Server Error", statusCode: response.statusCode);
    }
    return apiResponse;
  }

  static Future<API_Response> Post(String url, Object? body) async {
    Logger("Called Server").log(Level.INFO, "$url with body: $body");
    Logger.root.log(Level.INFO, "message");
    API_Response apiResponse = API_Response();
    Response response = await post(
      Uri.parse("$serverHost/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
        "Authorization": "Bearer ${await siteController.getToken()}",
        "Site": siteController.getSite().index.toString()
      },
      body: body != null ? jsonEncode(body) : "",
    ).onError((error, stackTrace) {
      apiResponse = API_Response(errorMessage: error.toString() + " or server is unreachable", statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse = API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r = MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
      if (r.title != null || r.errors != null)
        apiResponse.errorMessage = r.title! + " " + r.errors.toString();
      else
        apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
      return apiResponse;
    }
    try {
      apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      apiResponse = API_Response(errorMessage: "Internal Server Error", statusCode: response.statusCode);
    }

    return apiResponse;
  }

  static Future<API_Response> Put(String url, Object? body) async {
    Logger("Called Server").log(Level.INFO, "$url with body: $body");
    API_Response apiResponse = API_Response();
    Response response = await put(
      Uri.parse("$serverHost/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
        "Authorization": "Bearer ${await siteController.getToken()}",
        "Site": siteController.getSite().index.toString()
      },
      body: body == null ? jsonEncode("") : jsonEncode(body),
    ).onError((error, stackTrace) {
      apiResponse = API_Response(errorMessage: error.toString() + " or server is unreachable", statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse = API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r = MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
      if (r.title != null || r.errors != null)
        apiResponse.errorMessage = r.title! + " " + r.errors.toString();
      else
        apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
      return apiResponse;
    }
    try {
      apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      apiResponse = API_Response(errorMessage: "Internal Server Error", statusCode: response.statusCode);
    }

    return apiResponse;
  }

  static Future<API_Response> Delete(String url) async {
    Logger("Called Server").log(Level.INFO, url);
    API_Response apiResponse = API_Response();
    Response response = await delete(Uri.parse("$serverHost/$url"),
            headers: {"Authorization": "Bearer ${await siteController.getToken()}", "Site": siteController.getSite().index.toString()})
        .onError((error, stackTrace) {
      apiResponse = API_Response(errorMessage: error.toString() + " or server is unreachable", statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse = API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r = MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
      if (r.title != null || r.errors != null)
        apiResponse.errorMessage = r.title! + " " + r.errors.toString();
      else
        apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
      return apiResponse;
    }
    try {
      apiResponse = API_Response.fromJson(jsonDecode(response.body));
      apiResponse.statusCode = response.statusCode;
    } catch (e) {
      apiResponse = API_Response(errorMessage: "Internal Server Error", statusCode: response.statusCode);
    }
    return apiResponse;
  }

  static Future<API_Response> UploadImage(String url, Uint8List imageBytes) async {
    var formData = dio.FormData.fromMap({'FileUpload': await dio.MultipartFile.fromBytes(imageBytes, filename: 'image')});
    var _dio = dio.Dio();
    API_Response response = await _dio
        .put(
          "$serverHost/$url",
          data: formData,
        )
        .catchError((error) {
          dio.DioError e;
          if (error is dio.DioError) {
            e = error as dio.DioError;
            return API_Response(statusCode: 500, errorMessage: e.message);
          }
        })
        .onError((error, stackTrace) => dio.Response(statusCode: 500, statusMessage: error.toString(), data: null, requestOptions: dio.RequestOptions()))
        .then((value) => API_Response(statusCode: value.statusCode, result: value.data, errorMessage: value.statusMessage));

    return response;
  }
}
