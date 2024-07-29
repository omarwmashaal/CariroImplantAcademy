import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/useCases/useCases.dart';
import '../entities/patientInfoEntity.dart';
import '../repositories/patientInfoRepo.dart';

class PatientSearchUseCase extends UseCases<List<PatientInfoEntity>, PatientSearchParams> {
  final PatientInfoRepo repo;

  PatientSearchUseCase(this.repo);

  @override
  Future<Either<Failure, List<PatientInfoEntity>>> call(PatientSearchParams searchParams) async {
    return await repo.searchPatients(searchParams);
  }
}

class PatientSearchParams extends Equatable {
  final String? query;
  final String? filter;
  final bool myPatients;
  final bool? out;
  final bool? listed;
  final EnumPatientCallHistory? callHistory;

  PatientSearchParams({required this.myPatients, this.query, this.filter, this.out, this.listed, this.callHistory});

  @override
  // TODO: implement props
  List<Object?> get props => [this.filter, this.query, this.myPatients, callHistory];
}
