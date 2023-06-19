import 'dart:typed_data';

import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CandidateDetails.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class UserAPI {


  static Future<API_Response> GetSessionsDurations({required int id, String?from,String? to}) async {
    var query = "id=$id";
    if(from!=null) query += "&from=$from";
    if(to!=null) query += "&to=$to";
    var response = await HTTPRequest.Get("User/GetSessionsDurations?$query");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => VisitsModel.fromJson(e as Map<String,dynamic>)).toList();
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
  static Future<API_Response> SearcshUsersByRole({String? search, required UserRoles role,int? batch}) async {
    API_Response response =API_Response();
    var query = "";
    if(search!=null) query+= "${query==""?"":"&"}search=$search";
    if(batch!=null) query+= "${query==""?"":"&"}batch=${batch.toString()}";
    query+= "${query==""?"":"&"}role=${role.index}";
    response = await HTTPRequest.Get("User/SearcshUsersByRole?$query");


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
      var res  = await GetRoleById((response.result as ApplicationUserModel).idInt!);
      if(res.statusCode==200) ((response.result) as ApplicationUserModel).role = res.result as String;
    }
    return response;
  }
  static Future<API_Response> GetRoleById(int id) async {
    var response = await HTTPRequest.Get("User/GetRoleById?id=$id");

    return response;
  }

static Future<API_Response> UpdateUserInfo(ApplicationUserModel user) async {
    var response = await HTTPRequest.Put("User/UpdateUserInfo?id=${user.idInt}",user.toJson());
    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ApplicationUserModel.fromJson ((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
    }
    return response;
  }
static Future<API_Response> GetCandidateDetails(int id,{String? from,String? to}) async {
    var query = "id=$id";
    if(from!=null) query+="&from=$from";
    if(to!=null) query+="&to=$to";
    var response = await HTTPRequest.Get("User/GetCandidateDetails?$query");
    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result??[]) as List<dynamic>).map((e) => CandidateDetails.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }
  static Future<API_Response> DownloadImage(int id) async {
    var response = await HTTPRequest.Get("User/DownloadImage?id=$id");
    return response;
  }

  static Future<API_Response> UploadImage(int id, EnumImageType type, Uint8List imageBytess) async {
    var response = await HTTPRequest.UploadImage("User/UploadImage?id=$id&type=${type.index}", imageBytess);
    return response;
  }

}
