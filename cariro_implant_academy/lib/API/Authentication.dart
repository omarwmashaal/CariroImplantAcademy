import '../Models/API_Response.dart';
import 'HTTP.dart';

class Authentication {
  static Future<API_Response> Login(String email, String password) async {
    var response = await HTTPRequest.Post("Authentication/Login",
        <String, String>{"email": email, "password": password});

    if (response.statusCode! > 199 && response.statusCode! < 300) {}
    return response;
  }
}
