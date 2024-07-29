import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientFieldWidget extends StatefulWidget {
  PatientFieldWidget({
    super.key,
    required this.bloc,
    required this.editOrAddWidget,
    required this.viewWidget,
  });
  CreateOrViewPatientBloc bloc;
  Widget editOrAddWidget;
  Widget viewWidget;

  @override
  State<PatientFieldWidget> createState() => _PatientFieldWidgetState();
}

class _PatientFieldWidgetState extends State<PatientFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
      bloc: widget.bloc,
      buildWhen: (previous, current) => current is ChangePageState,
      builder: (context, state) {
        if (state is ChangePageState && (widget.bloc.pageState == PageState.addNew || widget.bloc.pageState == PageState.edit)) {
          return widget.editOrAddWidget;
        } else {
          return widget.viewWidget;
        }
      },
    );
  }
}
