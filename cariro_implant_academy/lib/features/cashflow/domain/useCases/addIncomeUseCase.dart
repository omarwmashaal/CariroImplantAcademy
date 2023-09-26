import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../entities/cashFlowSummaryEntity.dart';

class AddIncomeUseCase extends UseCases<NoParams, CashFlowEntity> {
  final CashFlowRepository cashFlowRepository;

  AddIncomeUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, NoParams>> call(CashFlowEntity params) async {
    return await cashFlowRepository
        .addIncome(
         params
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Add Income: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}


