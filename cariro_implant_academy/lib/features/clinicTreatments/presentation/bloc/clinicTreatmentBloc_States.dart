import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';

abstract class ClinicTreatmentBloc_States {}

class ClinicTreatmentBloc_InitState extends ClinicTreatmentBloc_States {}
class ClinicTreatmentBloc_LoadingTreatmentsState extends ClinicTreatmentBloc_States {}
class ClinicTreatmentBloc_UpdatingTreatmentsState extends ClinicTreatmentBloc_States {}
class ClinicTreatmentBloc_UpdatedTreatmentsSuccessfullyState extends ClinicTreatmentBloc_States {}

class ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState extends ClinicTreatmentBloc_States {
  final ClinicTreatmentEntity data;
  ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState({required this.data});
}
class ClinicTreatmentBloc_LoadingTreatmentsErrorState extends ClinicTreatmentBloc_States {
  final String message;
  ClinicTreatmentBloc_LoadingTreatmentsErrorState({required this.message});
}
class ClinicTreatmentBloc_UpdatingTreatmentsErrorState extends ClinicTreatmentBloc_States {
  final String message;
  ClinicTreatmentBloc_UpdatingTreatmentsErrorState({required this.message});
}


class ClinicTreatmentBloc_SelectedTreatmentState extends ClinicTreatmentBloc_States {
  final SelectedTreatmentEnum? selectedTreatment;
  ClinicTreatmentBloc_SelectedTreatmentState({ this.selectedTreatment});
}

class ClinicTreatmentBloc_SelectedTeethState extends ClinicTreatmentBloc_States {
  final List<int> teeth;
  ClinicTreatmentBloc_SelectedTeethState({required  this.teeth});
}
class ClinicTreatmentBloc_SelectedPedoTeethState extends ClinicTreatmentBloc_States {
  final List<EnumClinicPedoTooth> teeth;
  ClinicTreatmentBloc_SelectedPedoTeethState({required  this.teeth});
}
class ClinicTreatmentBloc_SelectedImplantTypeState extends ClinicTreatmentBloc_States {
  final EnumClinicImplantTypes implantType;
  ClinicTreatmentBloc_SelectedImplantTypeState({required  this.implantType});
}

enum SelectedTreatmentEnum{
  restoration,
  implants,
  ortho,
  tmd,
  pedo,
  rootCanalTreatment,
  scaling,
}
