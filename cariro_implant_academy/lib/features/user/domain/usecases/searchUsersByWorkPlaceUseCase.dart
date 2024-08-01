import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchUsersByWorkPlaceUseCase extends UseCases<List<UserEntity>, SearchUsersByWorkPlaceParams> {
  final UsersRepository usersRepository;

  SearchUsersByWorkPlaceUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(SearchUsersByWorkPlaceParams params) async {
    return await usersRepository
        .searchUsersByWorkPlace(
          params.search,
          params.source,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Search Users: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class SearchUsersByWorkPlaceParams {
  final Website source;
  final String? search;

  SearchUsersByWorkPlaceParams({
    required this.source,
    this.search,
  });
}
