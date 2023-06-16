import 'dart:typed_data';

import 'package:cariro_implant_academy/API/HTTP.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/ComplainsModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/AdvancedPatientSearchDTO.dart';
import 'package:cariro_implant_academy/Models/DTOs/AdvancedTreatmentSearchDTO.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/PaymentLogModel.dart';
import 'package:cariro_implant_academy/Models/ReceiptModel.dart';

import '../Models/VisitsModel.dart';

class PatientAPI {
  static Future<API_Response> GetPatientData(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetPatientInfo?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = PatientInfoModel.fromJson(response.result as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UpdatePatientDate(PatientInfoModel patient) async {
    var response = await HTTPRequest.Put("PatientInfo/UpdatePatientsInfo", patient.toJson());

    if (response.statusCode! > 199 && response.statusCode! < 300) {}
    return response;
  }

  static Future<API_Response> ListPatients({String? search, String? filter, bool? myPatients}) async {
    API_Response response = API_Response();
    if (search != null)
      response = await HTTPRequest.Get("PatientInfo/ListPatients?search=$search&filter=$filter&myPatients=${myPatients ?? "false"}");
    else
      response = await HTTPRequest.Get("PatientInfo/ListPatients?myPatients=${myPatients ?? "false"}");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List).map((e) => PatientInfoModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetVisitsLogs(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetVisitsLog?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List).map((e) => VisitsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> PatientVisits(int id) async {
    var response = await HTTPRequest.Put("PatientInfo/PatientVisits?id=$id", null);

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List).map((e) => VisitsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> PatientEntersClinic(int id) async {
    var response = await HTTPRequest.Put("PatientInfo/PatientEntersClinic?id=$id", null);

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List).map((e) => VisitsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> PatientLeaves(int id) async {
    var response = await HTTPRequest.Put("PatientInfo/PatientLeavesClinic?id=$id", null);

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List).map((e) => VisitsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> CreatePatient(PatientInfoModel patient) async {
    var response = await HTTPRequest.Post("PatientInfo/CreatePatient", patient.toJson());
    if (response.statusCode == 200) {
      response.result = PatientInfoModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> CompareDuplicateNumber(String number) async {
    var response = await HTTPRequest.Post("PatientInfo/CompareDuplicateNumber?number=$number", null);

    if (response.statusCode == 200) {
      if (response.result != null)
        response.result = PatientInfoModel.fromJson(response.result as Map<String, dynamic>);
      else
        response.result = PatientInfoModel();
    }

    return response;
  }

  static Future<API_Response> ScheduleVisit(VisitsModel model) async {
    var response = await HTTPRequest.Post("PatientInfo/ScheduleVisit", model.toJson());

    return response;
  }

  static Future<API_Response> GetAllSchedules() async {
    var response = await HTTPRequest.Get("PatientInfo/GetAllSchedules");

    if (response.statusCode == 200) {
      if (response.result == null)
        response.result = <VisitsModel>[];
      else {
        response.result = (response.result as List<dynamic>).map((e) => VisitsModel.fromJson(e as Map<String, dynamic>)).toList();
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
        response.result = (response.result as List<dynamic>).map((e) => VisitsModel.fromJson(e as Map<String, dynamic>)).toList();
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
        response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
      }
    }

    return response;
  }

  static Future<API_Response> ResolveComplain(int id) async {
    var response = await HTTPRequest.Put("PatientInfo/ResolveComplain?id=$id", null);

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ComplainsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> InQueueComplain(int id,String? notes) async {
    var query = "id=$id";
    if(notes!=null) query+= "&notes=$notes";
    var response = await HTTPRequest.Put("PatientInfo/InQueueComplain?$query", null);

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ComplainsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> UpdateComplainNotes(int id,String notes) async {
    var response = await HTTPRequest.Put("PatientInfo/UpdateComplainNotes?id=$id&notes=$notes", null);

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ComplainsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> AddComplain(ComplainsModel model) async {
    var response = await HTTPRequest.Post("PatientInfo/AddComplain", model.toJson());

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ComplainsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetComplains({int? id, String? search, EnumComplainStatus? status}) async {
    API_Response response = API_Response();
    if (id != null)
      response = await HTTPRequest.Get("PatientInfo/GetComplains?id=$id");
    else {
      var query = "";
      if (status != null) query = "status=${status.index}";
      if (search != null && search != "") {
        query = query == "" ? query + "search=$search" : query + "&search=$search";
      }
      response = await HTTPRequest.Get("PatientInfo/GetComplains?$query");
    }

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ComplainsModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    return response;
  }

  static Future<API_Response> GetTodaysReceipt(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetTodaysReceipt?id=$id");

    if (response.statusCode == 200) {
      response.result = ReceiptModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetLastReceipt(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetLastReceipt?id=$id");

    if (response.statusCode == 200) {
      response.result = ReceiptModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetReceipts(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetReceipts?id=$id");

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => ReceiptModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetAllPaymentLogs(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetAllPaymentLogs?id=$id");

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => PaymentLogModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetPaymentLogsForAReceipt(int id, int receiptId) async {
    var response = await HTTPRequest.Get("PatientInfo/GetPaymentLogsForAReceipt?id=$id&receiptId=$receiptId");

    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => PaymentLogModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> AddPayment(int id, int receiptId, int paidAmount) async {
    var response = await HTTPRequest.Post("PatientInfo/AddPayment?id=$id&receiptId=$receiptId&paidAmount=$paidAmount", null);
    return response;
  }

  static Future<API_Response> RemovePayment(int id) async {
    var response = await HTTPRequest.Post("PatientInfo/RemovePayment?id=$id", null);
    return response;
  }

  static Future<API_Response> GetTotalDebt(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetTotalDebt?id=$id");

    if (response.statusCode == 200) {
      response.result = response.result ?? 0 as int;
    }
    return response;
  }

  static Future<API_Response> GetReceiptById(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/GetReceiptById?id=$id");

    if (response.statusCode == 200) {
      response.result = ReceiptModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> UploadImage(int id, EnumImageType type, Uint8List imageBytess) async {
    var response = await HTTPRequest.UploadImage("PatientInfo/UploadImage?id=$id&type=${type.index}", imageBytess);
    return response;
  }

  static Future<API_Response> AddToMyPatients(int id) async {
    var response = await HTTPRequest.Post("PatientInfo/AddToMyPatients?id=$id", null);
    return response;
  }
  static Future<API_Response> RemoveFromMyPatients(int id) async {
    var response = await HTTPRequest.Post("PatientInfo/RemoveFromMyPatients?id=$id", null);
    return response;
  }
  static Future<API_Response> DownloadImage(int id) async {
    var response = await HTTPRequest.Get("PatientInfo/DownloadImage?id=$id");
    return response;
  }

  static Future<API_Response> AdvancedSearchPatient(AdvancedPatientSearchDTO query) async {
    var response = await HTTPRequest.Post("PatientInfo/AdvancedSearchPatient",query.toJson());
    if(response.statusCode==200)
      {
        response.result = ((response.result) as List<dynamic>).map((e) => AdvancedPatientSearchDTO.fromJson(e as Map<String,dynamic>)).toList();
      }
    return response;
  }
  static Future<API_Response> AdvancedSearchTreatment(AdvancedTreatmentSearchDTO query) async {
    var response = await HTTPRequest.Post("PatientInfo/AdvancedSearchTreatment",query.toJson());
    if(response.statusCode==200)
      {
        response.result = ((response.result) as List<dynamic>).map((e) => AdvancedTreatmentSearchDTO.fromJson(e as Map<String,dynamic>)).toList();
      }
    return response;
  }
}
