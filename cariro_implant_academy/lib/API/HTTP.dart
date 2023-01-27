import 'dart:convert';

import 'package:cariro_implant_academy/API/MicrosoftAPI_Response.dart';
import 'package:http/http.dart';

import '../Models/API_Response.dart';

String host = "https://localhost:7128/api";

class HTTPRequest {
  static Future<API_Response> Get(String url) async {
    API_Response apiResponse = API_Response();
    Response response =
        await get(Uri.parse("$host/$url")).onError((error, stackTrace) {
      apiResponse = API_Response(
          errorMessage: error.toString() + " or server is unreachable",
          statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse =
          API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r =
          MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
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
      apiResponse = API_Response(
          errorMessage: "Internal Server Error",
          statusCode: response.statusCode);
    }
    return apiResponse;
  }

  static Future<API_Response> Post(
      String url, Map<String, dynamic>? body) async {
    API_Response apiResponse = API_Response();
    Response response = await post(
      Uri.parse("$host/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers":
            "Origin, X-Requested-With, Content-Type, Accept"
      },
      body: body != null ? jsonEncode(body) : "",
    ).onError((error, stackTrace) {
      apiResponse = API_Response(
          errorMessage: error.toString() + " or server is unreachable",
          statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse =
          API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r =
          MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
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
      apiResponse = API_Response(
          errorMessage: "Internal Server Error",
          statusCode: response.statusCode);
    }

    return apiResponse;
  }

  static Future<API_Response> Put(String url, Object? body) async {
    API_Response apiResponse = API_Response();
    Response response = await put(
      Uri.parse("$host/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
        "Access-Control-Allow-Headers":
            "Origin, X-Requested-With, Content-Type, Accept"
      },
      body: body == null ? jsonEncode("") : jsonEncode(body),
    ).onError((error, stackTrace) {
      apiResponse = API_Response(
          errorMessage: error.toString() + " or server is unreachable",
          statusCode: 500);
      return Response("body", 500);
    }).catchError((value) {
      apiResponse =
          API_Response(errorMessage: value.toString(), statusCode: 500);
    }).timeout(Duration(seconds: 20), onTimeout: () {
      return Response("body", 408);
    });
    if (response.statusCode != 200) {
      MicrosoftAPI_Response r =
          MicrosoftAPI_Response.fromJson(jsonDecode(response.body));
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
      apiResponse = API_Response(
          errorMessage: "Internal Server Error",
          statusCode: response.statusCode);
    }

    return apiResponse;
  }
}
