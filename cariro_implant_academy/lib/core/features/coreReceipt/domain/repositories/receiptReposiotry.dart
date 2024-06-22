import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failure.dart';
import '../entities/receiptEntity.dart';

abstract class ReceiptRepository {
  Future<Either<Failure, NoParams>> addPatientReceipt({required int patientId, required int tooth, required String action, int? price});
  Future<Either<Failure, ReceiptEntity>> getTodaysReceipt({required int patientId});
  Future<Either<Failure, ReceiptEntity>> getLastReceipt({required int patientId});
  Future<Either<Failure, List<ReceiptEntity>>> getReceipts({required int patientId});
  Future<Either<Failure, ReceiptEntity>> getReceiptById({required int receiptId});
  Future<Either<Failure, List<PaymentLogEntity>>> getAllPaymentLogs({required int patientId});
  Future<Either<Failure, List<PaymentLogEntity>>> getPaymentLogsforAReceipt({required int receiptId});
  Future<Either<Failure, NoParams>> addPayment({required int patientId, required int receiptId, required int paidAmount});
  Future<Either<Failure, NoParams>> removePayment({required int paymentId});
  Future<Either<Failure, int>> getTotalDebt({required int patientId});
}
