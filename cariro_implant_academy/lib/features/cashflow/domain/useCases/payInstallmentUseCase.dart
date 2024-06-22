import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';

import '../entities/cashFlowSummaryEntity.dart';

class PayInstallmentUseCase extends UseCases<NoParams, PayInstallmentParams> {
  final CashFlowRepository cashFlowRepository;

  PayInstallmentUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, NoParams>> call(PayInstallmentParams params) async {
    return await cashFlowRepository
        .payInstallment(
          params.installmentPlanId,
          params.value,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Create Installment Plan: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class PayInstallmentParams {
  final int installmentPlanId;
  final int value;

  PayInstallmentParams({
    required this.installmentPlanId,
    required this.value,
  });
}
