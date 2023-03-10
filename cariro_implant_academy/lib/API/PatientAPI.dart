import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';

import '../Models/VisitsModel.dart';

class PatientAPI {
  static Future<API_Response> GetPatientData(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetPatientInfo?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result =
          PatientInfoModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UpdatePatientDate(
      PatientInfoModel patient) async {
    var response = await HTTPRequest.Put(
        "PatientInfo/UpdatePatientsInfo", patient.toJson());

    if (response.statusCode! > 199 && response.statusCode! < 300) {}
    return response;
  }

  static Future<API_Response> ListPatients() async {
    var response = await HTTPRequest.Get("PatientInfo/ListPatients");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List)
          .map((e) => PatientInfoModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return response;
  }

  static Future<API_Response> GetVisitsLogs(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetVisitsLog?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List)
          .map((e) => VisitsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return response;
  }

  static Future<API_Response> PatientVisits(int id) async {
    var response =
        await HTTPRequest.Put("PatientInfo/PatientVisits?id=$id", null);

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List)
          .map((e) => VisitsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return response;
  }

  static Future<API_Response> PatientEntersClinic(int id) async {
    var response =
        await HTTPRequest.Put("PatientInfo/PatientEntersClinic?id=$id", null);

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List)
          .map((e) => VisitsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return response;
  }

  static Future<API_Response> PatientLeaves(int id) async {
    var response =
        await HTTPRequest.Put("PatientInfo/PatientLeavesClinic?id=$id", null);

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List)
          .map((e) => VisitsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return response;
  }
}
