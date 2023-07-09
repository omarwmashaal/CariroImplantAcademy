import 'dart:convert';

import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/data/authentication/models/UserModel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Http/httpRepo.dart';

abstract class LoginStatusDataSource {
  Future<UserModel> checkLoginStatus();
}

class LoginStatusDataSourceImpl implements LoginStatusDataSource {
  HttpRepo client;

  LoginStatusDataSourceImpl(this.client);

  @override
  Future<UserModel> checkLoginStatus() async {
    late StandardHttpResponse result;
    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.get("token");
    if(token==null)
      throw LoginException();
    try {
      result = await client.post(
        host: "$serverHost/$authenticationController/VerifyToken",
      );
    } on Exception {
      throw ServerException();
    }
    if (result.statusCode == 200)
      return (UserModel.fromJson(json.decode(result.body)));
    else
      throw LoginException();
  }
}
