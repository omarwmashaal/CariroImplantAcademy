import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/domain/patients/repositories/addOrRemoveMyPatientsRangeRepo.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/addRangeToMyPatientsUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'addRangeToMyPatientsUseCase_test.mocks.dart';

@GenerateMocks([AddOrRemoveMyPatientsRepo])
void main() {
  late MockAddOrRemoveMyPatientsRepo mockRepo;
  late AddRangeToMyPatientsUseCase useCase;

  setUp(() {
    mockRepo = MockAddOrRemoveMyPatientsRepo();
    useCase = AddRangeToMyPatientsUseCase(mockRepo);
  });
  final tParams = AddRangePatientsParams(to: 200, from: 100);
  test(
    "Should call repo function",
    () async {
      when(mockRepo.addToMyPatientsRange(tParams)).thenAnswer((realInvocation) async => Right(true));
      await useCase(tParams);
      verify(mockRepo.addToMyPatientsRange(tParams));
    },
  );
  test(
    "Should return right true if success",
    () async {
      when(mockRepo.addToMyPatientsRange(tParams)).thenAnswer((realInvocation) async => Right(true));
      final result = await useCase(tParams);
      expect(result, Right(true));
    },
  );
  test(
    "Should return Left ServerFailure if failed",
    () async {
      when(mockRepo.addToMyPatientsRange(tParams)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
      final result = await useCase(tParams);
      expect(result, Left(HttpInternalServerErrorFailure()));
    },
  );
  test(
    "Should return Left InputValidationFailure if input validation",
    () async {
      when(mockRepo.addToMyPatientsRange(tParams)).thenAnswer((realInvocation) async => Left(InputValidationFailure(failureMessage: "Wrong")));
      final result = await useCase(tParams);
      expect(result, Left(InputValidationFailure(failureMessage: "Wrong")));
    },
  );

  test(
    "Should throw InputValidation Exception if from>to",
    () async {
      final result = await useCase(AddRangePatientsParams(from: 100, to: 50));
      expect(result, Left(InputValidationFailure(failureMessage: "from can't be greater than or equal to")));
    },
  );
  test(
    "Should throw InputValidation Exception if from=to",
    () async {
      final result = await useCase(AddRangePatientsParams(from: 100, to: 100));
      expect(result, Left(InputValidationFailure(failureMessage: "from can't be greater than or equal to")));
    },
  );
}
