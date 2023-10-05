import 'dart:convert';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/features/authentication/data/models/AuthenticationUserModel.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:http/http.dart' as http;

import '../../../../useCases/useCases.dart';

abstract class Auth_ASP_DataSource {
  Future<AuthenticationUserModel> login(LoginParams loginParams);

  Future<NoParams> registerUser(UserEntity user);

  Future<bool> logOut();

  Future<NoParams> resetPasswordForUser(int id);
}

class Auth_ASP_DataSourceImpl implements Auth_ASP_DataSource {
  final HttpRepo client;

  Auth_ASP_DataSourceImpl(this.client);

  @override
  Future<AuthenticationUserModel> login(LoginParams loginParams) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(host: "$serverHost/$authenticationController/Login", body: loginParams.toJson());
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode == 200 && result.body != null)
      return AuthenticationUserModel.fromJson(result.body! as Map<String, dynamic>);
    else
      throw LoginException();

    // throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<NoParams> registerUser(UserEntity user) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(
        host: "$serverHost/$authenticationController/Register",
        body: UserModel.fromEntity(user).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }

    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
    // throw UnimplementedError();
  }

  @override
  Future<NoParams> resetPasswordForUser(int id) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(
        host: "$serverHost/$authenticationController/ResetPasswordForUser?id=$id",
      );
    } catch (e) {
      throw mapException(e);
    }

    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
    // throw UnimplementedError();
  }
}
