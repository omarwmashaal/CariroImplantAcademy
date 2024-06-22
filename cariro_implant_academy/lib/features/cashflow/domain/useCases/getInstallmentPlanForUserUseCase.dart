import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentPlanEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';

import '../entities/cashFlowSummaryEntity.dart';

class GetInstallmentPlanForUserUseCase extends UseCases<InstallmentPlanEntity?, int> {
  final CashFlowRepository cashFlowRepository;

  GetInstallmentPlanForUserUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, InstallmentPlanEntity?>> call(int id) async {
    return await cashFlowRepository.getInstallmentsOfUser(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Installment Plan: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
