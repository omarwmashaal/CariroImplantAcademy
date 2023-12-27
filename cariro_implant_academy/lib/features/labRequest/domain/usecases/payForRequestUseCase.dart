import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

class PayRequestUseCase extends UseCases<NoParams, int> {
  final LabRequestRepository labRequestRepository;

  PayRequestUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(int id) async {
    return await labRequestRepository.payForRequest(id).then((value) => value.fold(
          (l) => Left(l..message = "Pay Request: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

