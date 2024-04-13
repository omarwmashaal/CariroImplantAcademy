import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import 'package:collection/collection.dart';

class ComplicationsAfterSurgeryPage extends StatefulWidget {
  ComplicationsAfterSurgeryPage({Key? key, required this.patientId}) : super(key: key);

  static String routePath = ":id/SurgicalComplications";

  int patientId;

  @override
  State<ComplicationsAfterSurgeryPage> createState() => _ComplicationsAfterSurgeryPageState();

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicComplicationsAfterSurgery";
      default:
        return "ComplicationsAfterSurgery";
    }
  }
}

class _ComplicationsAfterSurgeryPageState extends State<ComplicationsAfterSurgeryPage> {
  late ComplicationsBloc bloc;
  late List<ComplicationsAfterSurgeryEntity> complicationsAfterSurgeryEntity;
  //late Future load;
  List<String> complicationsNames = EunumComplicationsAfterSurgery.values
      .map(
        (e) => AddSpacesToSentence(e.name),
      )
      .toList();

  late MedicalInfoShellBloc medicalShellBloc;

  @override
  void dispose() {
    if (bloc.isInitialized && medicalShellBloc.allowEdit) {
      bloc.add(ComplicationsBloc_UpdateComplicationsAfterSurgeryEvent(
        data: UpdateSurgicalComplicationsParams(
          data: complicationsAfterSurgeryEntity,
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
    bloc.add(ComplicationsBloc_GetComplicationsAfterSurgeryEvent(id: widget.patientId));
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Complications After Surgery"));
    medicalShellBloc.saveChanges = () {
      bloc.add(ComplicationsBloc_UpdateComplicationsAfterSurgeryEvent(
        data: UpdateSurgicalComplicationsParams(
          data: complicationsAfterSurgeryEntity,
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
                current is ComplicationsBloc_LoadingComplicationsAfterSurgeryErrorState ||
                current is ComplicationsBloc_LoadingComplicationsAfterSurgeryState ||
                current is ComplicationsBloc_LoadedComplicationsAfterSurgerySuccessfullyState,
            builder: (context, state) {
              if (state is ComplicationsBloc_LoadingComplicationsAfterSurgeryState)
                return const LoadingWidget();
              else if (state is ComplicationsBloc_LoadingComplicationsAfterSurgeryErrorState)
                return BigErrorPageWidget(message: state.message);
              else if (state is ComplicationsBloc_LoadedComplicationsAfterSurgerySuccessfullyState) {
                List<int> teeth = state.teeth;
                complicationsAfterSurgeryEntity = state.data;
                var usedTeeth = complicationsAfterSurgeryEntity.map((e) => e.tooth).toList();

                //  medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.data.date, data: complicationsAfterSurgeryEntity));

                bloc.isInitialized = true;
                String? selectedName;

                return StatefulBuilder(builder: (context, _setState) {
                  return Column(
                    children: [
                      Wrap(
                        children: complicationsNames
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CIA_SecondaryButton(
                                  width: 130,
                                  icon: const Icon(Icons.add),
                                  label: e,
                                  onTab: () {
                                    selectedName = e;
                                    _setState(() {});
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 50,
                        child: Visibility(
                          visible: selectedName != null,
                          child: Row(
                            children: teeth
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CIA_SecondaryButton(
                                      width: 80,
                                      label: e.toString(),
                                      onTab: () {
                                        complicationsAfterSurgeryEntity = [
                                          ...complicationsAfterSurgeryEntity,
                                          ComplicationsAfterSurgeryEntity(
                                            patientId: widget.patientId,
                                            date: DateTime.now(),
                                            tooth: e,
                                            name: selectedName,
                                            operator: BasicNameIdObjectEntity(
                                              id: siteController.getUserId(),
                                              name: siteController.getUserName(),
                                            ),
                                            operatorId: siteController.getUserId(),
                                          )
                                        ];
                                        selectedName = null;
                                        _setState(() {});
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: complicationsAfterSurgeryEntity
                              .mapIndexed((i, e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "${i + 1}. Tooth: ${e.tooth} || ${e.name}")),
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
                                              onSave: () => setState(() => null),
                                              child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
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
                                              complicationsAfterSurgeryEntity.remove(e);
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
              if (state is ComplicationsBloc_UpdatingComplicationsAfterSurgeryState) {
                CustomLoader.show(context);
              } else {
                CustomLoader.hide();
                if (state is ComplicationsBloc_UpdatedComplicationsAfterSurgerySuccessfullyState) {
                  ShowSnackBar(context, isSuccess: true);
                  bloc.add(ComplicationsBloc_GetComplicationsAfterSurgeryEvent(id: widget.patientId));
                } else if (state is ComplicationsBloc_UpdatingComplicationsAfterSurgeryErrorState)
                  ShowSnackBar(context, isSuccess: false, message: state.message);
              }
            },
          ),
        );
      },
    );
  }
}
