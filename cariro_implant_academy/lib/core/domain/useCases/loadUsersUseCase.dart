import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/loadingRepo.dart';

class LoadUsersUseCase extends UseCases<List<BasicNameIdObjectEntity>, LoadParams<LoadUsersEnum>> {
  final LoadingRepo loadingRepo;
  LoadUsersUseCase({required this.loadingRepo});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(LoadParams<LoadUsersEnum> params) async{
    return await loadingRepo.loadUsers(userType: params.type, query: params.query);

  }
}

enum LoadUsersEnum {
  assistants,
  instructors,
  admins,
  supervisors,
  instructorsAndAssistants,
}

class LoadParams<T extends Enum> {
  final T type;
  final String query;

  LoadParams({required this.type, required this.query});
}
