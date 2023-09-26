import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../entities/cashFlowSummaryEntity.dart';

class AddSettlementUseCase extends UseCases<NoParams, AddSettlementParams> {
  final CashFlowRepository cashFlowRepository;

  AddSettlementUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddSettlementParams params) async {
    return await cashFlowRepository
        .addSettlement(
          params.filter,
          params.value,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Add Settlement: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class AddSettlementParams {
  final String filter;
  final int value;

  AddSettlementParams({
    required this.value,
    required this.filter,
  });
}
