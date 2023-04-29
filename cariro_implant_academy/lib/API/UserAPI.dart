import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class UserAPI {
  static Future<API_Response> AddCandidate(ApplicationUserModel model) async {

    var response = await HTTPRequest.Post("User/AddCandidate",model.toJson());
    return response;
  }
 static Future<API_Response> GetInstructors() async {
    var response = await HTTPRequest.Get("User/GetInstructors");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }
static Future<API_Response> GetUserData(int id) async {
    var response = await HTTPRequest.Get("User/GetUserData?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ApplicationUserModel.fromJson ((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetAssistants() async {
    var response = await HTTPRequest.Get("User/GetAssistants");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetAdmins() async {
    var response = await HTTPRequest.Get("User/GetAdmins");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetSecretaries() async {
    var response = await HTTPRequest.Get("User/GetSecretaries");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }static Future<API_Response> GetCandidates() async {
    var response = await HTTPRequest.Get("User/GetCandidates");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> SearchUsersByWorkplace({required String search, required EnumLabRequestSources source}) async {
    var response = await HTTPRequest.Get("User/SearchUsersByWorkplace?search=$search&source=${source.index}");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> ChangeRole(int id, String role) async {
    var response = await HTTPRequest.Put("User/ChangeRole?id=$id&role=$role",null);

    return response;
  }
  static Future<API_Response> RemoveUser(int id) async {
    var response = await HTTPRequest.Delete("User/RemoveUser?id=$id");


    return response;
  }
}
