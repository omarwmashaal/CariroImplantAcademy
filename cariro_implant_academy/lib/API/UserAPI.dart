import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class UserAPI {
  static Future<API_Response> AddCandidate(ApplicationUserModel model) async {

    model.email = "dummy@email.com";
    var response = await HTTPRequest.Post("User/AddCandidate",model.toJson());
    return response;
  }
  //TODO: REMOVE THIS
  static Future<API_Response> GetCandidates({String? search,int? batch}) async {
    var query = "";
    if(search!=null) query+= "${query==""?"":"&"}search=$search";
    if(batch!=null) query+= "${query==""?"":"&"}batch=${batch.toString()}";
    var response = await HTTPRequest.Get("User/GetCandidates?$query");

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
  static Future<API_Response> SearcshUsersByRole({String? search, required UserRoles role}) async {
    API_Response response =API_Response();
    if(search==null)
      response = await HTTPRequest.Get("User/SearcshUsersByRole?role=${role.index}");
    else
      response = await HTTPRequest.Get("User/SearcshUsersByRole?search=$search&role=${role.index}");

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
  static Future<API_Response> GetUserData(int id) async {
    var response = await HTTPRequest.Get("User/GetUserData?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ApplicationUserModel.fromJson ((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
    }
    return response;
  }

static Future<API_Response> UpdateUserInfo(ApplicationUserModel user) async {
    var response = await HTTPRequest.Put("User/UpdateUserInfo?id=${user.idInt}",user.toJson());
    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ApplicationUserModel.fromJson ((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
    }
    return response;
  }

}
