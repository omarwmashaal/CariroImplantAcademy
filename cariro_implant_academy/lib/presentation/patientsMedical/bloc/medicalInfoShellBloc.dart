import 'package:flutter_bloc/flutter_bloc.dart';

import 'medicalInfoShellBloc_States.dart';

class MedicalInfoShellBloc extends Cubit<MedicalInfoShellBloc_State> {
  MedicalInfoShellBloc(super.initialState);
  bool allowEdit = false;
  changeTitle({required String title}) => emit(MedicalInfoBlocChangeTitleState(title: title));
  changeViewEdit({required bool edit}) {
    allowEdit =edit;
    emit(MedicalInfoBlocChangeViewEditState(edit: edit));
  }
}
