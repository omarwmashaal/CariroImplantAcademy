import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums/enums.dart';

class SearchUsersByRoleUseCase extends UseCases<List<UserEntity>, SearchUsersByRoleParams> {
  final UsersRepository usersRepository;

  SearchUsersByRoleUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(SearchUsersByRoleParams params) async {
    return await usersRepository
        .searchUsersByRole(
          role: params.role,
          search: params.search,
          batch: params.batch,
        accessWebsites:params.accessWebsites,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Search Users: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class SearchUsersByRoleParams {
  final String role;
  final String? search;
  final int? batch;
  final Website? accessWebsites;

  SearchUsersByRoleParams({required this.role, this.search, this.batch,this.accessWebsites});
}
