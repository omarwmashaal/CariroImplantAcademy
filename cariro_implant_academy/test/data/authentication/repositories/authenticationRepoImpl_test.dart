import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/data/authentication/dataSources/aut_ASP_DataSource.dart';
import 'package:cariro_implant_academy/data/authentication/models/AuthenticationUserModel.dart';
import 'package:cariro_implant_academy/data/authentication/repositories/authenticationRepoImpl.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/authenticationUserEntity.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../fixtures/fixture.dart';
import 'authenticationRepoImpl_test.mocks.dart';

@GenerateMocks([Auth_ASP_DataSource])
void main() {
  late MockAuth_ASP_DataSource mockDataSource;
  late AuthenticationRepoImpl repoImpl;
  setUp(() {
    mockDataSource = MockAuth_ASP_DataSource();
    repoImpl = AuthenticationRepoImpl(mockDataSource);
  });
  final loginParams = LoginParams(email: "email", password: "password");
  final loginResponse = AuthenticationUserModel.fromJson(json.decode(fixture("authentication/loginResponse.json")));
  final AuthenticationUserEntity loginResponseEntity = loginResponse;
  setUpSuccess() {
    SharedPreferences.setMockInitialValues({});
    when(mockDataSource.login(loginParams)).thenAnswer(
      (realInvocation) async => loginResponse,
    );
  }
  setUpServerException() {
    when(mockDataSource.login(loginParams)).thenThrow(HttpInternalServerErrorException());
  }
  setUpLoginLogOutException() {
    when(mockDataSource.login(loginParams)).thenThrow(LoginException());
  }


  test(
    "Should call dataSource login when login",
    () async {
      setUpSuccess();
      await repoImpl.login(loginParams);
      verify(mockDataSource.login(loginParams));
    },
  );
  test(
    "Should return loginResponse if success",
    () async {
      setUpSuccess();
      final result = await repoImpl.login(loginParams);
      expect(result, Right(loginResponseEntity));
    },
  );
  test(
    "Should Save token if success",
    () async {
      final pref = await SharedPreferences.getInstance();
      setUpSuccess();
     await repoImpl.login(loginParams);
      expect(pref.getString("token"), loginResponse.token);
    },
  );
  test(
    "Should Save role if success",
    () async {
      final pref = await SharedPreferences.getInstance();
      setUpSuccess();
     await repoImpl.login(loginParams);
      expect(pref.getString("role"), loginResponse.role);
    },
  );
  test(
    "Should Save userid if success",
    () async {
      final pref = await SharedPreferences.getInstance();
      setUpSuccess();
     await repoImpl.login(loginParams);
      expect(pref.getInt("userid"), loginResponse.idInt);
    },
  );
  test(
    "Should return ServerFailure if serverException",
    () async {
      setUpServerException();
      final result = await repoImpl.login(loginParams);
      expect(result, Left(HttpInternalServerErrorFailure()));
    },
  );
  test(
    "Should return LoginFailure if loginException",
    () async {
      setUpLoginLogOutException();
      final result = await repoImpl.login(loginParams);
      expect(result, Left(LoginFailure()));
    },
  );
}
