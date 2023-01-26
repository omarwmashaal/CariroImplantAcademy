import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';

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

  static Future<API_Response> UpdateMedicalExamination(
      int id, MedicalExaminationModel medicalExamination) async {
    var response = await HTTPRequest.Put(
        "TempPatient/UpdatePatientMedicalExamination?id=$id",
        medicalExamination.toJson());

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = MedicalExaminationModel.fromJson(
          response.result as Map<String, dynamic>);
    }
    return response;
  }
}
