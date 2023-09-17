import 'dart:convert';

import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/patientSearchDataSource.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientSearchResponseModel.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/patientInfoRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientSearchUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'patientInfoRepoImpl_test.mocks.dart';

@GenerateMocks([PatientSearchDataSource])
void main() {
  late MockPatientSearchDataSource mockPatientSearchDataSource;
  late PatientInfoRepoImpl repo;
  setUp(
    () {
      mockPatientSearchDataSource = MockPatientSearchDataSource();
      repo = PatientInfoRepoImpl(mockPatientSearchDataSource);
    },
  );
  final tQueryName = PatientSearchParams(myPatients: false, query: "om");
  final tResponse = <PatientInfoEntity>[
    PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchFemaleMarriedResponse.json"))),
    PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchMaleSingleResponse.json"))),
    PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchNullResponse.json"))),
  ];
  group("Testing search by name", () {
    test(
      "Should call dataSource search by name",
      () async {
        when(mockPatientSearchDataSource.searchPatients(tQueryName)).thenAnswer(
          (realInvocation) async => (tResponse),
        );
        await repo.searchPatients(tQueryName);
        verify(mockPatientSearchDataSource.searchPatients(tQueryName));
      },
    );
    test(
      "Should return correct output when success",
      () async {
        when(mockPatientSearchDataSource.searchPatients(tQueryName)).thenAnswer(
          (realInvocation) async => (tResponse),
        );
        final result = await repo.searchPatients(tQueryName);
        expect(result, Right(tResponse));
      },
    );
    test(
      "Should return ServerFailure if server Exception",
      () async {
        when(mockPatientSearchDataSource.searchPatients(tQueryName)).thenThrow(HttpInternalServerErrorException());
        final result = await repo.searchPatients(tQueryName);
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
    test(
      "Should return ConversionFailure if conversion Exception",
      () async {
        when(mockPatientSearchDataSource.searchPatients(tQueryName)).thenThrow(DataConversionException(message:DATACONVERSION_FAILURE_MESSAGE));
        final result = await repo.searchPatients(tQueryName);
        expect(result, Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE)));
      },
    );
  });
  group("Testing get patient info", () {
    test(
      "Should call dataSource get Patient ",
      () async {
        when(mockPatientSearchDataSource.getPatient(any)).thenAnswer(
          (realInvocation) async => (tResponse[0]),
        );
        await repo.getPatient(3);
        verify(mockPatientSearchDataSource.getPatient(3));
      },
    );
    test(
      "Should return correct output when success",
      () async {
        when(mockPatientSearchDataSource.getPatient(any)).thenAnswer(
          (realInvocation) async => (tResponse[0]),
        );
        final result = await repo.getPatient(4);
        expect(result, Right(tResponse[0]));
      },
    );
    test(
      "Should return ServerFailure if server Exception",
      () async {
        when(mockPatientSearchDataSource.getPatient(any)).thenThrow(HttpInternalServerErrorException());
        final result = await repo.getPatient(5);
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
    test(
      "Should return ConversionFailure if conversion Exception",
      () async {
        when(mockPatientSearchDataSource.getPatient(5)).thenThrow(DataConversionException(message:DATACONVERSION_FAILURE_MESSAGE));
        final result = await repo.getPatient(5);
        expect(result, Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE)));
      },
    );
  });
  ;
  group("Testing Get Next Available Id", () {
    test(
      "Should call dataSource get next availabe id ",
      () async {
        when(mockPatientSearchDataSource.getNextAvailableId()).thenAnswer(
          (realInvocation) async => (5),
        );
        await repo.getNextAvailableId();
        verify(mockPatientSearchDataSource.getNextAvailableId());
      },
    );
    test(
      "Should return correct output when success",
      () async {
        when(mockPatientSearchDataSource.getNextAvailableId()).thenAnswer(
          (realInvocation) async => (5),
        );
        final result = await repo.getNextAvailableId();
        expect(result, Right(5));
      },
    );
    test(
      "Should return ServerFailure if server Exception",
      () async {
        when(mockPatientSearchDataSource.getNextAvailableId()).thenThrow(HttpInternalServerErrorException());
        final result = await repo.getNextAvailableId();
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
  });
  group("Testing Check duplicate Id", () {
    test(
      "Should call dataSource check duplicate Id ",
      () async {
        when(mockPatientSearchDataSource.checkDuplicateId(any)).thenAnswer(
          (realInvocation) async => (true),
        );
        await repo.checkDuplicateId(5);
        verify(mockPatientSearchDataSource.checkDuplicateId(5));
      },
    );
    test(
      "Should return true when success",
      () async {
        when(mockPatientSearchDataSource.checkDuplicateId(any)).thenAnswer(
          (realInvocation) async => (true),
        );
        final result = await repo.checkDuplicateId(5);
        expect(result, Right(true));
      },
    );
    test(
      "Should return ServerFailure if server Exception",
      () async {
        when(mockPatientSearchDataSource.checkDuplicateId(any)).thenThrow(HttpInternalServerErrorException());
        final result = await repo.checkDuplicateId(5);
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
    test(
      "Should return DataConversionVALIURE if DataConversiont Exception",
      () async {
        when(mockPatientSearchDataSource.checkDuplicateId(any)).thenThrow(DataConversionException(message:DATACONVERSION_FAILURE_MESSAGE));
        final result = await repo.checkDuplicateId(5);
        expect(result, Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE)));
      },
    );
  });

  final PatientInfoEntity tPatientCreateEntry = tResponse[0];
  final PatientInfoModel tPatientCreateEntryModel = tPatientCreateEntry as PatientInfoModel;
  group("Create Patient", () {
    test(
      "Should call dataSource create Patient ",
      () async {
        when(mockPatientSearchDataSource.createPatient(any)).thenAnswer(
          (realInvocation) async => (tPatientCreateEntryModel),
        );
        await repo.createPatient(tPatientCreateEntry);
        verify(mockPatientSearchDataSource.createPatient(tPatientCreateEntryModel));
      },
    );
    test(
      "Should return true when success",
      () async {
        when(mockPatientSearchDataSource.createPatient(any)).thenAnswer(
          (realInvocation) async => (tPatientCreateEntryModel),
        );
        final result = await repo.createPatient(tPatientCreateEntry);
        expect(result, Right(tPatientCreateEntry));
      },
    );
    test(
      "Should return ServerFailure if server Exception",
      () async {
        when(mockPatientSearchDataSource.createPatient(any)).thenThrow(HttpInternalServerErrorException());
        final result = await repo.createPatient(tPatientCreateEntry);
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
    test(
      "Should return DataConversionVALIURE if DataConversiont Exception",
      () async {
        when(mockPatientSearchDataSource.createPatient(any)).thenThrow(DataConversionException(message:DATACONVERSION_FAILURE_MESSAGE));
        final result = await repo.createPatient(tPatientCreateEntry);
        expect(result, Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE)));
      },
    );
  });
  
  group("Testing CheckDuplicate Number", () {

    test("Should call dataSource checkDuplicate", () async{
      when(mockPatientSearchDataSource.checkDuplicateNumber(any)).thenAnswer((realInvocation)async => "");
      await repo.compareDuplicateNumber("12312");
      verify(mockPatientSearchDataSource.checkDuplicateNumber("12312"));
    });
    test("Should return string if success and duplicate", () async{
      when(mockPatientSearchDataSource.checkDuplicateNumber(any)).thenAnswer((realInvocation)async => "Omar");
      final result = await repo.compareDuplicateNumber("12312");
      expect(result, Right("Omar"));
      });
    test("Should return null if success and non duplicate", () async{
      when(mockPatientSearchDataSource.checkDuplicateNumber(any)).thenAnswer((realInvocation)async => null);
      final result = await repo.compareDuplicateNumber("12312");
      expect(result, Right(null));
      });
    test("Should return Left Server failure if exception", () async{
      when(mockPatientSearchDataSource.checkDuplicateNumber(any)).thenThrow(Exception());
      final result = await repo.compareDuplicateNumber("12312");
      expect(result, Left(UnknownFailure()));
      });
  });
}
