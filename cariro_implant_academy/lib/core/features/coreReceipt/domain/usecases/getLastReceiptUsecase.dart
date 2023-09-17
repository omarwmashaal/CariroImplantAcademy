import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetLastReceiptUsecase extends UseCases<ReceiptEntity, int> {
  final ReceiptRepository receiptRepository;

  GetLastReceiptUsecase({required this.receiptRepository});

  @override
  Future<Either<Failure, ReceiptEntity>> call(int patientId) async {
    return await receiptRepository.getLastReceipt(patientId: patientId).then((value) => value.fold(
          (l) => Left(l..message = "Get Last Receipt: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
