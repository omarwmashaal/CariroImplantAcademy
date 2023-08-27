import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/visitEntity.dart';

abstract class VisitsRepo{
  Future<Either<Failure,List<VisitEntity>>> getPatientVisits(int patientId);
  Future<Either<Failure,List<VisitEntity>>> getAllVisits();
  Future<Either<Failure,List<VisitEntity>>> getAllSchedules(int month);
  Future<Either<Failure,List<VisitEntity>>> getMySchedules(int month);
  Future<Either<Failure,NoParams>> scheduleNewVisit(VisitEntity newVisit);
}