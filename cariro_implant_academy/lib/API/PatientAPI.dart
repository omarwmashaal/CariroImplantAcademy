import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
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

  static Future<API_Response> ListPatients({String? search,String? filter}) async {
    API_Response response = API_Response();
    if(search!=null)
      response = await HTTPRequest.Get("PatientInfo/ListPatients?search=$search&filter=$filter");
    else
     response = await HTTPRequest.Get("PatientInfo/ListPatients");

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

  static Future<API_Response> CreatePatient(PatientInfoModel patient) async {
    var response =
        await HTTPRequest.Post("PatientInfo/CreatePatient", patient.toJson());

    return response;
  }

  static Future<API_Response> CompareDuplicateNumber(String number) async {
    var response = await HTTPRequest.Post(
        "PatientInfo/CompareDuplicateNumber?number=$number", null);

    if (response.statusCode == 200) {
      if (response.result != null)
        response.result =
            PatientInfoModel.fromJson(response.result as Map<String, dynamic>);
      else
        response.result = PatientInfoModel();
    }

    return response;
  }

  static Future<API_Response> ScheduleVisit(VisitsModel model) async {
    var response = await HTTPRequest.Post(
        "PatientInfo/ScheduleVisit", model.toJson());

    return response;
  }

  static Future<API_Response> GetAllSchedules() async {
    var response = await HTTPRequest.Get("PatientInfo/GetAllSchedules");

    if (response.statusCode == 200) {
      if (response.result == null)
        response.result = <VisitsModel>[];
      else {
        response.result = (response.result as List<dynamic>)
            .map((e) => VisitsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return response;
  }
 static Future<API_Response> GetScheduleForDoctor() async {
    var response = await HTTPRequest.Get("PatientInfo/GetScheduleForDoctor");

    if (response.statusCode == 200) {
      if (response.result == null)
        response.result = <VisitsModel>[];
      else {
        response.result = (response.result as List<dynamic>)
            .map((e) => VisitsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return response;
  }


  static Future<API_Response> QuickSearch(String name) async {
    var response = await HTTPRequest.Get("PatientInfo/QuickSearch?name=$name");

    if (response.statusCode == 200) {
      if (response.result == null)
        response.result = <DropDownDTO>[];
      else {
        response.result = (response.result as List<dynamic>)
            .map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }

    return response;
  }
}
