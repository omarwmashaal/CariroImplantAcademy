import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetReceiptByIdUseCase extends UseCases<ReceiptEntity, int> {
  final ReceiptRepository receiptRepository;

  GetReceiptByIdUseCase({required this.receiptRepository});

  @override
  Future<Either<Failure, ReceiptEntity>> call(int receiptId) async {
    return await receiptRepository.getReceiptById(receiptId: receiptId).then((value) => value.fold(
          (l) => Left(l..message = "Get Receipt By Id: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
