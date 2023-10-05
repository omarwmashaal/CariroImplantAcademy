import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneCompanyEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addImplantsUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/useCases/addMembranesUseCase.dart';
import '../datasources/settingsDatasource.dart';

class SettingsRepoImpl implements SettingsRepository {
  final SettingsDatasource settingsDatasource;

  SettingsRepoImpl({required this.settingsDatasource});

  @override
  Future<Either<Failure, TreatmentPricesEntity>> getTreatmentPrices() async {
    try {
      final result = await settingsDatasource.getTreatmentPrices();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getImplantCompanies() async {
    try {
      final result = await settingsDatasource.getImplantCompanies();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getImplantLines(int id) async {
    try {
      final result = await settingsDatasource.getImplantLines(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ImplantEntity>>> getImplants(int id) async {
    try {
      final result = await settingsDatasource.getImplants(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<MembraneCompanyEntity>>> getMembraneCompanies() async {
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

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getExpensesCategories() async {
    try {
      final result = await settingsDatasource.getExpensesCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getIncomeCategories() async {
    try {
      final result = await settingsDatasource.getIncomeCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getPaymentMethods() async {
    try {
      final result = await settingsDatasource.getPaymentMethods();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getMedicalExpensesCategories() async {
    try {
      final result = await settingsDatasource.getMedicalExpensesCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getNonMedicalNonStockExpensesCategories() async {
    try {
      final result = await settingsDatasource.getNonMedicalNonStockExpensesCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getNonMedicalStockCategories() async {
    try {
      final result = await settingsDatasource.getNonMedicalStockCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getSuppliers() async {
    try {
      final result = await settingsDatasource.getSuppliers();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addExpensesCategories(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addExpensesCategories(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addImplantCompanies(String name) async {
    try {
      final result = await settingsDatasource.addImplantCompanies(name);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addImplantLines(BasicNameIdObjectEntity value) async {
    try {
      final result = await settingsDatasource.addImplantLines(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addImplants(UpdateImplantsParams value) async {
    try {
      final result = await settingsDatasource.addImplants(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addIncomeCategories(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addIncomeCategories(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addMembraneCompanies(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addMembraneCompanies(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addMembranes(AddMembraneParams value) async {
    try {
      final result = await settingsDatasource.addMembranes(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addPaymentMethods(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addPaymentMethods(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addStockCategories(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addStockCategories(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addSuppliers(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addSuppliers(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addTacsCompanies(List<TacCompanyEntity> model) async {
    try {
      final result = await settingsDatasource.addTacsCompanies(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeImplantCompanyName(BasicNameIdObjectEntity value) async {
    try {
      final result = await settingsDatasource.changeImplantCompanyName(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeImplantLineName(BasicNameIdObjectEntity value) async {
    try {
      final result = await settingsDatasource.changeImplantLineName(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> editRooms(List<RoomEntity> model) async {
    try {
      final result = await settingsDatasource.editRooms(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> editTreatmentPrices(TreatmentPricesEntity prices) async {
    try {
      final result = await settingsDatasource.editTreatmentPrices(prices);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getStockCategories()async {
    try {
      final result = await settingsDatasource.getStockCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }


}
