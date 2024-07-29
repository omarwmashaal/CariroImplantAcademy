import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class AddPaymentUseCase extends UseCases<NoParams, AddPaymentParams> {
  final ReceiptRepository receiptRepository;

  AddPaymentUseCase({required this.receiptRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddPaymentParams params) async {
    return await receiptRepository
        .addPayment(patientId: params.patientId, receiptId: params.receiptId, paidAmount: params.paidAmount, paymentMethodId: params.paymentMethodId)
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Add Payment: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class AddPaymentParams {
  final int patientId;
  final int receiptId;
  final int paidAmount;
  final int? paymentMethodId;
  AddPaymentParams({required this.patientId, required this.receiptId, required this.paidAmount, this.paymentMethodId});
}
