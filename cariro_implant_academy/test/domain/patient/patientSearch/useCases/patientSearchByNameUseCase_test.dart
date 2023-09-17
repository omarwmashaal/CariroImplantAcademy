import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientSearchUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'patientSearchByNameUseCase_test.mocks.dart';

@GenerateMocks([PatientInfoRepo])
void main() {
  late MockPatientInfoRepo mockPatientSearchRepo;
  late PatientSearchUseCase useCase;
  setUp(() {
    mockPatientSearchRepo = MockPatientInfoRepo();
    useCase = PatientSearchUseCase(mockPatientSearchRepo);
  });
  final tQuery = PatientSearchParams(myPatients: false,query: "om");
  final List<PatientInfoEntity> tResponse = [
    PatientInfoEntity(
      name: "name1",
      id: 1,
      gender: EnumGender.Male,
      phone: "01231412",
      age: 20,
      maritalStatus: EnumMaritalStatus.Married,
    ),
    PatientInfoEntity(
      name: "name2",
      id: 2,
      gender: EnumGender.Female,
      phone: "0124214",
      age: 40,
      maritalStatus: EnumMaritalStatus.Single,
    ),
    PatientInfoEntity(
      name: "name3",
      id: 3,
      gender: EnumGender.Male,
      phone: "125125",
      age: 50,
      maritalStatus: EnumMaritalStatus.Married,
    ),
  ];
  setUpSuccess() {
    when(mockPatientSearchRepo.searchPatients(tQuery)).thenAnswer((realInvocation) async => Right(tResponse));
  }

  setUpFailed() {
    when(mockPatientSearchRepo.searchPatients(tQuery)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
  }

  setUpFailedConversion() {
    when(mockPatientSearchRepo.searchPatients(tQuery)).thenAnswer((realInvocation) async => Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE)));
  }

  test(
    "Should call repo searchbyname",
    () async{
      setUpSuccess();
      await useCase(tQuery);
      verify(mockPatientSearchRepo.searchPatients(tQuery));
      verifyNoMoreInteractions(mockPatientSearchRepo);
    },
  );
  test(
    "Should return correct output when success",
    () async{
      setUpSuccess();
      final result = await useCase(tQuery);
      expect(result, Right(tResponse));
    },
  );
  test(
    "Should return Left ServerFailure when failed",
    () async{
      setUpFailed();
      final result = await useCase(tQuery);
      expect(result, Left(HttpInternalServerErrorFailure()));
    },
  );
  test(
    "Should return Left DataConversionFailure when dataConversionFailure",
    () async{
      setUpFailedConversion();
      final result = await useCase(tQuery);
      expect(result, Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE)));

    },
  );

}
