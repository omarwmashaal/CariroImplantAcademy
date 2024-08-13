import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';

class PayRequestUseCase extends UseCases<NoParams, PayRequestParams> {
  final LabRequestRepository labRequestRepository;

  PayRequestUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(PayRequestParams params) async {
    return await labRequestRepository.payForRequest(params.requestId, params.amount).then((value) => value.fold(
          (l) => Left(l..message = "Pay Request: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class PayRequestParams {
  final int requestId;
  final int amount;
  PayRequestParams({
    required this.requestId,
    required this.amount,
  });
}
