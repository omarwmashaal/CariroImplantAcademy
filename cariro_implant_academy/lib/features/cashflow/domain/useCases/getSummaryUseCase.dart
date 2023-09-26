import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';
import '../entities/cashFlowSummaryEntity.dart';

class GetSummaryUseCase extends UseCases<CashFlowSummaryEntity, EnumSummaryFilter> {
  final CashFlowRepository cashFlowRepository;

  GetSummaryUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, CashFlowSummaryEntity>> call(EnumSummaryFilter params) async {
    return await cashFlowRepository
        .getSummary(
         params
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Summary: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}


