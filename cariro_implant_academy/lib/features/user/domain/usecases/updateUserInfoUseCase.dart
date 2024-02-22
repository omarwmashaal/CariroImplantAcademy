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

    if(params.userData.roles!.contains("candidate"))
    {
      if((params.userData.facebookLink?.isNotEmpty??false) && ( !Uri.parse(params.userData.facebookLink!).isAbsolute ||!(params.userData.facebookLink!.toLowerCase().contains("fb.com/") ||params.userData.facebookLink!.toLowerCase().contains("facebook.com/") )))
      {
        return Left(BadRequestFailure(failureMessage: "Please write correct Facebook Link, the link must start with \"http://\" or \"https://\" and contains \"facebook.com\" or \"fb.com\"!"));
      }
      else if((params.userData.instagramLink?.isNotEmpty??false) && ( !Uri.parse(params.userData.instagramLink!).isAbsolute ||!(params.userData.instagramLink!.toLowerCase().contains("instagram.com/") )))
      {
        return Left(BadRequestFailure(failureMessage: "Please write correct Instagram Link, the link must start with \"http://\" or \"https://\" and contains \"instagram.com\"!"));
      }
    }
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
