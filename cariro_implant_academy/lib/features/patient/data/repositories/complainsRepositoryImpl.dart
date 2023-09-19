import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/complainsDatasource.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/useCases/useCases.dart';

class ComplainsRepositoryImpl implements ComplainsRepository {
  final ComplainsDatasource complainsDatasource;

  ComplainsRepositoryImpl({required this.complainsDatasource});

  @override
  Future<Either<Failure, NoParams>> addComplain(ComplainsEntity complain) async {
    try {
      final result = await complainsDatasource.addComplain(complain);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ComplainsEntity>>> getComplains({int? id, String? search, EnumComplainStatus? status}) async {
    try {
      final result = await complainsDatasource.getComplains(
        id: id,
        search: search,
        status: status,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> inqueueComplain(int complainId, String? notes) async {
    try {
      final result = await complainsDatasource.inqueueComplain(complainId,notes);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> resolveComplain(int complainId) async {
    try {
      final result = await complainsDatasource.resolveComplain(complainId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateComplainNotes(int complainId, String? notes)  async {
    try {
      final result = await complainsDatasource.updateComplainNotes(complainId,notes);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
