import 'dart:math';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getNextAvailableIdUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'patientSearchByNameUseCase_test.mocks.dart';

void main() {
  late MockPatientInfoRepo mockRepo;
  late GetNextAvailableIdUseCase useCase;

  setUp(() {
    mockRepo = MockPatientInfoRepo();
    useCase = GetNextAvailableIdUseCase(mockRepo);
  });
  test(
    "Should call repo getnextavailable id",
    ()async {
      when(mockRepo.getNextAvailableId()).thenAnswer((realInvocation) async => Right(5));
      await useCase(NoParams());
      verify(mockRepo.getNextAvailableId());
      },
  );
  test(
    "Should return right in number if success",
    () async{
      when(mockRepo.getNextAvailableId()).thenAnswer((realInvocation) async => Right(5));
      final result = await mockRepo.getNextAvailableId();
      expect(result, Right(5));
    },
  );
  test(
    "Should return Left failure if failed",
    () async{
      when(mockRepo.getNextAvailableId()).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
      final result = await mockRepo.getNextAvailableId();
      expect(result, Left(HttpInternalServerErrorFailure()));
    },
  );
}
