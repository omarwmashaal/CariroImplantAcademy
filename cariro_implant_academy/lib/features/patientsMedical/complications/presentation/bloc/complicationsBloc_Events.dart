import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';

import '../../domain/entities/complicationsAfterProsthesisEntity.dart';

abstract class ComplicationsBloc_Events {}

class ComplicationsBloc_GetComplicationsAfterProsthesisEvent extends ComplicationsBloc_Events {
  final int id;

  ComplicationsBloc_GetComplicationsAfterProsthesisEvent({required this.id});
}

class ComplicationsBloc_GetComplicationsAfterSurgeryEvent extends ComplicationsBloc_Events {
  final int id;

  ComplicationsBloc_GetComplicationsAfterSurgeryEvent({required this.id});
}

class ComplicationsBloc_UpdateComplicationsAfterSurgeryEvent extends ComplicationsBloc_Events {
  final UpdateSurgicalComplicationsParams data;

  ComplicationsBloc_UpdateComplicationsAfterSurgeryEvent({required this.data});
}

class ComplicationsBloc_UpdateComplicationsAfterProsthesisEvent extends ComplicationsBloc_Events {
  final UpdateProstheticComplicationsParams data;

  ComplicationsBloc_UpdateComplicationsAfterProsthesisEvent({required this.data});
}
