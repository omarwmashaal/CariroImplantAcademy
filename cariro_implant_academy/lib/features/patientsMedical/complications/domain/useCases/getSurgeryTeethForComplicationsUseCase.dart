import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';
import 'package:dartz/dartz.dart';

class GetSurgeryTeethForComplicationsUseCase extends UseCases<List<int>, int> {
  final ComplicationsRepo complicationsRepo;

  GetSurgeryTeethForComplicationsUseCase({required this.complicationsRepo});

  @override
  Future<Either<Failure, List<int>>> call(int id) async {
    return await complicationsRepo.getSurgeryTeethForComplications(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Surgery Teeth For Complications: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
