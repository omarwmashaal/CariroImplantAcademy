import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/enums.dart';

class GetAllLabRequestsUseCase extends UseCases<List<LabRequestEntity>, GetAllRequestsParams> {
  final LabRequestRepository labRequestRepository;

  GetAllLabRequestsUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, List<LabRequestEntity>>> call(GetAllRequestsParams params) async {
    return await labRequestRepository.getAllLabRequests(params).then((value) => value.fold(
          (l) => Left(l..message = "Get All Lab Requests: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class GetAllRequestsParams {
  DateTime? from;
  DateTime? to;
  String? search;
  EnumLabRequestStatus? status;
  Website? source;
  bool? paid;
  bool myRequests;

  GetAllRequestsParams({
    this.from,
    this.to,
    this.search,
    this.status,
    this.source,
    this.paid,
    this.myRequests = false,
  });
}
