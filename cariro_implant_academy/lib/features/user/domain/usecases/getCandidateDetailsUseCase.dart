

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/useCases/useCases.dart';
import '../entities/canidateDetailsEntity.dart';
import '../repositories/userRepository.dart';

class GetCandidateDetailsUseCase extends UseCases<List<CandidateDetailsEntity>, GetCandidateDetailsParams> {
  final UsersRepository usersRepository;

  GetCandidateDetailsUseCase({required this.usersRepository});

  @override
  Future<Either<Failure, List<CandidateDetailsEntity>>> call(GetCandidateDetailsParams params) async {
    return await usersRepository.getCandidateDetails(params.id,params.from,params.to).then((value) => value.fold(
          (l) => Left(l..message = "Get Candidate Details: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class GetCandidateDetailsParams{
  final DateTime? from;
  final DateTime? to;
  final int id;
  GetCandidateDetailsParams({required this.id, this.from, this.to});
}
