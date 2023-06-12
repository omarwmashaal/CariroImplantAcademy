import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/Lab_StepModel.dart';

import '../Models/API_Response.dart';
import '../Models/DTOs/DropDownDTO.dart';
import '../Models/LAB_RequestModel.dart';
import 'HTTP.dart';

class LAB_RequestsAPI {
  static Future<API_Response> GetAllRequests({
    String? from,
    String? to,
    String? search,
    EnumLabRequestStatus? status,
    EnumLabRequestSources? source,
    bool? paid,
    bool myRequests = false,
  }) async {
    var query = "";
    from = CIA_DateConverters.fromDateTimeToBackend(from);
    to = CIA_DateConverters.fromDateTimeToBackend(to);
    if (from != null) query = "from=$from";
    if (to != null) query = query == "" ? query + "to=$to" : query + "&to=$to";
    if (search != null && search != "") {
      query = query == "" ? query + "search=$search" : query + "&search=$search";
    }
    if (paid != null) query = query == "" ? query + "paid=$paid" : query + "&paid=$paid";
    if (status != null) query = query == "" ? query + "status=${status.index}" : query + "&status=${status.index}";
    if (source != null) query = query == "" ? query + "source=${source.index}" : query + "&source=${source.index}";
    if (myRequests != null) query = query == "" ? query + "myRequests=${myRequests}" : query + "&myRequests=${myRequests}";

     API_Response response = await HTTPRequest.Get("LAB_Requests/GetAllRequests?$query");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => LAB_RequestModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetPatientRequests(int id) async {
    var response = await HTTPRequest.Get("LAB_Requests/GetPatientRequests?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => LAB_RequestModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetRequest(int id) async {
    var response = await HTTPRequest.Get("LAB_Requests/GetRequest?id=$id");
    if (response.statusCode == 200) {
      response.result = LAB_RequestModel.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> AddRequest(LAB_RequestModel model) async {
    model.source = model.customer!.workPlaceEnum;
    var response = await HTTPRequest.Post("LAB_Requests/AddRequest", model.toJson());
    return response;
  }

  static Future<API_Response> GetDefaultStepByName(String name) async {
    var response = await HTTPRequest.Get("LAB_Requests/GetDefaultStepByName?name=$name");
    if (response.statusCode == 200) {
      response.result = DropDownDTO.fromJson((response.result ?? Map<String, dynamic>()) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetDefaultSteps() async {
    var response = await HTTPRequest.Get("LAB_Requests/GetDefaultSteps");
    if (response.statusCode == 200) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> AddToMyTasks(int id) async {
    var response = await HTTPRequest.Post("LAB_Requests/AddToMyTasks?id=$id", null);

    return response;
  }

  static Future<API_Response> FinishTask({required int id, int? nextTaskId, int? assignToId, String? notes = ""}) async {
    var query = "id=$id";
    if (nextTaskId != null) query += "${query == "" ? "" : "&"}nextTaskId=$nextTaskId";
    if (assignToId != null) query += "${query == "" ? "" : "&"}assignToId=$assignToId";
    if (notes != null) query += "${query == "" ? "" : "&"}notes=$notes";
    var response = await HTTPRequest.Post("LAB_Requests/FinishTask?$query", null);

    return response;
  }

  static Future<API_Response> MarkRequestAsDone(int id, String? notes) async {
    var query = "id=$id";
    if (notes != null) query += "&notes=$notes";
    var response = await HTTPRequest.Post("LAB_Requests/MarkRequestAsDone?$query", null);

    return response;
  }

  static Future<API_Response> AddOrUpdateRequestReceipt(int id, List<LAB_StepModel> steps) async {
    var response = await HTTPRequest.Post("LAB_Requests/AddOrUpdateRequestReceipt?id=$id", steps.map((e) => e.toJson()).toList());

    return response;
  }
}
