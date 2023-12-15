import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateNonSurgicalTreatmentNotesUseCase extends UseCases<NoParams, UpdateNonSurgicalTreatmentNotesParams> {
  final NonSurgicalTreatmentRepo nonSurgicalTreatmentRepo;

  UpdateNonSurgicalTreatmentNotesUseCase({required this.nonSurgicalTreatmentRepo});

  @override
  Future<Either<Failure, NoParams>> call(UpdateNonSurgicalTreatmentNotesParams params) async {
    final result = await nonSurgicalTreatmentRepo.updateNonSurgicalTreatmentNotes(params.nonSurgicalTreatmentId,params.notes);
    return result.fold(
      (l) => Left(l..message = "Save nonsurgical treatments: ${l.message}"),
      (r) => Right(r),
    );
  }
}

class UpdateNonSurgicalTreatmentNotesParams extends Equatable {
  final int nonSurgicalTreatmentId;
  final String notes;

  UpdateNonSurgicalTreatmentNotesParams({required this.nonSurgicalTreatmentId, required this.notes});

  @override
  // TODO: implement props
  List<Object?> get props => [
        notes,
        nonSurgicalTreatmentId,
      ];
}
