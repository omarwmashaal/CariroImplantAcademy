import 'package:cariro_implant_academy/Models/CashFlow.dart';

import '../Models/API_Response.dart';
import '../Models/CashFlowSummaryModel.dart';
import 'HTTP.dart';

class CashFlowAPI {
  static Future<API_Response> ListIncome() async {
    var response = await HTTPRequest.Get("CashFlow/ListIncome");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => CashFlowModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> ListExpenses() async {
    var response = await HTTPRequest.Get("CashFlow/ListExpenses");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => CashFlowModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetSummary(String filter) async {
    var response = await HTTPRequest.Get("CashFlow/GetSummary?filter=$filter");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = CashFlowSummaryModel.fromJson((response.result ?? Map<String, dynamic>) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetIncomeByCategory(int categoryID, String filter) async {
    var response = await HTTPRequest.Get("CashFlow/GetIncomeByCategory?categoryID=$categoryID&filter=$filter");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = CashFlowSummaryModel.fromJson((response.result ?? Map<String, dynamic>) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> GetExpensesByCategory(int categoryID, String filter) async {
    var response = await HTTPRequest.Get("CashFlow/GetExpensesByCategory?categoryID=$categoryID&filter=$filter");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = CashFlowSummaryModel.fromJson((response.result ?? Map<String, dynamic>) as Map<String, dynamic>);
    }
    return response;
  }

  static Future<API_Response> AddIncome(CashFlowModel model) async {
    var response = await HTTPRequest.Post("CashFlow/AddIncome", model.toJson());

    return response;
  }

  static Future<API_Response> AddExpense(List<CashFlowModel> models, bool isStockItem) async {
    var response = await HTTPRequest.Post("CashFlow/AddExpense?isStockItem=$isStockItem", models.map((e) => e.toJson()).toList());

    return response;
  }
}