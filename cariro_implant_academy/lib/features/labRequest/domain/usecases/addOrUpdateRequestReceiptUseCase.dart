import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';


// class AddOrUpdateRequestReceiptUseCase extends UseCases<NoParams, AddOrUpdateRequestReceiptParams> {
//   final LabRequestRepository labRequestRepository;

//   AddOrUpdateRequestReceiptUseCase({required this.labRequestRepository});

//   @override
//   Future<Either<Failure, NoParams>> call(AddOrUpdateRequestReceiptParams params) async {
//     return await labRequestRepository
//         .addOrUpdateRequestReceipt(
//           params.id,
//           params.steps,
//         )
//         .then((value) => value.fold(
//               (l) => Left(l..message = "Update Request Receipt: ${l.message ?? ""}"),
//               (r) => Right(r),
//             ));
//   }
// }

// class AddOrUpdateRequestReceiptParams {
//   final int id;
//   final List<LabStepEntity> steps;

//   AddOrUpdateRequestReceiptParams({required this.id, required this.steps});
// }
