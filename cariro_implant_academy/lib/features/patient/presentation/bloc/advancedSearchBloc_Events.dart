import 'package:cariro_implant_academy/features/patient/data/models/advancedProstheicSeachRequestModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/advancedProstheticSearchUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/PatientAdvancedSearchPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:equatable/equatable.dart';

abstract class AdvancedSearchBloc_Events extends Equatable {}

class AdvancedSearchBloc_SearchPatientsEvents extends AdvancedSearchBloc_Events {
  final AdvancedPatientSearchEntity patientQuery;
  final AdvancedTreatmentSearchEntity treatmentQuery;
  final AdvancedProstheticSearchRequestEntity prostheticQuery;
  final AdvancedSearchEnum type;
  AdvancedSearchBloc_SearchPatientsEvents({
    required this.patientQuery,
    required this.treatmentQuery,
    required this.prostheticQuery,
    required this.type,
  });
  @override
  List<Object?> get props => [patientQuery];
}

class AdvancedSearchBloc_SearchTreatmentsEvents extends AdvancedSearchBloc_Events {
  final AdvancedTreatmentSearchEntity query;
  AdvancedSearchBloc_SearchTreatmentsEvents({required this.query});
  @override
  List<Object?> get props => [query];
}

class AdvancedSearchBloc_SearchProstheticEvents extends AdvancedSearchBloc_Events {
  final AdvancedProstheicSearchRequestModel query;
  AdvancedSearchBloc_SearchProstheticEvents({required this.query});
  @override
  List<Object?> get props => [query];
}
