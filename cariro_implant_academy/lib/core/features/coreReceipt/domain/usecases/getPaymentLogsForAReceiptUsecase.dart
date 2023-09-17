import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetPaymentLogsForAReceiptUseCase extends UseCases<List<PaymentLogEntity>, GetPaymentLogForAReceiptParams> {
  final ReceiptRepository receiptRepository;

  GetPaymentLogsForAReceiptUseCase({required this.receiptRepository});

  @override
  Future<Either<Failure, List<PaymentLogEntity>>> call(GetPaymentLogForAReceiptParams params) async {
    return await receiptRepository.getPaymentLogsforAReceipt(patientId: params.patientId,receiptId: params.receiptId).then((value) => value.fold(
          (l) => Left(l..message = "Get Payment Logs For A Receipt: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
class GetPaymentLogForAReceiptParams{
  final int patientId;
  final int receiptId;
  GetPaymentLogForAReceiptParams({required this.patientId,required this.receiptId});

}
