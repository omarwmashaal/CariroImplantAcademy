import 'dart:math';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/checkDuplicateIdUseCase.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/getNextAvailableIdUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'patientSearchByNameUseCase_test.mocks.dart';

void main() {
  late MockPatientInfoRepo mockRepo;
  late CheckDuplicateIdUseCase useCase;

  setUp(() {
    mockRepo = MockPatientInfoRepo();
    useCase = CheckDuplicateIdUseCase(mockRepo);
  });
  test(
    "Should call repo check duplicate id",
    ()async {
      when(mockRepo.checkDuplicateId(5)).thenAnswer((realInvocation) async => Right(true));
      await useCase(5);
      verify(mockRepo.checkDuplicateId(5));
      },
  );
  test(
    "Should return right true if duplicate",
    () async{
      when(mockRepo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(true));
      final result = await mockRepo.checkDuplicateId(5);
      expect(result, Right(true));
    },
  );
  test(
    "Should return Right false if not duplicate",
    () async{
      when(mockRepo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      final result = await mockRepo.checkDuplicateId(5);
      expect(result, Right(false));
    },
  );
  test(
    "Should return Left failure if failed",
    () async{
      when(mockRepo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
      final result = await mockRepo.checkDuplicateId(5);
      expect(result, Left(HttpInternalServerErrorFailure()));
    },
  );
}
