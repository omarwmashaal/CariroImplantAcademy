import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class ResolveComplainUseCase extends UseCases<NoParams, int> {
  ComplainsRepository complainsRepository;

  ResolveComplainUseCase(this.complainsRepository);

  @override
  Future<Either<Failure, NoParams>> call(int id) async {
    return complainsRepository.resolveComplain(id).then((value) => value.fold(
          (l) => Left(l..message = "Resolve Complain: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
