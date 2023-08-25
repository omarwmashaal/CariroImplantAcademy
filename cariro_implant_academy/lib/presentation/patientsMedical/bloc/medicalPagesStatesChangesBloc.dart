import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'medicalPagesStatesChangesBloc_States.dart';

class MedicalPagesStatesChangesBloc extends Cubit<MedicalPagesStatesChangesBloc_States> {
  MedicalPagesStatesChangesBloc(super.initialState);

  changeSmokingStatus({required int numberOfCigarettes}) {
    if (numberOfCigarettes == 0)
      emit(ChangeSmokingStatusState(smokingStatus: SmokingStatus.NoneSmoker));
    else if (numberOfCigarettes <= 10)
      emit(ChangeSmokingStatusState(smokingStatus: SmokingStatus.LightSmoker));
    else if (numberOfCigarettes <= 20)
      emit(ChangeSmokingStatusState(smokingStatus: SmokingStatus.MediumSmoker));
    else
      emit(ChangeSmokingStatusState(smokingStatus: SmokingStatus.HeavySmoker));
  }
}
