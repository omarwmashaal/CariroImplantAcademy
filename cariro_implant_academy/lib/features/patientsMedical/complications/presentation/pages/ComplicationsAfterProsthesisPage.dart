import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';

import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:intl/intl.dart';

import '../../../../../Widgets/FormTextWidget.dart';
import 'package:collection/collection.dart';

class ComplicationsAfterProsthesisPage extends StatefulWidget {
  ComplicationsAfterProsthesisPage({Key? key, required this.patientId}) : super(key: key);
  static String routePath = ":id/ProstheticComplications";
  int patientId;

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicComplicationsAfterProsthesis";
      default:
        return "ComplicationsAfterProsthesis";
    }
  }

  @override
  State<ComplicationsAfterProsthesisPage> createState() => _ComplicationsAfterProsthesisPageState();
}

class _ComplicationsAfterProsthesisPageState extends State<ComplicationsAfterProsthesisPage> {
  late ComplicationsBloc bloc;
  List<BasicNameIdObjectEntity> defaultComps = [];
  late SettingsBloc settingsBloc;

  late List<ComplicationsAfterProsthesisEntity> complicationsAfterProsthesisEntity;

  late MedicalInfoShellBloc medicalShellBloc;

  @override
  void dispose() {
    if (bloc.isInitialized && medicalShellBloc.allowEdit) {
      bloc.add(ComplicationsBloc_UpdateComplicationsAfterProsthesisEvent(
        data: UpdateProstheticComplicationsParams(
          data: complicationsAfterProsthesisEntity,
          id: widget.patientId,
        ),
      ));
    }

    super.dispose();
  }

  @override
  void initState() {
    bloc = BlocProvider.of<ComplicationsBloc>(context);
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.add(SettingsBloc_LoadDefaultProstheticComplicationsEvent());

    bloc.add(ComplicationsBloc_GetComplicationsAfterProsthesisEvent(id: widget.patientId));
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Complications After Prosthesis"));
    medicalShellBloc.saveChanges = () {
      bloc.add(ComplicationsBloc_UpdateComplicationsAfterProsthesisEvent(
        data: UpdateProstheticComplicationsParams(
          data: complicationsAfterProsthesisEntity,
          id: widget.patientId,
        ),
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
      bloc: medicalShellBloc,
      buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
      builder: (context, stateShell) {
        return AbsorbPointer(
          absorbing: () {
            if (stateShell is MedicalInfoBlocChangeViewEditState) {
              //   edit = stateShell.edit;
              return !stateShell.edit;
            } else {
              // edit = false;
              return true;
            }
          }(),
          child: BlocConsumer<ComplicationsBloc, ComplicationsBloc_States>(
            buildWhen: (previous, current) =>
                current is ComplicationsBloc_LoadingComplicationsAfterProsthesisErrorState ||
                current is ComplicationsBloc_LoadingComplicationsAfterProsthesisState ||
                current is ComplicationsBloc_LoadedComplicationsAfterProsthesisSuccessfullyState,
            builder: (context, state) {
              if (state is ComplicationsBloc_LoadingComplicationsAfterProsthesisState)
                return const LoadingWidget();
              else if (state is ComplicationsBloc_LoadingComplicationsAfterProsthesisErrorState)
                return BigErrorPageWidget(message: state.message);
              else if (state is ComplicationsBloc_LoadedComplicationsAfterProsthesisSuccessfullyState) {
                complicationsAfterProsthesisEntity = state.data;

                bloc.isInitialized = true;

                return StatefulBuilder(builder: (context, _setState) {
                  return Column(
                    children: [
                      BlocBuilder<SettingsBloc, SettingsBloc_States>(
                          buildWhen: (previous, current) =>
                              current is SettingsBloc_LoadingDefaultProstheticComplicationsErrorState ||
                              current is SettingsBloc_LoadingDefaultProstheticComplicationsState ||
                              current is SettingsBloc_LoadedDefaultProstheticComplicationsSuccessfullyState,
                          builder: (context, state) {
                            if (state is SettingsBloc_LoadingDefaultProstheticComplicationsErrorState)
                              return Text("Error Loading Default Complications");
                            else if (state is SettingsBloc_LoadingDefaultProstheticComplicationsState)
                              return LoadingWidget();
                            else if (state is SettingsBloc_LoadedDefaultProstheticComplicationsSuccessfullyState) defaultComps = state.data;
                            return Wrap(
                              children: defaultComps
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CIA_SecondaryButton(
                                        icon: const Icon(Icons.add),
                                        label: e?.name ?? "",
                                        onTab: () {
                                          complicationsAfterProsthesisEntity = [
                                            ...complicationsAfterProsthesisEntity,
                                            ComplicationsAfterProsthesisEntity(
                                              patientId: widget.patientId,
                                              date: DateTime.now(),
                                              name: e?.name,
                                              defaultId: e?.id,
                                              operator: BasicNameIdObjectEntity(
                                                id: siteController.getUserId(),
                                                name: siteController.getUserName(),
                                              ),
                                              operatorId: siteController.getUserId(),
                                            )
                                          ];
                                          _setState(() {});
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }),
                      Expanded(
                        child: ListView(
                          children: complicationsAfterProsthesisEntity
                              .mapIndexed((i, e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "${i + 1}. ${e.name}")),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            label: "Notes",
                                            controller: TextEditingController(text: e.notes ?? ""),
                                            onChange: (value) => e.notes = value,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_GestureWidget(
                                            onTap: () {
                                              CIA_PopupDialog_DateOnlyPicker(
                                                context,
                                                "Change Date",
                                                (p0) => _setState(() => e.date = p0),
                                              );
                                            },
                                            child: FormTextValueWidget(
                                              text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_GestureWidget(
                                            onTap: () => CIA_ShowPopUp(
                                              context: context,
                                              height: 100,
                                              onSave: () => _setState(() => null),
                                              child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                                onClear: () {
                                                  e.operatorId = null;
                                                  e.operator = null;
                                                },
                                                asyncUseCase: sl<LoadUsersUseCase>(),
                                                searchParams: LoadUsersEnum.instructorsAndAssistants,
                                                onSelect: (value) {
                                                  e.operatorId = value.id;
                                                  e.operator = value;
                                                },
                                                //selectedItem: DropDownDTO(),
                                                selectedItem: e.operator ?? BasicNameIdObjectEntity(name: "", id: 0),
                                                label: "Operator",
                                              ),
                                            ),
                                            child: FormTextValueWidget(
                                              text: e.operator?.name,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              complicationsAfterProsthesisEntity.remove(e);
                                              _setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                            )),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  );
                });
              }
              return Container();
            },
            listener: (context, state) {
              if (state is ComplicationsBloc_UpdatingComplicationsAfterProsthesisState) {
                CustomLoader.show(context);
              } else {
                CustomLoader.hide();
                if (state is ComplicationsBloc_UpdatedComplicationsAfterProsthesisSuccessfullyState) {
                  ShowSnackBar(context, isSuccess: true);
                  bloc.add(ComplicationsBloc_GetComplicationsAfterProsthesisEvent(id: widget.patientId));
                } else if (state is ComplicationsBloc_UpdatingComplicationsAfterProsthesisErrorState)
                  ShowSnackBar(context, isSuccess: false, message: state.message);
              }
            },
          ),
        );
      },
    );
  }
}
