import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class RemovePaymentUseCase extends UseCases<NoParams, int> {
  final ReceiptRepository receiptRepository;

  RemovePaymentUseCase({required this.receiptRepository});

  @override
  Future<Either<Failure, NoParams>> call(int paymentId) async {
    return await receiptRepository.removePayment(paymentId: paymentId).then((value) => value.fold(
          (l) => Left(l..message = "Get Remove Payment: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
