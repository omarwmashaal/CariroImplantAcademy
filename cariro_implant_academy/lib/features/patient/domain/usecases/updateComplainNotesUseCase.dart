import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class UpdateComplainNotesUseCase extends UseCases<NoParams, UpdateComplainParams> {
  ComplainsRepository complainsRepository;

  UpdateComplainNotesUseCase(this.complainsRepository);

  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return complainsRepository.updateComplainNotes(params.complainId,params.notes).then((value) => value.fold(
          (l) => Left(l..message = "Update Complain Notes: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
class UpdateComplainParams{
  final int complainId;
  final String? notes;
  UpdateComplainParams({required this.complainId,this.notes});
}
