import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import 'listIncomeUseCase.dart';

class ListExpensesUseCase extends UseCases<List<CashFlowEntity>, ListCashFlowParams> {
  final CashFlowRepository cashFlowRepository;

  ListExpensesUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, List<CashFlowEntity>>> call(ListCashFlowParams params) async {
    return await cashFlowRepository
        .listExpenses(
          to: params.to == null ? null : DateFormat("yyyy-MM-dd").format(params.to!),
          from: params.from == null ? null : DateFormat("yyyy-MM-dd").format(params.from!),
          catId: params.catId,
          paymentMethodId: params.paymentMethodId,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "List Expenses: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

