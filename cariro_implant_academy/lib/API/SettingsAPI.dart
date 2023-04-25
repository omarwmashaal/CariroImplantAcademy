import 'package:cariro_implant_academy/Models/ImplantModel.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class SettingsAPI{
  static Future<API_Response> GetAllImplants() async {
    var response = await HTTPRequest.Get("Settings/GetAllImplants");

    if (response.statusCode! > 199 && response.statusCode! < 300) {
      response.result = (response.result as List<dynamic>).map((e) => ImplantModel.fromJson(e as Map<String,dynamic>)).toList();

    }
    return response;
  }

}