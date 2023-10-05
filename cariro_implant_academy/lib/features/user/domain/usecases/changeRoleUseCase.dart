import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangeRoleUseCase extends UseCases<NoParams, ChangeRoleParams> {
  final UsersRepository usersRepository;

  ChangeRoleUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, NoParams>> call(ChangeRoleParams params) async {
    return await usersRepository.changeRole(params.id, params.role).then((value) => value.fold(
          (l) => Left(l..message = "Changing Role:${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class ChangeRoleParams {
  final int id;
  final String role;

  ChangeRoleParams({
    required this.role,
    required this.id,
  });
}
