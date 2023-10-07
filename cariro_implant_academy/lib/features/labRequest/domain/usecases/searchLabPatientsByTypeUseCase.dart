import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labCustomersRepository.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/repositories/labRequestsRepository.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/enums.dart';

class SearchLabPatientsByTypeUseCase extends UseCases<List<PatientInfoEntity>, SearchLabPatientsByTypeParams> {
  final LabCustomersRepository labCustomersRepository;

  SearchLabPatientsByTypeUseCase({required this.labCustomersRepository});

  @override
  Future<Either<Failure, List<PatientInfoEntity>>> call(SearchLabPatientsByTypeParams params) async {
    return await labCustomersRepository.searchLabPatientsByType(params.search,params.type).then((value) => value.fold(
          (l) => Left(l..message = "Search Lab Patients: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class SearchLabPatientsByTypeParams {
 final String? search;
 final EnumLabRequestSources type;

 SearchLabPatientsByTypeParams({
    required this.search,
   required this.type,
  });
}
