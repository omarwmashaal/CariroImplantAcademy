import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/loadingRepo.dart';

class LoadWorkPlacesCase extends LoadingUseCases {
  final LoadingRepo loadingRepo;
  LoadWorkPlacesCase({required this.loadingRepo});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(params) async{
    return await loadingRepo.loadWorkPlaces();

  }
}


