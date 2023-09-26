import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../entities/cashFlowSummaryEntity.dart';

class GetIncomeByCategoryUseCase extends UseCases<CashFlowSummaryEntity, GetCashFlowByCategoryParams> {
  final CashFlowRepository cashFlowRepository;

  GetIncomeByCategoryUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> call(GetCashFlowByCategoryParams params) async {
    return await cashFlowRepository
        .getIncomeByCategory(
          params.categoryId,
          params.filter,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Income By Category: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class GetCashFlowByCategoryParams {
  final int categoryId;
  final String filter;

  GetCashFlowByCategoryParams({
    required this.categoryId,
    required this.filter,
  });
}
