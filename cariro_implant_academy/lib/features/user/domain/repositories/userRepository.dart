import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../Models/CandidateDetails.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/error/failure.dart';
import '../../../patient/domain/entities/advancedTreatmentSearchEntity.dart';
import '../../../patient/domain/entities/visitEntity.dart';
import '../entities/canidateDetailsEntity.dart';

abstract class UsersRepository {
  Future<Either<Failure, UserEntity>> getUserData({required int id});

  Future<Either<Failure, List<UserEntity>>> searchUsersByRole({required String role, String? search, int? batch,Website? accessWebsites});
  Future<Either<Failure, List<UserEntity>>> searchUsersByWorkPlace( String? search, EnumLabRequestSources source);

  Future<Either<Failure, NoParams>> updateUserInfo(int id, UserEntity userData);
  Future<Either<Failure, NoParams>> changeRole(int id, String role);
  Future<Either<Failure, List<CandidateDetailsEntity>>> getCandidateDetails(int id, DateTime? from, DateTime? to);

  Future<Either<Failure, NoParams>> resetPassword({required String newPassword1, required String newPassword2, required String oldPassword});

  Future<Either<Failure, List<VisitEntity>>> getSessionsDurations(DateTime? from, DateTime? to, int id);
}
