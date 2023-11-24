import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';

import '../../../../core/features/settings/domain/entities/clinicPriceEntity.dart';
import '../../domain/entities/clinicDoctorPercentageEntity.dart';

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

  ClinicTreatmentBloc_SelectedTreatmentState({this.selectedTreatment});
}

class ClinicTreatmentBloc_SelectedTeethState extends ClinicTreatmentBloc_States {
  final List<int> teeth;

  ClinicTreatmentBloc_SelectedTeethState({required this.teeth});
}

class ClinicTreatmentBloc_SelectedPedoTeethState extends ClinicTreatmentBloc_States {
  final List<int> teeth;

  ClinicTreatmentBloc_SelectedPedoTeethState({required this.teeth});
}

class ClinicTreatmentBloc_SelectedImplantTypeState extends ClinicTreatmentBloc_States {
  final EnumClinicImplantTypes implantType;

  ClinicTreatmentBloc_SelectedImplantTypeState({required this.implantType});
}

class ClinicTreatmentBloc_LoadingPricesState extends ClinicTreatmentBloc_States {
  final String key;

  ClinicTreatmentBloc_LoadingPricesState({required this.key});
}

class ClinicTreatmentBloc_LoadedPricesSuccessfullyState extends ClinicTreatmentBloc_States {
  final String key;
  final List<ClinicPriceEntity>? prices;

  ClinicTreatmentBloc_LoadedPricesSuccessfullyState({required this.key, this.prices});
}

class ClinicTreatmentBloc_LoadingPricesErrorState extends ClinicTreatmentBloc_States {
  final String key;
  final String message;

  ClinicTreatmentBloc_LoadingPricesErrorState({required this.message, required this.key});
}

class ClinicTreatmentBloc_LoadingDoctorsPercentageState extends ClinicTreatmentBloc_States {}

class ClinicTreatmentBloc_LoadedDoctorsPercentageState extends ClinicTreatmentBloc_States {
  final List<ClinicDoctorPercentageEntity> data;

  ClinicTreatmentBloc_LoadedDoctorsPercentageState({required this.data});
}

class ClinicTreatmentBloc_LoadingDoctorsPercentageErrorState extends ClinicTreatmentBloc_States {
  final String message;

  ClinicTreatmentBloc_LoadingDoctorsPercentageErrorState({required this.message});
}

class ClinicTreatmentBloc_ShowPricesState extends ClinicTreatmentBloc_States {}

class ClinicTreatmentBloc_ShowTreatmentstate extends ClinicTreatmentBloc_States {}

class ClinicTreatmentBloc_TotalPriceChangedState extends ClinicTreatmentBloc_States {
  final int price;

  ClinicTreatmentBloc_TotalPriceChangedState({required this.price});
}

enum SelectedTreatmentEnum {
  restoration,
  implants,
  ortho,
  tmd,
  pedo,
  rootCanalTreatment,
  scaling,
}
