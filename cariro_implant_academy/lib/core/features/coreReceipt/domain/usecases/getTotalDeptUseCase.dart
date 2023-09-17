import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetTotalDebtUsecase extends UseCases<int, int> {
  final ReceiptRepository receiptRepository;

  GetTotalDebtUsecase({required this.receiptRepository});

  @override
  Future<Either<Failure, int>> call(int patientId) async {
    return await receiptRepository.getTotalDebt(patientId:patientId).then((value) => value.fold(
          (l) => Left(l..message = "Get Total Debt: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
