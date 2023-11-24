import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';

abstract class ClinicTreatmentBloc_Events {}

class ClinicTreatmentBloc_LoadTreatmentsEvent extends ClinicTreatmentBloc_Events {
  final int id;

  ClinicTreatmentBloc_LoadTreatmentsEvent({required this.id});
}

class ClinicTreatmentBloc_LoadDoctorsPercentagesEvent extends ClinicTreatmentBloc_Events {
  final int id;
  final ClinicTreatmentEntity clinicTreatmentEntity;

  ClinicTreatmentBloc_LoadDoctorsPercentagesEvent({required this.id, required this.clinicTreatmentEntity});
}

class ClinicTreatmentBloc_UpdateTreatmentsEvent extends ClinicTreatmentBloc_Events {
  final UpdateClinicTreatmentsParams data;

  ClinicTreatmentBloc_UpdateTreatmentsEvent({required this.data});
}

class ClinicTreatmentBloc_BuildPageEvent extends ClinicTreatmentBloc_Events {
  final List<int> selectedTeeth;
  final SelectedTreatmentEnum selectedTreatmentEnum;
  final EnumClinicImplantTypes? implantType;
  final ClinicTreatmentEntity data;

  ClinicTreatmentBloc_BuildPageEvent({
    required this.selectedTeeth,
    required this.selectedTreatmentEnum,
    required this.data,
    this.implantType,
  });
}


class ClinicTreatmentBloc_GetPriceEvent extends ClinicTreatmentBloc_Events {
  final GetTeethClinicPircesParams params;
  final String key;

  ClinicTreatmentBloc_GetPriceEvent({required this.params,required this.key});
}
class ClinicTreatmentBloc_CalculateTotalPriceEvent extends ClinicTreatmentBloc_Events {
  final ClinicTreatmentEntity params;


  ClinicTreatmentBloc_CalculateTotalPriceEvent({required this.params});
}