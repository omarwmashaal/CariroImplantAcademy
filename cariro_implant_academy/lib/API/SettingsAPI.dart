import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/ImplantModel.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class SettingsAPI {
  static Future<API_Response> GetAllImplants() async {
    var response = await HTTPRequest.Get("Settings/GetAllImplants");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => ImplantModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetImplantCompanies() async {
    var response = await HTTPRequest.Get("Settings/GetImplantCompanies");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetImplantLines(int id) async {
    var response = await HTTPRequest.Get("Settings/GetImplantLines?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }


  static Future<API_Response> GetImplants(int id) async {
    var response = await HTTPRequest.Get("Settings/GetImplants?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => ImplantModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetImplant(int id) async {
    var response = await HTTPRequest.Get("Settings/GetImplant?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetMembranes(int id) async {
    var response = await HTTPRequest.Get("Settings/GetMembranes?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetTacs(int id) async {
    var response = await HTTPRequest.Get("Settings/GetTacs?id=$id");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetMembraneCompanies() async {
    var response = await HTTPRequest.Get("Settings/GetMembraneCompanies");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetTacsCompanies() async {
    var response = await HTTPRequest.Get("Settings/GetTacsCompanies");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetAllTacs() async {
    var response = await HTTPRequest.Get("Settings/GetAllTacs");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetAllMembranes() async {
    var response = await HTTPRequest.Get("Settings/GetAllMembranes");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }




  static Future<API_Response> GetExpensesCategories() async {
    var response = await HTTPRequest.Get("Settings/GetExpensesCategories");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetIncomeCategories() async {
    var response = await HTTPRequest.Get("Settings/GetIncomeCategories");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetSuppliers() async {
    var response = await HTTPRequest.Get("Settings/GetSuppliers");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }
  static Future<API_Response> GetStockCategories() async {
    var response = await HTTPRequest.Get("Settings/GetStockCategories");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> GetPaymentMethods() async {
    var response = await HTTPRequest.Get("Settings/GetPaymentMethods");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => DropDownDTO.fromJson(e as Map<String, dynamic>)).toList();
    }
    return response;
  }

  static Future<API_Response> ChangeImplantCompanyName(int id, String name) async {
    var response = await HTTPRequest.Put("Settings/ChangeImplantCompanyName?id=$id&name=$name",null);
    return response;
  }

  static Future<API_Response> ChangeImplantLineName(int id, String name) async {
    var response = await HTTPRequest.Put("Settings/ChangeImplantLineName?id=$id&name=$name",null);
    return response;
  }

  static Future<API_Response> AddImplants(int id,List<ImplantModel> model) async {
    var response = await HTTPRequest.Put("Settings/Implants?id=$id",model.map((e) => e.toJson()).toList());
    return response;
  }

  static Future<API_Response> AddImplantLines(int id, String name) async {
    var response = await HTTPRequest.Put("Settings/ImplantLines?id=$id&name=$name",null);
    return response;
  }

  static Future<API_Response> AddImplantCompanies( String name) async {
    var response = await HTTPRequest.Put("Settings/ImplantCompanies?name=$name",null);
    return response;
  }

  static Future<API_Response> AddMembranes(int id, List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddMembranes?id=$id",model.map((e) => e.toJson()).toList());
    return response;
  }

  static Future<API_Response> AddTacs(int id, List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddTacs?id=$id",model.map((e) => e.toJson()).toList());
    return response;
  }


  static Future<API_Response> AddTacsCompanies( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddTacsCompanies?",model.map((e) => e.toJson()).toList());
    return response;
  }


  static Future<API_Response> AddMembraneCompanies( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddMembraneCompanies?",model.map((e) => e.toJson()).toList());
    return response;
  }



  static Future<API_Response> AddExpensesCategories( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddExpensesCategories?",model.map((e) => e.toJson()).toList());
    return response;
  }



  static Future<API_Response> AddIncomeCategories( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddIncomeCategories?",model.map((e) => e.toJson()).toList());
    return response;
  }



  static Future<API_Response> AddSuppliers( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddSuppliers?",model.map((e) => e.toJson()).toList());
    return response;
  }



  static Future<API_Response> AddStockCategories( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddStockCategories?",model.map((e) => e.toJson()).toList());
    return response;
  }



  static Future<API_Response> AddPaymentMethods( List<DropDownDTO> model) async {
    var response = await HTTPRequest.Put("Settings/AddPaymentMethods?",model.map((e) => e.toJson()).toList());
    return response;
  }





}
