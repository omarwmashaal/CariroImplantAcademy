import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';

import '../Models/API_Response.dart';
import '../Models/DTOs/LoginResponseDTO.dart';
import 'HTTP.dart';

class AuthenticationAPI {
  static Future<API_Response> Login(String email, String password) async {
    var response = await HTTPRequest.Post("Authentication/Login", <String, String>{"email": email, "password": password});

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      LoginResponseDTO loginResponse = LoginResponseDTO.fromJson(response.result as Map<String, dynamic>);
      siteController.setRole(loginResponse.role!);
      siteController.setToken(loginResponse.token!);
      siteController.setUser(loginResponse.user!);
    }
    return response;
  }

  static Future<API_Response> Register(ApplicationUserModel model) async {
    if(model.role=="candidate") model.email="";
    var response = await HTTPRequest.Post(r"Authentication/Register?password=Pa$$word1", model.toJson());

    return response;
  }
}
