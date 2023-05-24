import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/MedicalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/SurgicalTreatmentModel.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/TreatmentPlanModel.dart';

import '../Models/MedicalModels/DentalHistory.dart';
import '../Models/MedicalModels/NonSurgicalTreatment.dart';
import '../Models/MedicalModels/ProstheticTreatmentModel.dart';
import '../Models/MedicalModels/TreatmentPrices.dart';

class MedicalAPI {
  static Future<API_Response> GetPatientMedicalExamination(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientMedicalExamination?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = MedicalExaminationModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UpdatePatientMedicalExamination(int id, MedicalExaminationModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientMedicalExamination?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> GetPatientDentalExamination(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientDentalExamination?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = DentalExaminationModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UpdatePatientDentalExamination(int id, DentalExaminationModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientDentalExamination?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> GetPatientDentalHistory(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientDentalHistory?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = DentalHistoryModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UpdatePatientDentalHistory(int id, DentalHistoryModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientDentalHistory?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> GetPatientNonSurgicalTreatment(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientNonSurgicalTreatment?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = NonSurgicalTreatmentModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetPatientAllNonSurgicalTreatments(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientAllNonSurgicalTreatments?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result =
          (response.result as List<dynamic>).map((e) => NonSurgicalTreatmentModel.fromJson((e ?? Map<String, dynamic>) as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> CheckNonSurgicalTreatementTeethStatus(String value) async {
    var response = await HTTPRequest.Get("Medical/CheckNonSurgicalTreatementTeethStatus?treatment=$value");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => e as int).toList();
    }
    return response;
  }

  static Future<API_Response> AddPatientNonSurgicalTreatment(int id, NonSurgicalTreatmentModel model) async {
    var response = await HTTPRequest.Put("Medical/AddPatientNonSurgicalTreatment?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> GetPatientTreatmentPlan(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientTreatmentPlan?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = TreatmentPlanModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
      var pricesRes = await SettingsAPI.GetTreatmentPrices();
      if (pricesRes.statusCode == 200) {
        var prices = pricesRes.result as TreatmentPrices;
        (response.result as TreatmentPlanModel).treatmentPlan!.forEach((element) {
          if (element.crown != null) element.crown!.price = prices.crown;
          if (element.extraction != null) element.extraction!.price = prices.extraction;
          if (element.rootCanalTreatment != null) element.rootCanalTreatment!.price = prices.rootCanalTreatment;
          if (element.restoration != null) element.restoration!.price = prices.restoration;
          if (element.scaling != null) element.scaling!.price = prices.scaling;
        });
      }
    }
    return response;
  }

  static Future<API_Response> UpdatePatientTreatmentPlan(int id, List<TreatmentPlanSubModel> model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientTreatmentPlan?id=$id", model.map((e) => e.toJson()).toList());
    return response;
  }

  static Future<API_Response> GetPatientSurgicalTreatment(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientSurgicalTreatment?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = SurgicalTreatmentModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UpdatePatientSurgicalTreatment(int id, SurgicalTreatmentModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientSurgicalTreatment?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> AddPatientReceipt(int id, int tooth, String action) async {
    var response = await HTTPRequest.Put("Medical/AddPatientReceipt?id=$id&tooth=$tooth&action=$action", null);
    return response;
  }

  static Future<API_Response> UpdatePatientProstheticTreatmentFinalProthesisSingleBridge(int id, ProstheticTreatmentModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientProstheticTreatmentFinalProthesisSingleBridge?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> UpdatePatientProstheticTreatmentDiagnostic(int id, ProstheticTreatmentModel model) async {
    var response = await HTTPRequest.Put("Medical/UpdatePatientProstheticTreatmentDiagnostic?id=$id", model.toJson());
    return response;
  }

  static Future<API_Response> GetPatientProstheticTreatmentDiagnostic(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientProstheticTreatmentDiagnostic?id=$id");
    if(response.statusCode==200)
      {
        response.result = ProstheticTreatmentModel.fromJson((response.result ?? Map<String,dynamic>())as Map<String,dynamic>);
      }
    return response;
  }

  static Future<API_Response> GetPatientProstheticTreatmentFinalProthesisSingleBridge(int id) async {
    var response = await HTTPRequest.Get("Medical/GetPatientProstheticTreatmentFinalProthesisSingleBridge?id=$id");
    if(response.statusCode==200)
    {
      response.result = ProstheticTreatmentModel.fromJson((response.result ?? Map<String,dynamic>())as Map<String,dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetPaidPlanItem(int id, int tooth, String action) async {
    var response = await HTTPRequest.Get("Medical/GetPaidPlanItem?id=$id&tooth=$tooth&action=$action");
    Map<String, TreatmentPlanFieldsModel?> result = Map();
    if (response.statusCode == 200) {
      var pricesRes = await SettingsAPI.GetTreatmentPrices();

      var prices = pricesRes.result as TreatmentPrices;

      result['crown'] = (response.result as Map<String, dynamic>)['crown'] == null
          ? null
          : TreatmentPlanFieldsModel.fromJson((response.result as Map<String, dynamic>)['crown'] ?? Map<String, dynamic>());
      result['extraction'] = (response.result as Map<String, dynamic>)['extraction'] == null
          ? null
          : TreatmentPlanFieldsModel.fromJson((response.result as Map<String, dynamic>)['extraction'] ?? Map<String, dynamic>());
      result['scaling'] = (response.result as Map<String, dynamic>)['scaling'] == null
          ? null
          : TreatmentPlanFieldsModel.fromJson((response.result as Map<String, dynamic>)['scaling'] ?? Map<String, dynamic>());
      result['restoration'] = (response.result as Map<String, dynamic>)['restoration'] == null
          ? null
          : TreatmentPlanFieldsModel.fromJson((response.result as Map<String, dynamic>)['restoration'] ?? Map<String, dynamic>());
      result['rootCanalTreatment'] = (response.result as Map<String, dynamic>)['rootCanalTreatment'] == null
          ? null
          : TreatmentPlanFieldsModel.fromJson((response.result as Map<String, dynamic>)['rootCanalTreatment'] ?? Map<String, dynamic>());
      if (result['crown'] != null && result['crown']!.planPrice == 0) result['crown']!.planPrice = prices.crown;
      if (result['extraction'] != null && result['extraction']!.planPrice == 0) result['extraction']!.planPrice = prices.extraction;
      if (result['scaling'] != null && result['scaling']!.planPrice == 0) result['scaling']!.planPrice = prices.scaling;
      if (result['restoration'] != null && result['restoration']!.planPrice == 0) result['restoration']!.planPrice = prices.restoration;
      if (result['rootCanalTreatment'] != null && result['rootCanalTreatment']!.planPrice == 0)
        result['rootCanalTreatment']!.planPrice = prices.rootCanalTreatment;
      response.result = result;
    }
    return response;
  }
}
