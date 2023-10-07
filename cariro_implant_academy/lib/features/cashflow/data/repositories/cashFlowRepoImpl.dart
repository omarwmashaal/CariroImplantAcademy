import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/data/datasources/cashFlowDatasources.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowSummaryEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/enums.dart';

class CashFlowRepoImpl implements CashFlowRepository {
  final CashFlowDatasource cashFlowDatasource;

  CashFlowRepoImpl({required this.cashFlowDatasource});

  @override
  Future<Either<Failure, NoParams>> addExpense(List<CashFlowEntity> models, bool isStockItem, EnumExpenseseCategoriesType type) async {
    try {
      final result = await cashFlowDatasource.addExpense(models, isStockItem, type);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addIncome(CashFlowEntity model) async {
    try {
      final result = await cashFlowDatasource.addIncome(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addSettlement(String filter, int value) async {
    try {
      final result = await cashFlowDatasource.addSettlement(filter, value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, BasicNameIdObjectEntity>> getExpenesesCategoryByName(String name) async {
    try {
      final result = await cashFlowDatasource.getExpenesesCategoryByName(name);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> getExpensesByCategory(int categoryID, String filter) async {
    try {
      final result = await cashFlowDatasource.getExpensesByCategory(categoryID, filter);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> getIncomeByCategory(int categoryID, String filter) async {
    try {
      final result = await cashFlowDatasource.getExpensesByCategory(categoryID, filter);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> getSummary(EnumSummaryFilter filter) async {
    try {
      final result = await cashFlowDatasource.getSummary(filter);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<CashFlowEntity>>> listExpenses({String? from, String? to, int? catId, int? paymentMethodId}) async {
    try {
      final result = await cashFlowDatasource.listExpenses(
        from: from,
        to: to,
        paymentMethodId: paymentMethodId,
        catId: catId,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<CashFlowEntity>>> listIncome({String? from, String? to, int? catId, int? paymentMethodId}) async {
    try {
      final result = await cashFlowDatasource.listIncome(
        from: from,
        to: to,
        paymentMethodId: paymentMethodId,
        catId: catId,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
