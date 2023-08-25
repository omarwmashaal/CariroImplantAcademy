import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class AddRangeToMyPatientsUseCase extends UseCases<bool,AddRangePatientsParams>{
  AddOrRemoveMyPatientsRepo repo;
  AddRangeToMyPatientsUseCase(this.repo);
  @override
  Future<Either<Failure, bool>> call(params) async{
    if(params.from>= params.to)
      return Left(InputValidationFailure(failureMessage: "from can't be greater than or equal to"));

    return await repo.addToMyPatientsRange(params);
  }

}
class AddRangePatientsParams extends Equatable{
  final int from;
  final int to;
  AddRangePatientsParams({required this.from,required this.to});
  @override
  // TODO: implement props
  List<Object?> get props => [from,to];

}