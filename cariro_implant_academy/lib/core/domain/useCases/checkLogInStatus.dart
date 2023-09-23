import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/authenticationUserEntity.dart';
import 'package:dartz/dartz.dart';

class CheckLoginStatusUseCase extends UseCases<AuthenticationUserEntity, NoParams> {
  CheckLoginStatusRepo repo;
  CheckLoginStatusUseCase(this.repo);
  @override
  Future<Either<Failure, AuthenticationUserEntity>> call(NoParams params) async{
   return await repo.checkLoginStatus();
  }
}
