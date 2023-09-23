import 'dart:convert';
import 'dart:math';
import 'package:bloc_test/bloc_test.dart';
import 'package:cariro_implant_academy/core/domain/useCases/checkLogInStatus.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/data/authentication/models/AuthenticationUserModel.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/authenticationUserEntity.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_blocEvents.dart';
import 'package:cariro_implant_academy/presentation/authentication/bloc/authentication_blocStates.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture.dart';
import 'authenticationBloc_test.mocks.dart';

@GenerateMocks([LoginUseCase, CheckLoginStatusUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late AuthenticationBloc tbloc;
  late MockCheckLoginStatusUseCase mockCheckLoginStatusUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockCheckLoginStatusUseCase = MockCheckLoginStatusUseCase();
    tbloc = AuthenticationBloc(loginUseCase: mockLoginUseCase, checkLoginStatusUseCase: mockCheckLoginStatusUseCase);
  });
  final tLoginParams = LoginParams(email: "email", password: "password");
  final tLoginResponseModel = AuthenticationUserModel.fromJson(json.decode(fixture("authentication/loginResponse.json")));
  final AuthenticationUserEntity tLoginRespinse = tLoginResponseModel;
  test("Should initial state LoggedOut", () {
    expect(tbloc.state, LoggedOutState());
  });
  test("Should run usecase login on login even", () async {
    when(mockLoginUseCase(tLoginParams)).thenAnswer((realInvocation) async => Right(tLoginRespinse));
    tbloc.add(LogInEvent(tLoginParams));
    await untilCalled(mockLoginUseCase(any));
    verify(mockLoginUseCase(tLoginParams));
  });
  blocTest(
    "Should emit logged in state if successful log in",
    build: () => tbloc,
    act: (bloc) => tbloc.add(LogInEvent(tLoginParams)),
    expect: () => [LoggingInState(),LoggedIn(user: tLoginRespinse)],
    setUp: () => when(mockLoginUseCase(tLoginParams)).thenAnswer((realInvocation) async => Right(tLoginRespinse)),
  );
  blocTest(
    "Should emit ErrorState with login message in state if failed log in",
    build: () => tbloc,
    act: (bloc) => tbloc.add(LogInEvent(tLoginParams)),
    expect: () => [LoggingInState(),ErrorState(message: LOGIN_FAILURE_MESSAGE)],
    setUp: () => when(mockLoginUseCase(tLoginParams)).thenAnswer((realInvocation) async => Left(LoginFailure())),
  );
  blocTest(
    "Should emit ErrorState with login message in state if Server error log in",
    build: () => tbloc,
    act: (bloc) => tbloc.add(LogInEvent(tLoginParams)),
    expect: () => [LoggingInState(),ErrorState(message: SERVER_FAILURE_MESSAGE)],
    setUp: () => when(mockLoginUseCase(tLoginParams)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure())),
  );
  blocTest(
    "Should emit Logged out if check login failed",
    build: () => tbloc,
    act: (bloc) => tbloc.add(CheckLogInStatusEvent()),
    expect: () => [LoggedOutState()],
    setUp: () => when(mockCheckLoginStatusUseCase(NoParams())).thenAnswer((realInvocation) async => Left(LoginFailure())),
  );
  blocTest(
    "Should emit Logged in if check login success",
    build: () => tbloc,
    act: (bloc) => tbloc.add(CheckLogInStatusEvent()),
    expect: () => [LoggedIn(user: tLoginRespinse)],
    setUp: () => when(mockCheckLoginStatusUseCase(NoParams())).thenAnswer((realInvocation) async => Right(tLoginRespinse)),
  );
 }
