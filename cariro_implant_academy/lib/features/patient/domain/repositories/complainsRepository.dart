import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/useCases/useCases.dart';

abstract class ComplainsRepository{
  Future<Either<Failure,NoParams>> resolveComplain(int complainId);
  Future<Either<Failure,NoParams>> inqueueComplain(int complainId,String? notes);
  Future<Either<Failure,NoParams>> updateComplainNotes(int complainId,String? notes);
  Future<Either<Failure,NoParams>> addComplain(ComplainsEntity complain);
  Future<Either<Failure,List<ComplainsEntity>>> getComplains({int? id, String? search, EnumComplainStatus? status});

}