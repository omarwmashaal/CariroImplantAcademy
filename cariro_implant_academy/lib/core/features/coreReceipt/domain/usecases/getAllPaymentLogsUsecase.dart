import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetAllPaymentLogsUsecase extends UseCases<List<PaymentLogEntity>, int> {
  final ReceiptRepository receiptRepository;

  GetAllPaymentLogsUsecase({required this.receiptRepository});

  @override
  Future<Either<Failure, List<PaymentLogEntity>>> call(int patientId) async {
    return await receiptRepository.getAllPaymentLogs(patientId: patientId).then((value) => value.fold(
          (l) => Left(l..message = "Get All Payment Logs: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
