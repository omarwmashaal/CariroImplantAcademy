import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveNonSurgicalTreatmentUseCase extends UseCases<NoParams, SaveNonSurgicalTreatmentParams> {
  final NonSurgicalTreatmentRepo nonSurgicalTreatmentRepo;

  SaveNonSurgicalTreatmentUseCase({required this.nonSurgicalTreatmentRepo});

  @override
  Future<Either<Failure, NoParams>> call(SaveNonSurgicalTreatmentParams params) async {
    final result = await nonSurgicalTreatmentRepo.saveNonSurgicalTreatment(params);
    return result.fold(
          (l) => Left(l..message = "Save nonsurgical treatments: ${l.message}"),
          (r) => Right(r),
    );
  }
}

class SaveNonSurgicalTreatmentParams extends Equatable {
  final int patientId;
  final NonSurgicalTreatmentEntity nonSurgicalTreatmentEntity;
  final bool delete;

  SaveNonSurgicalTreatmentParams({required this.patientId, required this.nonSurgicalTreatmentEntity,this.delete = false});

  @override
  // TODO: implement props
  List<Object?> get props => [
        patientId,
        nonSurgicalTreatmentEntity,
      ];
}
