import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';

abstract class ComplicationsBloc_States {}

class ComplicationsBloc_InitialState extends ComplicationsBloc_States {}

class ComplicationsBloc_LoadingComplicationsAfterSurgeryState extends ComplicationsBloc_States {}

class ComplicationsBloc_LoadingComplicationsAfterProsthesisState extends ComplicationsBloc_States {}

class ComplicationsBloc_LoadingComplicationsAfterSurgeryErrorState extends ComplicationsBloc_States {
  final String message;

  ComplicationsBloc_LoadingComplicationsAfterSurgeryErrorState({required this.message});
}

class ComplicationsBloc_LoadingComplicationsAfterProsthesisErrorState extends ComplicationsBloc_States {
  final String message;

  ComplicationsBloc_LoadingComplicationsAfterProsthesisErrorState({required this.message});
}

class ComplicationsBloc_LoadedComplicationsAfterSurgerySuccessfullyState extends ComplicationsBloc_States {
  final List<ComplicationsAfterSurgeryEntity> data;
  final List<int> teeth;

  ComplicationsBloc_LoadedComplicationsAfterSurgerySuccessfullyState({
    required this.data,
    required this.teeth,
  });
}

class ComplicationsBloc_LoadedComplicationsAfterProsthesisSuccessfullyState extends ComplicationsBloc_States {
  final List<ComplicationsAfterProsthesisEntity> data;

  ComplicationsBloc_LoadedComplicationsAfterProsthesisSuccessfullyState({required this.data});
}

class ComplicationsBloc_UpdatingComplicationsAfterSurgeryState extends ComplicationsBloc_States {}

class ComplicationsBloc_UpdatingComplicationsAfterProsthesisState extends ComplicationsBloc_States {}

class ComplicationsBloc_UpdatedComplicationsAfterSurgerySuccessfullyState extends ComplicationsBloc_States {}

class ComplicationsBloc_UpdatedComplicationsAfterProsthesisSuccessfullyState extends ComplicationsBloc_States {}

class ComplicationsBloc_UpdatingComplicationsAfterSurgeryErrorState extends ComplicationsBloc_States {
  final String message;

  ComplicationsBloc_UpdatingComplicationsAfterSurgeryErrorState({required this.message});
}

class ComplicationsBloc_UpdatingComplicationsAfterProsthesisErrorState extends ComplicationsBloc_States {
  final String message;

  ComplicationsBloc_UpdatingComplicationsAfterProsthesisErrorState({required this.message});
}
