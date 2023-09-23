import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateUserInfoUseCase extends UseCases<NoParams, UpdateUserInfoParams> {
  final UsersRepository usersRepository;

  UpdateUserInfoUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateUserInfoParams params) async {
    return await usersRepository
        .updateUserInfo(
          params.id,
          params.userData,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Update User Data: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class UpdateUserInfoParams {
  final int id;
  final UserEntity userData;

  UpdateUserInfoParams({required this.id, required this.userData});
}
