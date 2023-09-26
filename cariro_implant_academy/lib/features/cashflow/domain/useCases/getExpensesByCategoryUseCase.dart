import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../entities/cashFlowSummaryEntity.dart';
import 'getIncomeByCategoryUseCase.dart';

class GetExpensesByCategoryUseCase extends UseCases<CashFlowSummaryEntity, GetCashFlowByCategoryParams> {
  final CashFlowRepository cashFlowRepository;

  GetExpensesByCategoryUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> call(GetCashFlowByCategoryParams params) async {
    return await cashFlowRepository
        .getExpensesByCategory(
          params.categoryId,
          params.filter,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Expenses By Category: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

