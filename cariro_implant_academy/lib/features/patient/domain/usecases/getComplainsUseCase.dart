import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';
import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class GetComplainsUseCase extends UseCases<List<ComplainsEntity>, GetcomplainsParams> {
  ComplainsRepository complainsRepository;

  GetComplainsUseCase(this.complainsRepository);

  @override
  Future<Either<Failure, List<ComplainsEntity>>> call(params) async {
    return complainsRepository
        .getComplains(
          id: params.patientId,
          search: params.search,
          status: params.status,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Complains: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class GetcomplainsParams {
  final int? patientId;
  final String? search;
  final EnumComplainStatus? status;

  GetcomplainsParams({this.patientId, this.search, this.status});
}
