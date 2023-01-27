import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';

import '../Models/MedicalModels/DentalHistory.dart';
import '../Models/MedicalModels/MedicalExaminationModel.dart';

class TempPatientAPI {
  static Future<API_Response> CreateTempPatient(int id) async {
    var response =
        await HTTPRequest.Post("TempPatient/CreateTempPatient?id=$id", null);

    return response;
  }

  static Future<API_Response> GetMedicalExamination(int id) async {
    var response = await HTTPRequest.Get(
        "TempPatient/GetPatientMedicalExamination?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = MedicalExaminationModel.fromJson(
          response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetDentalHistory(int id) async {
    var response =
        await HTTPRequest.Get("TempPatient/GetPatientDentalHistory?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result =
          DentalHistoryModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetDentalExamination(int id) async {
    var response =
        await HTTPRequest.Get("TempPatient/GetPatientDentalExamination?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).length == 0
          ? <DentalExaminationModel>[]
          : (response.result as List)
              .map((e) => DentalExaminationModel.fromJson(e))
              .toList();
    }
    return response;
  }

  static Future<API_Response> UpdateMedicalExamination(
      int id, MedicalExaminationModel medicalExamination) async {
    var response = await HTTPRequest.Put(
        "TempPatient/UpdatePatientMedicalExamination?id=$id",
        medicalExamination.toJson());

    if (response.statusCode! > 199 && response.statusCode! < 300) {}
    return response;
  }

  static Future<API_Response> UpdateDentalHistory(
      int id, DentalHistoryModel dentalHistory) async {
    var response = await HTTPRequest.Put(
        "TempPatient/UpdatePatientDentalHistory?id=$id",
        dentalHistory.toJson());

    return response;
  }

  static Future<API_Response> UpdateDentalExamination(
      int id, List<DentalExaminationModel> dentalExamination) async {
    var response = await HTTPRequest.Put(
        "TempPatient/UpdatePatientDentalExamination?id=$id",
        dentalExamination.map((e) => e.toJson()).toList());

    return response;
  }
}
