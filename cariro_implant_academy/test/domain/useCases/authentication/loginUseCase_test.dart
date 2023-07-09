import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'loginUseCase_test.mocks.dart';

@GenerateMocks([AuthenticationRepo])
void main() {
  late LoginUseCase useCase;
  late MockAuthenticationRepo mockAuthenticationRepo;
  setUp(
    () {
      mockAuthenticationRepo = MockAuthenticationRepo();
      useCase = LoginUseCase(mockAuthenticationRepo);
    },
  );
  final tLoginParams = LoginParams(email: "email", password: "password");
  final tLoginResponse = UserEntity(
    name: "string",
    token: "string",
    idInt: 0,
    phoneNumber: "string",
    role: "string",
    phone: "string",
  );
  test(
    "Should call login from repo and return correct response",
    () async {
      when(mockAuthenticationRepo.login(tLoginParams)).thenAnswer((realInvocation) async => Right(tLoginResponse));
      final result = await useCase(tLoginParams);
      verify(mockAuthenticationRepo.login(tLoginParams));
      expect(result, Right(tLoginResponse));
    },
  );
}
