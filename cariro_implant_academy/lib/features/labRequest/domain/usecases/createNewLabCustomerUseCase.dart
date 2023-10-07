import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/labCustomersRepository.dart';

class CreateNewLabCustomerUseCase extends UseCases<UserEntity, UserEntity> {
  final LabCustomersRepository labCustomersRepository;

  CreateNewLabCustomerUseCase({required this.labCustomersRepository});

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) async {
    return await labCustomersRepository.createNewCustomer(params).then((value) => value.fold(
          (l) => Left(l..message = "Create Lab Customer:${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
