import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/useCases/useCases.dart';

class ConsumeLabItemUseCase extends UseCases<NoParams, ConsumeLabItemParams> {
  final LabRequestRepository labRequestRepository;

  ConsumeLabItemUseCase({required this.labRequestRepository});

  @override
  Future<Either<Failure, NoParams>> call(ConsumeLabItemParams params) async {
    return await labRequestRepository.consumeLabItem(params.id,params.number, params.consumeWholeBlock).then((value) => value.fold(
          (l) => Left(l..message = "Consume Lab Item: $l"),
          (r) => Right(r),
        ));
  }
}

class ConsumeLabItemParams {
  final int id;
  final int? number;
  final bool consumeWholeBlock;

  ConsumeLabItemParams({required this.id , this.number, this.consumeWholeBlock = false}) {
    assert((number == null && consumeWholeBlock == true) || (number != null && consumeWholeBlock == false));
  }
}
