import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/loadingRepo.dart';

class LoadCandidateBatchesUseCase extends LoadingUseCases {
  final LoadingRepo loadingRepo;

  LoadCandidateBatchesUseCase({required this.loadingRepo});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(NoParams) async {
    return await loadingRepo.loadCandidateBatches().then((value) => value.fold(
          (l) => Left(l..message = "Candidate batches: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
