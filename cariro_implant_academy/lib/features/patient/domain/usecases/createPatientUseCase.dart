import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/repositories/imagesRepo.dart';
import '../../../../core/domain/useCases/uploadImageUseCase.dart';
import '../repositories/patientInfoRepo.dart';

class CreatePatientUseCase extends UseCases<bool, PatientInfoEntity> {
  final PatientInfoRepo patientInfoRepo;
  final ImageRepo imageRepo;

  CreatePatientUseCase({required this.patientInfoRepo, required this.imageRepo});

  @override
  Future<Either<Failure, bool>> call(PatientInfoEntity params) async {
    if (params.id == null) return Left(InputValidationFailure(failureMessage: "Id can not be null"));
    final duplicateId = await patientInfoRepo.checkDuplicateId(params.id!);
    return duplicateId.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        if (r == true)
          return Left(InputValidationFailure(failureMessage: "Duplicate Id"));
        else {
          final createResult = await patientInfoRepo.createPatient(params);
          return createResult.fold(
            (l) => Left(l),
            (r) async {

                String imageErrorMessage = "";
                if (params.profileImage != null) {
                  final imageResponse =
                      await imageRepo.uploadImage(UploadImageParams(id: r.id!, type: EnumImageType.PatientProfile, data: params.profileImage!));
                  if (imageResponse.isLeft()) imageErrorMessage += "Failed to upload profile image";
                }
                if (params.idFrontImage != null) {
                  final imageResponse =
                      await imageRepo.uploadImage(UploadImageParams(id: r.id!, type: EnumImageType.IdFront, data: params.idFrontImage!));
                  if (imageResponse.isLeft()) imageErrorMessage += " Failed to upload Id Front image";
                }
                if (params.idBackImage != null) {
                  final imageResponse =
                      await imageRepo.uploadImage(UploadImageParams(id: r.id!, type: EnumImageType.IdBack, data: params.idBackImage!));
                  if (imageResponse.isLeft()) imageErrorMessage += " Failed to upload Id Back image";
                }
                if(imageErrorMessage!="") return Left(UploadImageFailure(failureMessage: imageErrorMessage));
                return Right(true);

               // return Left(DataVerificationFailure(message: "Failed to save correct data"));
            },
          );
        }
      },
    );
  }
}
