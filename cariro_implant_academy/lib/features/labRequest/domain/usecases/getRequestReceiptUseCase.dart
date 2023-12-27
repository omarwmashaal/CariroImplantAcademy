import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class GetRequestReceiptUseCase extends UseCases<ReceiptEntity?, int> {
  final LabRequestRepository labRequestRepository;

  GetRequestReceiptUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, ReceiptEntity?>> call(int id) async {
    return await labRequestRepository.getRequestReceipt(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Request Receipt: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
