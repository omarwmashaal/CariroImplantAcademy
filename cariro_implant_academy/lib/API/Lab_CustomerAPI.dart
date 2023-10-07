import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Models/LAB_CustomerModel.dart';
import 'package:cariro_implant_academy/Models/Lab_PatientModel.dart';

import '../Models/API_Response.dart';
import '../Models/ApplicationUserModel.dart';
import '../Models/PatientInfo.dart';
import 'HTTP.dart';

class Lab_CustomerAPI {
  static Future<API_Response> GetAllWorkPlaces() async {
    var response = await HTTPRequest.Get("Lab_Customers/GetAllWorkPlaces");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetAllCusomters() async {
    var response = await HTTPRequest.Get("Lab_Customers/GetAllCusomters");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ApplicationUserModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetCusomter(int id) async {
    var response = await HTTPRequest.Get("Lab_Customers/GetCusomter?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ApplicationUserModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> SearchPatientsByType({required String search, required EnumLabRequestSources type}) async {
    var response = API_Response();
    response = await HTTPRequest.Get("Lab_Customers/SearchPatientsByType?search=$search&type=${type.index}");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => PatientInfoModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> AddCustomer(ApplicationUserModel model) async {
    var response = await HTTPRequest.Post("Lab_Customers/AddCustomer", model.toJson());

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ApplicationUserModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }
}
