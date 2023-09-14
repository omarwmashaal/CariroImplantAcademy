import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneCompanyEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/settingsDatasource.dart';

class SettingsRepoImpl implements SettingsRepository{
  final SettingsDatasource settingsDatasource;
  SettingsRepoImpl({required this.settingsDatasource});
  @override
  Future<Either<Failure, TreatmentPricesEntity>> getTreatmentPrices()  async {
    try {
      final result = await settingsDatasource.getTreatmentPrices();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getImplantCompanies()  async {
    try {
      final result = await settingsDatasource.getImplantCompanies();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getImplantLines(int id)  async {
    try {
      final result = await settingsDatasource.getImplantLines(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ImplantEntity>>> getImplants(int id)  async {
    try {
      final result = await settingsDatasource.getImplants(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<MembraneCompanyEntity>>> getMembraneCompanies()  async {
    try {
      final result = await settingsDatasource.getMembraneCompanies();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TacCompanyEntity>>> getTacs() async {
    try {
      final result = await settingsDatasource.getTacs();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getMembranes(int id) async {
    try {
      final result = await settingsDatasource.getMembranes(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}