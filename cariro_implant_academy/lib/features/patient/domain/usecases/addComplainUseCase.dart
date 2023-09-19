import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class AddComplainUseCase extends UseCases<NoParams, ComplainsEntity> {
  ComplainsRepository complainsRepository;

  AddComplainUseCase(this.complainsRepository);

  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return complainsRepository.addComplain(params).then((value) => value.fold(
          (l) => Left(l..message = "Add Complain: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
