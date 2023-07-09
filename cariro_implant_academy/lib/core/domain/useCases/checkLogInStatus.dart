import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:dartz/dartz.dart';

class CheckLoginStatusUseCase extends UseCases<UserEntity, NoParams> {
  CheckLoginStatusRepo repo;
  CheckLoginStatusUseCase(this.repo);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async{
   return await repo.checkLoginStatus();
  }
}
