import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/surgicalTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/surgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/surgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class SurgicalTreatmentRepoImpl implements SurgicalTreatmentRepo{
  final SurgicalTreatmentDatasource surgicalTreatmentDatasource;
  SurgicalTreatmentRepoImpl({required this.surgicalTreatmentDatasource});
  @override
  Future<Either<Failure, SurgicalTreatmentEntity>> getSurgicalTreatment(int id)async{
    try{
      final result = await  surgicalTreatmentDatasource.getSurgicalTreatment(id);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveSurgicalTreatment(int id, SurgicalTreatmentEntity data) async{
    try{
      final result = await  surgicalTreatmentDatasource.saveSurgicalTreatment(id,data);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}