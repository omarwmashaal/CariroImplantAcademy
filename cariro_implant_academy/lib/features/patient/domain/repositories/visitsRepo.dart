import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/visitEntity.dart';

abstract class VisitsRepo{
  Future<Either<Failure,List<VisitEntity>>> getPatientVisits(int patientId);
  Future<Either<Failure,NoParams>> updateVisit(VisitEntity data, bool delete);
  Future<Either<Failure,NoParams>> patientVisits(int patientId);
  Future<Either<Failure,NoParams>> patientEntersClinic(int patientId,int doctorId,int? roomId);
  Future<Either<Failure,NoParams>> patientLeavesClinic(int patientId);
  Future<Either<Failure,List<VisitEntity>>> getAllVisits(String? search);
  Future<Either<Failure,List<VisitEntity>>> getAllSchedules(int month);
  Future<Either<Failure,List<VisitEntity>>> getMySchedules(int month);
  Future<Either<Failure,NoParams>> scheduleNewVisit(VisitEntity newVisit);
}