import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/data/datasources/dentalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/data/models/dentalHistoryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/repositories/dentalHistoryRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/datasources/medicalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/entities/hba1cEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/entities/medicalExaminationEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/repositories/medicalExaminationRepo.dart';
import 'package:dartz/dartz.dart';

class MedicalHistoryRepoImpl implements MedicalHistoryRepo{
  final MedicalHistoryDatasource medicalHistoryDataSource;
  MedicalHistoryRepoImpl({required this.medicalHistoryDataSource});



  @override
  Future<Either<Failure, MedicalExaminationEntity>> getMedicalExamination(int id) async{
    try{
      final result = await  medicalHistoryDataSource.getMedicalExamination(id);
      result.hbA1c = (result.hbA1c??[]) .map((e) => e as HbA1cEntity).toList();
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveMedicalExamination(MedicalExaminationEntity medicalExaminationEntity) async{
    try{
      final result = await  medicalHistoryDataSource.saveMedicalExamination(medicalExaminationEntity);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}