import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/data/datasource/labCustomerDatasource.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labCustomersRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/searchLabPatientsByTypeUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';

class LabCustomerRepoImpl implements LabCustomersRepository {
  final LabCustomerDatasource labCustomerDatasource;

  LabCustomerRepoImpl({required this.labCustomerDatasource});

  @override
  Future<Either<Failure, UserEntity>> createNewCustomer(UserEntity customer) async {
    try {
      final result = await labCustomerDatasource.createNewCustomer(customer);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<PatientInfoEntity>>> searchLabPatientsByType(String? search, Website type) async {
    try {
      final result = await labCustomerDatasource.searchLabPatientsByType(search, type);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
