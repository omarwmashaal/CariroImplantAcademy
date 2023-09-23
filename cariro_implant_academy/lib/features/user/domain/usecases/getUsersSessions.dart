import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUsersSessionsUseCase extends UseCases<List<VisitEntity>, GetSessionsDurationParams> {
  final UsersRepository usersRepository;

  GetUsersSessionsUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, List<VisitEntity>>> call(GetSessionsDurationParams params) async {
    return await usersRepository
        .getSessionsDurations(
          params.from,
          params.to,
          params.id,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Sessions Duration: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class GetSessionsDurationParams {
  final int id;
  final DateTime? from;
  final DateTime? to;

  GetSessionsDurationParams({
    required this.id,
     this.from,
     this.to,
  });
}
