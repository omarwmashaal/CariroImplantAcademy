import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/API_Response.dart';
import '../Models/DTOs/LoginResponseDTO.dart';
import '../SignalR/Config.dart';
import 'HTTP.dart';

class AuthenticationAPI {
  static Future<API_Response> Login(String? email, String? password) async {
    var response = await HTTPRequest.Post("Authentication/Login", <String, String>{"email":email??"", "password": password??""});
    var tempToken = await siteController.getToken();
    if (response.statusCode! > 199 && response.statusCode! < 300) {
      LoginResponseDTO loginResponse = LoginResponseDTO.fromJson(response.result as Map<String, dynamic>);
      siteController.setRole(loginResponse.role!);
      await siteController.setToken(loginResponse.token!);
      SharedPreferences.getInstance().then((value) {
        value.setString("token", loginResponse!.token!);
      });
      siteController.setUser(loginResponse.user!);
      await SignalR.runConfig();
      var newToken = await siteController.getToken();
      if(tempToken!=newToken)
        await SignalR.AssignConnection();
      if(siteController.notifications.value.isEmpty)
        await NotificationsAPI.GetNotifications();
    }
    else{
      await siteController.removeToken();
      siteController.setUser(ApplicationUserModel());
    }
    return response;
  }

  static Future<API_Response> Register(ApplicationUserModel model) async {
    if(model.role=="candidate") model.email="";
    var response = await HTTPRequest.Post(r"Authentication/Register?password=Pa$$word1", model.toJson());

    return response;
  }
  static Future<API_Response> ResetPassword(String oldPassword, String newPassword1,String newPassword2) async {
    var response = await HTTPRequest.Post("Authentication/ResetPassword?oldPassword=$oldPassword&newPassword1=$newPassword1&newPassword2=$newPassword2",null);

    return response;
  }


  static Future<API_Response> Test() async {
    var response = await HTTPRequest.Get(r"Authentication/Register?password=Pa$$word1");

    return response;
  }
}
