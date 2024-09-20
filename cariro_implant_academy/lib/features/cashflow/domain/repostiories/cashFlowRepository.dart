import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowSummaryEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentPlanEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/error/failure.dart';

abstract class CashFlowRepository {
  Future<Either<Failure, List<CashFlowEntity>>> listIncome({String? from, String? to, int? catId, int? paymentMethodId});

  Future<Either<Failure, List<CashFlowEntity>>> listExpenses({String? from, String? to, int? catId, int? paymentMethodId});

  Future<Either<Failure, CashFlowSummaryEntity>> getSummary(DateTime from, DateTime to);

  Future<Either<Failure, CashFlowSummaryEntity>> getIncomeByCategory(int categoryID, String filter);

  Future<Either<Failure, CashFlowSummaryEntity>> getExpensesByCategory(int categoryID, String filter);

  Future<Either<Failure, NoParams>> addIncome(CashFlowEntity model);

  Future<Either<Failure, NoParams>> addExpense(
      List<CashFlowEntity> models, bool isStockItem, EnumExpenseseCategoriesType type, Website inventoryWebsite);

  Future<Either<Failure, NoParams>> addSettlement(String filter, int value);

  Future<Either<Failure, BasicNameIdObjectEntity>> getExpenesesCategoryByName(String name);
  Future<Either<Failure, InstallmentPlanEntity?>> getInstallmentsOfUser(int id);
  Future<Either<Failure, NoParams>> payInstallment(int installmentPlanId, int value);
  Future<Either<Failure, InstallmentPlanEntity>> createInstallmentPlan(
      int? id, int total, DateTime startDate, int numberOfPayments, EnumInstallmentInterval interval);
}
