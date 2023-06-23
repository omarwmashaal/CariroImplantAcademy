import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/hub_connection.dart';

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

  static Future<API_Response> ResetPasswordForUser(int id) async {
    var response = await HTTPRequest.Post("Authentication/ResetPasswordForUser?id=$id",null);

    return response;
  }

  static Future<API_Response> VerifyToken() async {
    var response = await HTTPRequest.Get("Authentication/VerifyToken");
    if(response.statusCode==200)
      {
        siteController.setRole((response.result as Map<String,dynamic>)['role'] as String);
        var user = siteController.getUser();
        user.name = (response.result as Map<String,dynamic>)['name'] as String;
        user.idInt = (response.result as Map<String,dynamic>)['id'] as int;
        user.phoneNumber = (((response.result as Map<String,dynamic>)['phoneNumber'])??"") as String;
        if(!SignalR.checkConnection())
          {
            await SignalR.runConfig();
          }
        NotificationsAPI.GetNotifications();
      }
    else {
      siteController.setRole("");
      siteController.setUser(ApplicationUserModel());
      await siteController.removeToken();
    }
    return response;
  }

  static Future<API_Response> Test() async {
    var response = await HTTPRequest.Get(r"Authentication/Register?password=Pa$$word1");

    return response;
  }
}
