import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUserDataUseCase extends UseCases<UserEntity, int> {
  final UsersRepository usersRepository;

  GetUserDataUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, UserEntity>> call(int id) async {
    return await usersRepository.getUserData(id: id).then((value) => value.fold(
          (l) => Left(l..message = "Get User Data: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
