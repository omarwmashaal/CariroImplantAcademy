import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';

abstract class ClinicTreatmentBloc_Events {}

class ClinicTreatmentBloc_LoadTreatmentsEvent extends ClinicTreatmentBloc_Events {
  final int id;

  ClinicTreatmentBloc_LoadTreatmentsEvent({required this.id});
}

class ClinicTreatmentBloc_UpdateTreatmentsEvent extends ClinicTreatmentBloc_Events {
  final UpdateClinicTreatmentsParams data;

  ClinicTreatmentBloc_UpdateTreatmentsEvent({required this.data});
}

class ClinicTreatmentBloc_BuildPageEvent extends ClinicTreatmentBloc_Events {
  final List<int> selectedTeeth;
  final SelectedTreatmentEnum selectedTreatmentEnum;
  final List<EnumClinicPedoTooth>? selectedPedoTeeth;
  final EnumClinicImplantTypes? implantType;
  final ClinicTreatmentEntity data;

  ClinicTreatmentBloc_BuildPageEvent({
    required this.selectedTeeth,
    required this.selectedTreatmentEnum,
    required this.data,
    this.selectedPedoTeeth,
    this.implantType,
  });
}
