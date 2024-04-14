import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientInfoModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/createPatientUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import 'createPatientUseCase_test.mocks.dart';
import 'patientSearchByNameUseCase_test.mocks.dart';

@GenerateMocks([ImageRepo])
void main() {
  late CreatePatientUseCase useCase;
  late MockPatientInfoRepo repo;
  late MockImageRepo mockImageRepo;

  setUp(() {
    repo = MockPatientInfoRepo();
    mockImageRepo = MockImageRepo();
    useCase = CreatePatientUseCase(patientInfoRepo: repo, imageRepo: mockImageRepo);
  });
  final tPatient = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientSearchFemaleMarriedResponse.json")));
  final PatientInfoEntity tPatientEntry = tPatient;
  final tPatientWithPhoto = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientWithPhotos.json")));

  test(
    "Should call check id first thing",
    () async {
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(true));
      await useCase(tPatientEntry);
      verify(repo.checkDuplicateId(tPatientEntry.id));
    },
  );
  test(
    "Should return InputValidation when id null",
    () async {
      tPatientEntry.id = null;
      //when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(true));
      verifyZeroInteractions(repo);
      final result = await useCase(tPatientEntry);
      expect(result, Left(InputValidationFailure(failureMessage: "Id can not be null")));
    },
  );
  test(
    "Should return InputValidation when duplicate id",
    () async {
      tPatientEntry.id = 5;
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(true));
      final result = await useCase(tPatientEntry);
      expect(result, Left(InputValidationFailure(failureMessage: "Duplicate Id")));
    },
  );
  test(
    "Should  call create when not duplicate",
    () async {
      tPatientEntry.id = 5;
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Right(tPatientEntry));
      final result = await useCase(tPatientEntry);
      verify(repo.createPatient(tPatientEntry));
      //expect(result, Left(InputValidationFailure(message: "Duplicate Id")));
    },
  );

  test(
    skip:true,
    "Should verify data and return failed if different data",
    () async {
      tPatientEntry.id = 5;
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Right(PatientInfoModel.fromEntity(tPatientEntry)..id = 6));
      final result = await useCase(tPatientEntry);
      expect(result, Left(DataVerificationFailure(failureMessage: "Failed to save correct data")));
    },
  );
  test(
    "Should verify data and return true if same data",
    () async {
      tPatientEntry.id = 5;
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Right(tPatientEntry));
      final result = await useCase(tPatientEntry);
      expect(result, Right(true));
    },
  );

  test(
    "Should call imageRepo Upload  pics if  pics are not null && create is success",
    () async {
      final tPatientWithPhotos = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientWithPhotos.json")));
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Right(tPatientWithPhotos));
      when(mockImageRepo.uploadImage(any)).thenAnswer((realInvocation) async => Right(true));
      final result = await useCase(tPatientWithPhoto);
      verifyInOrder([
        (mockImageRepo.uploadImage(
            UploadImageParams(id: tPatientWithPhotos.id!, type: EnumImageType.PatientProfile, data: Uint8List.fromList(tPatientWithPhotos.profileImage!)))),
        (mockImageRepo
            .uploadImage(UploadImageParams(id: tPatientWithPhotos.id!, type: EnumImageType.IdBack, data: Uint8List.fromList(tPatientWithPhotos.idBackImage!)))),
        (mockImageRepo.uploadImage(
            UploadImageParams(id: tPatientWithPhotos.id!, type: EnumImageType.IdFront, data: Uint8List.fromList(tPatientWithPhotos.idFrontImage!)))),
      ]);
      expect(result, Right(true));
    },
  );
  test(
    "Should call return imageupload failure if failed image",
    () async {
      final tPatientWithPhotos = PatientInfoModel.fromMap(json.decode(fixture("patients/patientSearch/patientWithPhotos.json")));
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Right(tPatientWithPhotos));
      when(mockImageRepo.uploadImage(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
      final result = await useCase(tPatientWithPhoto);
      expect(result, Left(UploadImageFailure(failureMessage:"Failed to upload profile image Failed to upload Id Front image Failed to upload Id Back image" )));
    },
  );
  test(
    "Should return return right true if true",
    () async {
      tPatientEntry.id = 5;
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Right(tPatientEntry));
      final result = await useCase(tPatientEntry);
      expect(result, Right(true));
    },
  );
  test(
    "Should return Left failure if failed",
    () async {
      tPatientEntry.id = 5;
      when(repo.checkDuplicateId(any)).thenAnswer((realInvocation) async => Right(false));
      when(repo.createPatient(any)).thenAnswer((realInvocation) async => Left(HttpInternalServerErrorFailure()));
      final result = await useCase(tPatientEntry);
      expect(result, Left(HttpInternalServerErrorFailure()));
    },
  );
}
