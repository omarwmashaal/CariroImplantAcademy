import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'medicalInfoShellBloc_States.dart';

class MedicalInfoShellBloc extends Bloc<MedicalInfoShellBloc_Event, MedicalInfoShellBloc_State> {
  bool allowEdit = false;
  Function? saveChanges;

  MedicalInfoShellBloc() : super(MedicalInfoBlocInitState()) {
    on<MedicalInfoShell_ChangeTitleEvent>(
            (event, emit) => emit(MedicalInfoBlocChangeTitleState(title: event.title))
    );
    on<MedicalInfoShell_ChangeViewEditEvent>(
            (event, emit) {
              allowEdit = event.allowEdit;
              emit(MedicalInfoBlocChangeViewEditState(edit: event.allowEdit));
            }
    );

    on<MedicalInfoShell_SaveChanges>((event, emit) {
      if(saveChanges!=null)
        saveChanges!();
    },);

  }




}
