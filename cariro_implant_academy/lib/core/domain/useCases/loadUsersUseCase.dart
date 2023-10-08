import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/loadingRepo.dart';

class LoadUsersUseCase extends LoadingUseCases<LoadUsersEnum> {
  final LoadingRepo loadingRepo;
  LoadUsersUseCase({required this.loadingRepo});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(LoadUsersEnum params) async{
    return await loadingRepo.loadUsers(userType: params);

  }
}

enum LoadUsersEnum {
  assistants,
  instructors,
  admins,
  supervisors,
  instructorsAndAssistants,
  candidates,
  technicians,
}


