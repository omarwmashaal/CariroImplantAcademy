import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/datasources/prostheticDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class ProstheticRepoImpl implements ProstheticRepository{
  final ProstheticDatasource prostheticDatasource;
  ProstheticRepoImpl({required this.prostheticDatasource});
  @override
  Future<Either<Failure, ProstheticTreatmentEntity>> getPatientProstheticTreatmentDiagnostic(int id) async{
    try{
      final result = await  prostheticDatasource.getPatientProstheticTreatmentDiagnostic(id);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProstheticTreatmentEntity>> getPatientProstheticTreatmentFinalProthesisFullArch(int id)  async{
    try{
      final result = await  prostheticDatasource.getPatientProstheticTreatmentFinalProthesisFullArch(id);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProstheticTreatmentEntity>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id) async{
    try{
      final result = await  prostheticDatasource.getPatientProstheticTreatmentFinalProthesisSingleBridge(id);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentDiagnostic(ProstheticTreatmentEntity data) async{
    try{
      final result = await  prostheticDatasource.updatePatientProstheticTreatmentDiagnostic(data);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisFullArch(ProstheticTreatmentEntity data) async{
    try{
      final result = await  prostheticDatasource.updatePatientProstheticTreatmentFinalProthesisFullArch(data);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updatePatientProstheticTreatmentFinalProthesisSingleBridge(ProstheticTreatmentEntity data) async{
    try{
      final result = await  prostheticDatasource.updatePatientProstheticTreatmentFinalProthesisSingleBridge(data);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}