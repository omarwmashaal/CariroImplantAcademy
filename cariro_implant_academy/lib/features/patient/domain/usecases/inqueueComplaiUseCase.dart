import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class InqueueComplainUseCase extends UseCases<NoParams, InqueueComplainParams> {
  ComplainsRepository complainsRepository;

  InqueueComplainUseCase(this.complainsRepository);

  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return complainsRepository.inqueueComplain(params.complainId,params.notes).then((value) => value.fold(
          (l) => Left(l..message = "Inqueue Complain: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
class InqueueComplainParams{
  final int complainId;
  final String? notes;
  InqueueComplainParams({required this.complainId,this.notes});
}
