import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:equatable/equatable.dart';

abstract class AdvancedSearchBloc_Events extends Equatable{}

class AdvancedSearchBloc_SearchPatientsEvents extends AdvancedSearchBloc_Events{
  final AdvancedPatientSearchEntity query;
  AdvancedSearchBloc_SearchPatientsEvents({required this.query});
  @override
  List<Object?> get props => [query];
}
class AdvancedSearchBloc_SearchTreatmentsEvents extends AdvancedSearchBloc_Events{
  final AdvancedTreatmentSearchEntity query;
  AdvancedSearchBloc_SearchTreatmentsEvents({required this.query});
  @override
  List<Object?> get props => [query];
}