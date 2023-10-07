import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../patient/domain/entities/patientInfoEntity.dart';
import '../usecases/searchLabPatientsByTypeUseCase.dart';

abstract class LabCustomersRepository{
  Future<Either<Failure,UserEntity>>createNewCustomer(UserEntity customer);
  Future<Either<Failure,List<PatientInfoEntity>>>searchLabPatientsByType(String? search,EnumLabRequestSources type);
}