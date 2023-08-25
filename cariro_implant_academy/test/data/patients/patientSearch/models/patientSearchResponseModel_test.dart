import 'dart:convert';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/data/patients/models/patientSearchResponseModel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tResponseMarriedFemale = PatientInfoModel(
    name: "Maher Khattab",
    id: 1,
    gender: EnumGender.Female,
    phone: "01297587030",
    age: 25,
    maritalStatus: EnumMaritalStatus.Married,
    relative: "Omar",
    doctor: "doctor name",
    doctorId: 101,
    city: "city",
    address: "address",
    //idBackImageId: 1234,
    idFrontImageId: 897,
    nationalId: "568",
    phone2: "21214124214",
    profileImageId: 12412,
    registeredBy: "registeredBy",
    registrationDate: "2001-04-15",
    relativePatientId: 689,
    dateOfBirth: "1998-04-15",
  );

  final tResponseSingleMale = PatientInfoModel(
    name: "Omar clean 6",
    id: 54564,
    gender: EnumGender.Male,
    phone: "01297587030",
    age: 0,
    maritalStatus: EnumMaritalStatus.Single,
    relative: "Omar",
  //  doctor: "doctor name",
  //  doctorId: 101,
    city: "safsafsda",
    address: "sdfasfasdfsadf",
    idBackImageId: 1234,
    idFrontImageId: 897,
    nationalId: "568",
    phone2: "12412412",
    profileImageId: 12412,
    registeredBy: "registeredBy",
    registrationDate: "2001-04-15",
    relativePatientId: 689,
    dateOfBirth: "2023-07-01",
  );

  final tResponseNullDoctorAndDoctorIdAndRelative = PatientInfoModel(
    name: "Maher Khattab",
    id: 1,
    gender: EnumGender.Female,
    phone: "01297587030",
    age: 25,
    maritalStatus: EnumMaritalStatus.Married,
    dateOfBirth: "1998-04-15",
  );

  group("testing from json", () {
    test(
      "Should return correct patientSearchModel for married Female Response",
      () {
        final result = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchFemaleMarriedResponse.json")));
        expect(result, tResponseMarriedFemale);
      },
    );
    test(
      "Should return correct patientSearchModel for Single male Response",
      () {
        final result = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchMaleSingleResponse.json")));
        expect(result, tResponseSingleMale);
      },
    );
    test(
      "Should have no problem with nullable values",
      () {
        final result = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchNullResponse.json")));
        expect(result, tResponseNullDoctorAndDoctorIdAndRelative);
      },
    );
  });

  group( skip:true,"testing to json", () {

    test(
      "Should return correct Map for married Female Response",
      () {
        tResponseMarriedFemale.idBackImageId = null;
        final result = tResponseMarriedFemale.toMap();
        expect(result, json.decode(fixture("patients/patientSearch/patientSearchFemaleMarriedResponse.json")));
      },
    );
    test(
      "Should return correct Map for Single male Response",
      () {
        expect(tResponseSingleMale.toMap(), json.decode(fixture("patients/patientSearch/patientSearchMaleSingleResponse.json")));
      },
    );
    test(
      skip:true,
      "Should have no problem with nullable values",
      () {
        expect(tResponseNullDoctorAndDoctorIdAndRelative.toMap(), json.decode(fixture("patients/patientSearch/patientSearchNullResponse.json")));
      },
    );
  });
}
