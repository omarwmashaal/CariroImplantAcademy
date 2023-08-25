import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/dentalExaminationBaseEntity.dart';
import 'bloc_constants.dart';

 abstract class DentalExaminationBloc_States extends Equatable{}
 class DentalExaminationBloc_InitState extends DentalExaminationBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

 }
 class DentalExaminationBloc_LoadingDataState extends DentalExaminationBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

 }
 class DentalExaminationBloc_SavingingDataState extends DentalExaminationBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

 }
 class DentalExaminationBloc_LoadedSuccessfullyState extends DentalExaminationBloc_States{
  final DentalExaminationBaseEntity dentalExaminationEntity;
  DentalExaminationBloc_LoadedSuccessfullyState({required this.dentalExaminationEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [dentalExaminationEntity];

 }
 class DentalExaminationBloc_SavedDataSuccessfullyState extends DentalExaminationBloc_States{
   @override
  // TODO: implement props
  List<Object?> get props => [];

 }
 class DentalExaminationBloc_ErrorState extends DentalExaminationBloc_States{
  final String message;
  DentalExaminationBloc_ErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

 }


class DentalExaminationBloc_TeethStatusChanged extends DentalExaminationBloc_States {
 TeethStatus teethStatus;

 DentalExaminationBloc_TeethStatusChanged({
  required this.teethStatus,
 });

 @override

 List<Object?> get props => [
    teethStatus,
  identityHashCode(this)
 ];
}

class DentalExaminationBloc_MobilityVisiblityChangedState extends DentalExaminationBloc_States{
  final bool show;
  DentalExaminationBloc_MobilityVisiblityChangedState({required this.show});
  List<Object?> get props => [show];

}