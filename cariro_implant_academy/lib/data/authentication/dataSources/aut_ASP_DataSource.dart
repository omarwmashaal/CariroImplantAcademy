import 'dart:convert';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/data/authentication/models/AuthenticationUserModel.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:http/http.dart' as http;

abstract class Auth_ASP_DataSource {
  Future<AuthenticationUserModel> login(LoginParams loginParams);

  Future<bool> logOut();
}

class Auth_ASP_DataSourceImpl implements Auth_ASP_DataSource {
  final HttpRepo client;

  Auth_ASP_DataSourceImpl(this.client);

  @override
  Future<AuthenticationUserModel> login(LoginParams loginParams) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(host: "$serverHost/$authenticationController/Login", body: loginParams.toJson());

    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode == 200 && result.body!=null)
      return AuthenticationUserModel.fromJson(result.body! as Map<String,dynamic>);
    else
      throw LoginException();

    // throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
