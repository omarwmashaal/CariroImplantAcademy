import 'dart:math';

import 'package:cariro_implant_academy/core/domain/repositories/inputValidationRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/checkDuplicateNumberUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'checkDuplicateNumberUseCase_test.mocks.dart';
import 'patientSearchByNameUseCase_test.mocks.dart';

@GenerateMocks([InputValidationRepo])
void main() {
  late MockPatientInfoRepo mockPatientRepo;
  late CheckDuplicateNumberUseCase useCase;
  late MockInputValidationRepo mockInputValidationRepo;

  setUp(() {
    mockInputValidationRepo = MockInputValidationRepo();
    mockPatientRepo = MockPatientInfoRepo();
    useCase = CheckDuplicateNumberUseCase(patientRepo: mockPatientRepo,inputValidationRepo: mockInputValidationRepo);
  });


  test("Should return left inputvalidation  failure if validation failed", () async {
    when(mockPatientRepo.compareDuplicateNumber(any)).thenAnswer((realInvocation) async => Right(""));
    when(mockInputValidationRepo.validateStringToInt(any)).thenAnswer((realInvocation)  => Left(InputValidationFailure(failureMessage: 'invalid input')));
    final result = await useCase("s");
    verifyZeroInteractions(mockPatientRepo);
    expect(result, Left(InputValidationFailure(failureMessage: "invalid input")));
  });

  test("Should call compare number if validation true", () async {
    when(mockPatientRepo.compareDuplicateNumber(any)).thenAnswer((realInvocation) async => Right(""));
    when(mockInputValidationRepo.validateStringToInt(any)).thenAnswer((realInvocation)  => Right(true));
    await useCase("s");
    verify(mockPatientRepo.compareDuplicateNumber("s"));
    verify(mockInputValidationRepo.validateStringToInt("s"));
  });
  test("Should return String value if found", () async {
    when(mockInputValidationRepo.validateStringToInt(any)).thenAnswer((realInvocation)  => Right(true));
    when(mockPatientRepo.compareDuplicateNumber(any)).thenAnswer((realInvocation) async => Right("ss"));
    final result = await useCase("s");
    expect(result, Right("ss"));
  });
  test("Should return null value if not found", () async {
    when(mockInputValidationRepo.validateStringToInt(any)).thenAnswer((realInvocation)  => Right(true));
    when(mockPatientRepo.compareDuplicateNumber(any)).thenAnswer((realInvocation) async => Right(null));
    final result = await useCase("s");
    expect(result, Right(null));
  });
}
