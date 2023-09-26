import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/repostiories/cashFlowRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../entities/cashFlowSummaryEntity.dart';

class GetExpensesCategoryByNameUseCase extends UseCases<BasicNameIdObjectEntity, String> {
  final CashFlowRepository cashFlowRepository;

  GetExpensesCategoryByNameUseCase({required this.cashFlowRepository});

  @override
  Future<Either<Failure, BasicNameIdObjectEntity>> call(String params) async {
    return await cashFlowRepository
        .getExpenesesCategoryByName(
         params
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Expenses Category By Name: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}


