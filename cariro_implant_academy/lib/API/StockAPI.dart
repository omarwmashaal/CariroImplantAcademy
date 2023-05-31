import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/StockModel.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';
class StockAPI{
  static Future<API_Response> GetAllStock({String? search}) async {
    if(search=="")search = null;
    var response = await HTTPRequest.Get("Stock/GetAllStock?${search!=null?"search=$search":""}");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => StockModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetStockById(int id) async {
    var response = await HTTPRequest.Get("Stock/GetStockById?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = StockModel.fromJson((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
    }
    return response;
  }
  static Future<API_Response> GetStockByName(String name) async {
    var response = await HTTPRequest.Get("Stock/GetStockByName?name=$name");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = StockModel.fromJson((response.result??Map<String,dynamic>()) as Map<String,dynamic>);
    }
    return response;
  }
  static Future<API_Response> GetStockLogs({String? search}) async {
    if(search=="")search = null;
    var response = await HTTPRequest.Get("Stock/GetStockLogs?${search!=null?"search=$search":""}");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => StockLogModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> AddItem(StockModel model) async {
    var t = {
      "name":model.name,
      "count":model.count,
      "category":(model.category??DropDownDTO()).name,
    };
    var response = await HTTPRequest.Post("Stock/AddItem?",t);
    return response;
  }
  static Future<API_Response> ConsumeItem(int id, int count) async {
    var response = await HTTPRequest.Post("Stock/ConsumeItem?id=$id&count=$count",null);
    return response;
  }

  static Future<API_Response> RemoveItem(int id) async {
    var response = await HTTPRequest.Delete("Stock/ConsumeItem?id=$id");
    return response;
  }

}