import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetReceiptsUsecase extends UseCases<List<ReceiptEntity>, int> {
  final ReceiptRepository receiptRepository;

  GetReceiptsUsecase({required this.receiptRepository});

  @override
  Future<Either<Failure, List<ReceiptEntity>>> call(int patientId) async {
    return await receiptRepository.getReceipts(patientId: patientId).then((value) => value.fold(
          (l) => Left(l..message = "Get Receipts: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
