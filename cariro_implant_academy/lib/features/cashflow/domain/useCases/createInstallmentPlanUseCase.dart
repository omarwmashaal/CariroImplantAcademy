import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentPlanEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';

import '../entities/cashFlowSummaryEntity.dart';

class CreateInstallmentPlanUseCase extends UseCases<InstallmentPlanEntity, CreateInstallmentPlanParams> {
  final CashFlowRepository cashFlowRepository;

  CreateInstallmentPlanUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, InstallmentPlanEntity>> call(CreateInstallmentPlanParams params) async {
    return await cashFlowRepository
        .createInstallmentPlan(
          params.id,
          params.total,
          params.startDate,
          params.numberOfPayments,
          params.interval,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Create Installment Plan: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class CreateInstallmentPlanParams {
  final int? id;
  final int total;
  final DateTime startDate;
  final int numberOfPayments;
  final EnumInstallmentInterval interval;

  CreateInstallmentPlanParams({
    this.id,
    required this.total,
    required this.startDate,
    required this.numberOfPayments,
    required this.interval,
  });
}
