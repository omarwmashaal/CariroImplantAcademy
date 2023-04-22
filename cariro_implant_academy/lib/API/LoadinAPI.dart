import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class LoadinAPI {
  static Future<API_Response> LoadInstructors() async {
    var response = await HTTPRequest.Get("User/LoadInstructors");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result =
          DropDownDTO.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> LoadAssistants() async {
    var response = await HTTPRequest.Get("User/LoadAssistants");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String,dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> LoadInstructorsAndAssistants() async {
    var response = await HTTPRequest.Get("User/LoadInstructorsAndAssistants");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }

  static Future<API_Response> LoadCandidatesBatches() async {
    var response = await HTTPRequest.Get("User/LoadCandidatesBatches");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }

  static Future<API_Response> LoadCandidates() async {
    var response = await HTTPRequest.Get("User/LoadCandidates");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }

  static Future<API_Response> LoadRooms() async {
    var response = await HTTPRequest.Get("Settings/LoadRooms");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }
 static Future<API_Response> GetAvailableRooms(String from, String to) async {
    var response = await HTTPRequest.Get("PatientInfo/GetAvailableRooms?from=$from&to=$to");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }

}
