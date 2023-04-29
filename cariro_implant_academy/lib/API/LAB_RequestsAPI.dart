import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';

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
  }) async {
    var query = "";
    from = CIA_DateConverters.fromDateTimeToBackend(from);
    to = CIA_DateConverters.fromDateTimeToBackend(to);
    if (from != null) query = "from=$from";
    if (to != null) query = query == "" ? query + "to=$to" : query + "&to=$to";
    if (search != null&& search!="")
      {
        query = query == "" ? query + "search=$search" : query + "&search=$search";
      }
    if (paid != null) query = query == "" ? query + "paid=$paid" : query + "&paid=$paid";
    if (status != null) query = query == "" ? query + "status=${status.index}" : query + "&status=${status.index}";
    if (source != null ) query = query == "" ? query + "source=${source.index}" : query + "&source=${source.index}";

    var response = await HTTPRequest.Get("LAB_Requests/GetAllRequests?$query");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = ((response.result ?? []) as List<dynamic>).map((e) => LAB_RequestModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetRequest(int id) async {
    var response = await HTTPRequest.Get("LAB_Requests/GetRequest?id=$id");
    if(response.statusCode == 200)
      {
        response.result  = LAB_RequestModel.fromJson((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
      }
    return response;
  }

  static Future<API_Response> AddRequest(LAB_RequestModel model) async {
    model.source = model.customer!.workPlaceEnum;
    var response = await HTTPRequest.Post("LAB_Requests/AddRequest", model.toJson());
    return response;
  }
}
