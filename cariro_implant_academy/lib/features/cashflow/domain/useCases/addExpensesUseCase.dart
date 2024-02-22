import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../entities/cashFlowSummaryEntity.dart';

class AddExpensesUseCase extends UseCases<NoParams, AddExpensesParams> {
  final CashFlowRepository cashFlowRepository;

  AddExpensesUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddExpensesParams params) async {
    return await cashFlowRepository
        .addExpense(
          params.models,
          params.isStockItem,
          params.type,
      params.inventory,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Add Expenses: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class AddExpensesParams {
  final List<CashFlowEntity> models;
  final bool isStockItem;
  final EnumExpenseseCategoriesType type;
  final Website inventory;
  final bool isLab;

  AddExpensesParams({
    required this.models,
    required this.type,
    required this.isStockItem,
     required this.inventory,
    this.isLab = false,
  });
}
