import 'dart:convert';

import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/features/authentication/data/models/AuthenticationUserModel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Http/httpRepo.dart';

abstract class LoginStatusDataSource {
  Future<AuthenticationUserModel> checkLoginStatus();
}

class LoginStatusDataSourceImpl implements LoginStatusDataSource {
  HttpRepo client;

  LoginStatusDataSourceImpl(this.client);

  @override
  Future<AuthenticationUserModel> checkLoginStatus() async {
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
      throw HttpInternalServerErrorException();
    }
    if (result.statusCode == 200 && result.body!=null)
      return (AuthenticationUserModel.fromJson(result.body! as Map<String,dynamic>));
    else
      throw LoginException();
  }
}
