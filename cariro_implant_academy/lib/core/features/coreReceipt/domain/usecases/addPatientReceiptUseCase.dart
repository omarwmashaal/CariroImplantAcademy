import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/repositories/receiptReposiotry.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class AddPatientReceiptUseCase extends UseCases<NoParams, AddPatientReceiptParams> {
  final ReceiptRepository receiptRepository;

  AddPatientReceiptUseCase({required this.receiptRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddPatientReceiptParams params) async {
    return await receiptRepository.addPatientReceipt(patientId: params.patientId,action: params.action,tooth:  params.tooth).then((value) => value.fold(
          (l) => Left(l..message = "Get Add Patient Receipt: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
class AddPatientReceiptParams{
  final int patientId;
  final int tooth;
  final String action;
  AddPatientReceiptParams({required this.patientId,required this.tooth,required this.action});

}
