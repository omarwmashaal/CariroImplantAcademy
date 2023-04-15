import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/MedicalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';


class MedicalAPI {
  static Future<API_Response> GetPatientMedicalExamination(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientMedicalExamination?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result =
          MedicalExaminationModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }
  static Future<API_Response> UpdatePatientMedicalExamination(int id,MedicalExaminationModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientMedicalExamination?id=$id",model.toJson());
    return response;
  }
static Future<API_Response> GetPatientDentalExamination(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientDentalExamination?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result =
          DentalExaminationModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

}
