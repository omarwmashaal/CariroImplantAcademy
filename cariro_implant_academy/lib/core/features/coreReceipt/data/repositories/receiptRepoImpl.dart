import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/datasource/receiptsDatasource.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class ReceiptRepositoryImpl implements ReceiptRepository{
  final ReceiptsDatasource receiptDataSource;
  ReceiptRepositoryImpl({required this.receiptDataSource});
  @override
  Future<Either<Failure, NoParams>> addPayment({required int patientId, required int receiptId, required int paidAmount})async {
    try {
      final result = await receiptDataSource.addPayment(patientId:patientId,paidAmount: paidAmount,receiptId: receiptId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<PaymentLogEntity>>> getAllPaymentLogs({required int patientId}) async {
    try {
      final result = await receiptDataSource.getAllPaymentLogs(patientId:patientId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReceiptEntity>> getLastReceipt({required int patientId})  async {
    try {
      final result = await receiptDataSource.getLastReceipt(patientId:patientId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<PaymentLogEntity>>> getPaymentLogsforAReceipt({required int patientId, required int receiptId}) async {
    try {
      final result = await receiptDataSource.getPaymentLogsforAReceipt(patientId:patientId,receiptId: receiptId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReceiptEntity>> getReceiptById({required int receiptId}) async {
    try {
      final result = await receiptDataSource.getReceiptById(receiptId: receiptId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ReceiptEntity>>> getReceipts({required int patientId})async {
    try {
      final result = await receiptDataSource.getReceipts(patientId: patientId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ReceiptEntity>> getTodaysReceipt({required int patientId}) async {
    try {
      final result = await receiptDataSource.getTodaysReceipt(patientId: patientId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalDebt({required int patientId}) async {
    try {
      final result = await receiptDataSource.getTotalDebt(patientId: patientId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> removePayment({required int paymentId}) async {
    try {
      final result = await receiptDataSource.removePayment(paymentId: paymentId);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addPatientReceipt({required int patientId, required int tooth, required String action, int? price}) async {
    try {
      final result = await receiptDataSource.addPatientReceipt(patientId,tooth,action, price);
      return Right(result);
    } on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}