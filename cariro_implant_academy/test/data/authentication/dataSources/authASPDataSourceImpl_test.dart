import 'dart:convert';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/features/authentication/data/datasources/aut_ASP_DataSource.dart';
import 'package:cariro_implant_academy/core/features/authentication/data/models/AuthenticationUserModel.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../fixtures/fixture.dart';
import 'authASPDataSourceImpl_test.mocks.dart';

@GenerateMocks([HttpRepo])
void main() {
  late MockHttpRepo mockClient;
  late Auth_ASP_DataSourceImpl dataSource;

  setUp(() {
    mockClient = MockHttpRepo();
    dataSource = Auth_ASP_DataSourceImpl(mockClient);
  });
  final tLoginResponse = fixture("authentication/loginResponse.json");
  final loginParams = LoginParams(password: "password", email: "email");
  setUpLoginSuccess() {
    SharedPreferences.setMockInitialValues({});
    when(mockClient.post( host: anyNamed("host"), body: anyNamed("body"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(body: json.decode(fixture("authentication/loginResponse.json")), statusCode: 200),
    );
  }

  setUpLoginFailed() {
    SharedPreferences.setMockInitialValues({});
    when(mockClient.post( host: anyNamed("host"), body: anyNamed("body"))).thenAnswer(
      (realInvocation) async =>StandardHttpResponse(body: fixture("authentication/loginResponse.json"), statusCode: 400),
    );
  }

  setUpLoginException() {
    SharedPreferences.setMockInitialValues({});
    when(mockClient.post(host: anyNamed("host"), body: anyNamed("body"))).thenThrow(
      Exception(),
    );
  }

  test(
    "Should call client post when login",
    () async {
      setUpLoginSuccess();
      await dataSource.login(loginParams);
      verify(mockClient.post(host: anyNamed("host"), body: anyNamed("body")));
    },
  );
  test(
    "Should return correct UserModel format if success",
    () async {
      setUpLoginSuccess();
      final result = await dataSource.login(loginParams);
      expect(result, AuthenticationUserModel.fromJson(json.decode(tLoginResponse)));
    },
  );
  test(
    "Should throw server exception on exception",
    () async {
      SharedPreferences.setMockInitialValues({});
      setUpLoginException();
      final call = dataSource.login;
      expect(() => call(loginParams), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
    },
  );

  test(
    "Should throw login exception on status code not 200",
    () async {
      setUpLoginFailed();
      final call = dataSource.login;
      expect(() => call(loginParams), throwsA(TypeMatcher<LoginException>()));
    },
  );
}
