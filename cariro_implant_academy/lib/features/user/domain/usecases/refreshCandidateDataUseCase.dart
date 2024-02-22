import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RefreshCandidatesDataUseCase extends UseCases<NoParams, int?> {
  final UsersRepository usersRepository;

  RefreshCandidatesDataUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, NoParams>> call(int? batchId) async {
    return await usersRepository.refreshCandidatesData(batchId).then((value) => value.fold(
          (l) => Left(l..message = "Refresh Candidates Data: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
