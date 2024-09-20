import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';
import '../entities/cashFlowSummaryEntity.dart';

class GetSummaryUseCase extends UseCases<CashFlowSummaryEntity, GetCashFlowSummaryParams> {
  final CashFlowRepository cashFlowRepository;

  GetSummaryUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> call(GetCashFlowSummaryParams params) async {
    return await cashFlowRepository.getSummary(params.from, params.to).then((value) => value.fold(
          (l) => Left(l..message = "Get Summary: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class GetCashFlowSummaryParams {
  final DateTime from;
  final DateTime to;

  GetCashFlowSummaryParams({required this.from, required this.to});
}
