import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/treatmentWidget.dart';
import 'package:dartz/dartz.dart';

class AddReceiptUseCase extends UseCases<ReceiptEntity, ReceiptEntity> {
  final ReceiptRepository receiptRepository;

  AddReceiptUseCase({required this.receiptRepository});

  @override
  Future<Either<Failure, ReceiptEntity>> call(ReceiptEntity params) async {
    return await receiptRepository.addReceipt(params).then((value) => value.fold(
          (l) => Left(l..message = "Add Patient Receipt: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
