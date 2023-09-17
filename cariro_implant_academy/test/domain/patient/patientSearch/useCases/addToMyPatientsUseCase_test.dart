import 'dart:math';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/addOrRemoveMyPatientsRangeRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/addToMyPatientsUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addRangeToMyPatientsUseCase_test.mocks.dart';
import 'patientSearchByNameUseCase_test.mocks.dart';

@GenerateMocks([AddOrRemoveMyPatientsRepo])
void main() {
  late MockAddOrRemoveMyPatientsRepo mockRepo;
  late AddToMyPatientsUseCase useCase;
  late MockPatientInfoRepo mockPatientInfoRepoRepo;

  setUp(() {
    mockRepo = MockAddOrRemoveMyPatientsRepo();
    mockPatientInfoRepoRepo = MockPatientInfoRepo();
    useCase = AddToMyPatientsUseCase(addOrRemoveMyPatientsRepo: mockRepo, patientInfoRepo: mockPatientInfoRepoRepo);
    SharedPreferences.setMockInitialValues({});
  });
  group(
    "Testing add range",
    () {
      test(
        "Should call repo function if userid != doctor id",
        () async {
          SharedPreferences.setMockInitialValues({"userid":5});
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 6)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Right(true));
          await useCase(1);
          verify(mockRepo.addToMyPatients(1));
        },
      );
      test(
        "Should not call repo function if userid == doctor id",
        () async {
          SharedPreferences.setMockInitialValues({"userid":5});
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 5)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Right(true));
          await useCase(1);
          verifyZeroInteractions(mockRepo);
        },
      );
      test(
        "Should return right true if success",
        () async {
          SharedPreferences.setMockInitialValues({"userid":5});
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 6)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Right(true));
          final result = await useCase(2);
          expect(result, Right(true));
        },
      );
      test(
        "Should return Left ServerFailure if failed",
        () async {
          SharedPreferences.setMockInitialValues({"userid":5});
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 6)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
          final result = await useCase(3);
          expect(result, Left(HttpInternalServerErrorFailure()));
        },
      );
    },
  );

  group(
    "Testing add patient to my",
    () {
      test(
        "Should call Get patient info ",
        () async {
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity()));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
          await useCase(3);
          verify(mockPatientInfoRepoRepo.getPatient(3));
        },
      );
      test(
        "Should return left serverfailure if get patinets failed and no interaction with add ",
        () async {
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
         // when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
          final result = await useCase(3);
          verify(mockPatientInfoRepoRepo.getPatient(3));
          verifyZeroInteractions(mockRepo);
          expect(result, Left(HttpInternalServerErrorFailure()));
        },
      );
      test(
        "Should return badrequest failure if patients doctor already same ",
        () async {
          SharedPreferences.setMockInitialValues({"userid":3});
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 3)));
          final result = await useCase(3);
          expect(result, Left(BadRequestFailure(failureMessage: "Patient is already your patient")));
        },
      );
      test(
        "Should call add patient if patient doctor is not the id",
        () async {
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 4)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
           await useCase(3);
            verify (mockRepo.addToMyPatients(3));
        },
      );
      test(
        "Should return LEft fAILURE if fAILURE",
        () async {
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 4)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
           final result = await useCase(3);
           expect(result, Left(HttpInternalServerErrorFailure()));
        },
      );
      test(
        "Should return Right true if success",
        () async {
          when(mockPatientInfoRepoRepo.getPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoEntity(doctorId: 4)));
          when(mockRepo.addToMyPatients(any)).thenAnswer((realInvocation) async => Right(true));
           final result = await useCase(3);
           expect(result, Right(true));
        },
      );
    },
  );
}
