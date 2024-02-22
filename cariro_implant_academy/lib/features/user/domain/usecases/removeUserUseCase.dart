import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveUserUseCase extends UseCases<NoParams, int> {
  final UsersRepository usersRepository;

  RemoveUserUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, NoParams>> call(int id) async {
    return await usersRepository.removeUser(id).then((value) => value.fold(
          (l) => Left(l..message = "Remove User: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
