import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/loadingRepo.dart';

class LoadCandidatesByBatchId extends LoadingUseCases<int> {
  final LoadingRepo loadingRepo;
  LoadCandidatesByBatchId({required this.loadingRepo});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(int id) async{
    return await loadingRepo.loadCandidatesByBatchId(id:id);

  }
}



