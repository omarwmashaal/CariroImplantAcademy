import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientInfoModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/patientSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSeachBlocEvents.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSeachBlocStates.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSearchBloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'patientSearchBloc_test.mocks.dart';

@GenerateMocks([PatientSearchUseCase])
void main() {
  late MockPatientSearchUseCase mockPatientSearchUseCase;
  late PatientSearchBloc bloc;
  setUp(
    () {
      mockPatientSearchUseCase = MockPatientSearchUseCase();
      bloc = PatientSearchBloc(searchUseCase: mockPatientSearchUseCase);
    },
  );

  final tQuery = PatientSearchParams(myPatients: false, query: "Om", filter: "Name");
  final tResponse = <PatientInfoEntity>[
    PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchFemaleMarriedResponse.json"))),
    PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchMaleSingleResponse.json"))),
    PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchNullResponse.json"))),
  ];
  test(
    "Should Initial State Loading",
    () {
      expect(bloc.state, LoadingPatientSearchState());
    },
  );

  test(
    "Should Initial State Loading",
    () {
      expect(bloc.state, LoadingPatientSearchState());
    },
  );
  blocTest(
    "Should emit Loading loaded when success with proper output",
    build: () => bloc,
    setUp: () => when(mockPatientSearchUseCase(any)).thenAnswer((realInvocation) async => Right(tResponse)),
    verify: (bloc) => verify(mockPatientSearchUseCase(tQuery)),
    act: (_bloc) => bloc.add(PatientSearchEvent(query: "Om")),
    expect: () => [LoadingPatientSearchState(), LoadedPatientSearchState(tResponse)],
  );
  blocTest(
    "Should emit proper error message",
    build: () => bloc,
    setUp: () => when(mockPatientSearchUseCase(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure())),
    verify: (bloc) => verify(mockPatientSearchUseCase(tQuery)),
    act: (_bloc) => bloc.add(PatientSearchEvent(query: "Om")),
    expect: () => [LoadingPatientSearchState(), LoadingError(message: SERVER_EXCEPTION_MESSAGE)],
  );
  blocTest(
    "Should emit proper error message",
    build: () => bloc,
    setUp: () => when(mockPatientSearchUseCase(any)).thenAnswer((realInvocation) async => Left(DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE))),
    verify: (bloc) => verify(mockPatientSearchUseCase(tQuery)),
    act: (_bloc) => bloc.add(PatientSearchEvent(query: "Om")),
    expect: () => [LoadingPatientSearchState(), LoadingError(message: DATA_CONVERSION_EXCEPTION_MESSAGE)],
  );
}
