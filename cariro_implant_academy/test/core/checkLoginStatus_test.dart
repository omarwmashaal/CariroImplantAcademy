import 'dart:convert';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart';
import 'package:cariro_implant_academy/core/data/repositories/loginStatusRepoImpl.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/checkLogInStatus.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/data/authentication/models/UserModel.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fixtures/fixture.dart';
import 'checkLoginStatus_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([CheckLoginStatusRepo, LoginStatusDataSource, HttpRepo])
void main() {
  late MockCheckLoginStatusRepo mockCheckLoginStatusRepo;
  late MockLoginStatusDataSource mockLoginStatusDataSource;
  late MockHttpRepo mockClient;
  late CheckLoginStatusUseCase useCase;
  late LoginStatusRepoImpl repoImpl;
  late LoginStatusDataSourceImpl dataSourceImpl;

  setUp(() {
    mockLoginStatusDataSource = MockLoginStatusDataSource();
    mockCheckLoginStatusRepo = MockCheckLoginStatusRepo();
    mockClient = MockHttpRepo();
    useCase = CheckLoginStatusUseCase(mockCheckLoginStatusRepo);
    repoImpl = LoginStatusRepoImpl(mockLoginStatusDataSource);
    dataSourceImpl = LoginStatusDataSourceImpl(mockClient);
  });

  final tLoginResponseModel = UserModel.fromJson(json.decode(fixture("authentication/loginResponse.json")));
  final UserEntity tLoginResponse = tLoginResponseModel;
  setUpUserLoggedIn() {
    SharedPreferences.setMockInitialValues({"token": ""});
    when(mockCheckLoginStatusRepo.checkLoginStatus()).thenAnswer((realInvocation) async => Right(tLoginResponse));
    when(mockLoginStatusDataSource.checkLoginStatus()).thenAnswer((realInvocation) async => tLoginResponseModel);
    when(mockClient.post(host: anyNamed("host"), body: anyNamed("body")))
        .thenAnswer((realInvocation) async => StandardHttpResponse(body: fixture("authentication/loginResponse.json"), statusCode: 200));
  }

  setUpUserLoggedOut() {
    SharedPreferences.setMockInitialValues({});
    when(mockCheckLoginStatusRepo.checkLoginStatus()).thenAnswer((realInvocation) async => Left(LoginFailure()));
    when(mockLoginStatusDataSource.checkLoginStatus()).thenThrow(LoginException());
    when(mockClient.post(host: anyNamed("host"), body: anyNamed("body")))
        .thenAnswer((realInvocation) async => StandardHttpResponse(body: fixture("authentication/loginResponse.json"), statusCode: 400));
  }

  setUpFailure() {
    SharedPreferences.setMockInitialValues({"token": ""});
    when(mockCheckLoginStatusRepo.checkLoginStatus()).thenAnswer((realInvocation) async => Left(ServerFailure()));
    when(mockLoginStatusDataSource.checkLoginStatus()).thenThrow(ServerException());
    when(mockClient.post(host: anyNamed("host"), body: anyNamed("body"))).thenThrow(ServerException());
  }

  group(
    "Testing use case",
    () {
      test(
        "Should call repo",
        () async {
          setUpUserLoggedIn();
          await useCase(NoParams());
          verify(mockCheckLoginStatusRepo.checkLoginStatus());
        },
      );
      test(
        "Should return right User if user logged In",
        () async {
          setUpUserLoggedIn();
          final result = await useCase(NoParams());
          expect(result, Right(tLoginResponse));
        },
      );
      test(
        "Should return left LoginFailure if user logged out",
        () async {
          setUpUserLoggedOut();
          final result = await useCase(NoParams());
          expect(result, Left(LoginFailure()));
        },
      );
      test(
        "Should return left Server failure if serverexception",
        () async {
          setUpFailure();
          final result = await useCase(NoParams());
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );

  group(
    "Testing repo impl",
    () {
      test(
        "Should call dataSource",
        () async {
          setUpUserLoggedIn();
          await repoImpl.checkLoginStatus();
          verify(mockLoginStatusDataSource.checkLoginStatus());
        },
      );
      test(
        "Should return right user if user logged in",
        () async {
          setUpUserLoggedIn();
          final result = await repoImpl.checkLoginStatus();
          expect(result, Right(tLoginResponse));
        },
      );
      test(
        "Should return left loginfailure if user logged out",
        () async {
          setUpUserLoggedOut();
          final result = await repoImpl.checkLoginStatus();
          expect(result, Left(LoginFailure()));
        },
      );
      test(
        "Should return Serverfailure if server failed",
        () async {
          setUpFailure();
          final result = await repoImpl.checkLoginStatus();
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );
  group(
    "Testing data source impl",
    () {
      test(
        "Should call client post if sharedpreference has token != null",
        () async {
          setUpUserLoggedIn();
          await dataSourceImpl.checkLoginStatus();
          verify(mockClient.post(host: anyNamed("host"), body: anyNamed("body")));
        },
      );
      test(
        "Should not call client post if sharedpreference has token == null",
        () async {
          setUpUserLoggedOut();
          final call = dataSourceImpl.checkLoginStatus;
          expect(()=>call(), throwsA(TypeMatcher<LoginException>()));
          verifyNever(mockClient.post(host: anyNamed("host"), body: anyNamed("body")));
        },
      );
      test(
        "Should throw loginexception if logged out when shared is null",
        () async {
          setUpUserLoggedOut();
          final call = dataSourceImpl.checkLoginStatus;
          expect(() => call(), throwsA(TypeMatcher<LoginException>()));
        },
      );
      test(
        "Should return user if user logged in",
        () async {
          setUpUserLoggedIn();
          final result = await dataSourceImpl.checkLoginStatus();
          expect(result, tLoginResponseModel);
        },
      );

      test(
        "Should throw LoginException if user logged out",
        () async {
          setUpUserLoggedOut();
          final call = dataSourceImpl.checkLoginStatus;
          expect(() => call(), throwsA(TypeMatcher<LoginException>()));
        },
      );
      test(
        "Should throw ServerException if server failed",
        () async {
          setUpFailure();
          final call = dataSourceImpl.checkLoginStatus;
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
