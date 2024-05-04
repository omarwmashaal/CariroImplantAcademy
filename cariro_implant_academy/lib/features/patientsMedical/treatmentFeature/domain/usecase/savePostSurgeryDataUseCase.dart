import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/postSurgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/postSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class SavePostSurgeryDataUseCase extends UseCases<NoParams, PostSurgicalTreatmentEntity> {
  final PostSurgicalTreatmentRepo postSurgeryRepo;

  SavePostSurgeryDataUseCase({required this.postSurgeryRepo});

  @override
  Future<Either<Failure, NoParams>> call(PostSurgicalTreatmentEntity data) async {
    //data.data.removeWhere((element) => element.isNull());
    return await postSurgeryRepo.savePostSurgicalTreatment(data).then(
          (value) => value.fold(
            (l) => Left(l..message = "Save Post Surgery Data: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}
