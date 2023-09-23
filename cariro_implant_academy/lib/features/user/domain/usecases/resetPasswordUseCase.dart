import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ResetPasswordUseCase extends UseCases<NoParams, ResetPasswordParams> {
  final UsersRepository usersRepository;

  ResetPasswordUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, NoParams>> call(ResetPasswordParams params) async {
    if (params.newPassword2 != params.newPassword1)
      return Left(BadRequestFailure(failureMessage: "Passwords don't match"));
    return await usersRepository
        .resetPassword(
          newPassword1: params.newPassword1,
          newPassword2: params.newPassword2,
          oldPassword: params.oldPassword,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Reset Password: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class ResetPasswordParams {
  final String newPassword1;
  final String newPassword2;
  final String oldPassword;

  ResetPasswordParams({
    required this.newPassword1,
    required this.newPassword2,
    required this.oldPassword,
  });
}
