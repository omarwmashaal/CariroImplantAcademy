import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/diagnosticProsthesis_StepWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesisWidget.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../../../Constants/Controllers.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';

class ProstheticTreatmentPage extends StatefulWidget {
  ProstheticTreatmentPage({Key? key, required this.patientId}) : super(key: key);
  int patientId;
  static String routeName = "ProstheticTreatment";
  static String routeNameClinic = "ClinicProstheticTreatment";
  static String routePath = ":id/ProstheticTreatment";

  @override
  State<ProstheticTreatmentPage> createState() => _PatientProstheticTreatmentState();
}

class _PatientProstheticTreatmentState extends State<ProstheticTreatmentPage> {
  List<BasicNameIdObjectEntity> diagnosticItems = [];
  List<ProstheticStepEntity> diagnosticSteps = [];
  List<ProstheticStepEntity> singleBridgeEntity = [];
  List<ProstheticStepEntity> fullArchEntity = [];
  late ProstheticBloc bloc;
  late SettingsBloc settingsBloc;
  late MedicalInfoShellBloc medicalInfoShellBloc;
  bool edit = false;

  @override
  void initState() {
    bloc = BlocProvider.of<ProstheticBloc>(context);
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    medicalInfoShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
    medicalInfoShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Prosthetic Treatment"));
    settingsBloc.add(SettingsBloc_GetProstheticItemsEvent(type: EnumProstheticType.Diagnostic));
    medicalInfoShellBloc.saveChanges = () {
      saveMethod();
    };

    super.initState();
  }

  saveMethod() {
    Future.delayed(Duration.zero, () async {
      try {
        if (fullArchEntity != null) bloc.add(ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisFullArchEvent(data: fullArchEntity!));
      } on Exception catch (e) {
        // print(e);
      }
      try {
        if (diagnosticSteps != null) bloc.add(ProstheticBloc_UpdatePatientProstheticTreatmentDiagnosticEvent(data: diagnosticSteps!));
      } on Exception catch (e) {
        // print(e);
      }
      try {
        if (singleBridgeEntity != null)
          bloc.add(ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeEvent(data: singleBridgeEntity!));
      } on Exception catch (e) {
        //print(e);
      }
    });
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LabRequestsBloc, LabRequestsBloc_States>(
      listener: (context, state) {
        if (state is LabRequestsBloc_CreatedLabRequestSuccessfullyState) dialogHelper.dismissAll(context);
      },
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TabBar(
                onTap: (value) {
                  if (value == 0) {
                    bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
                    currentPage = 0;
                  } else if (value == 1) {
                    bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent(id: widget.patientId));
                    currentPage = 1;
                  }
                  saveMethod();
                },
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Diagnostic",
                  ),
                  Tab(
                    text: "Final Prothesis",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                      bloc: medicalInfoShellBloc,
                      buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                      builder: (context, stateShell) {
                        return AbsorbPointer(
                            absorbing: () {
                              if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                edit = stateShell.edit;
                                return !edit;
                              } else {
                                return !edit;
                              }
                            }(),
                            child: BlocConsumer<ProstheticBloc, ProstheticBloc_States>(
                              listener: (context, state) {
                                print(state);
                                if (state is ProstheticBloc_UpdatedProstheticDiagnosticSuccessfullyState && currentPage == 0)
                                  bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
                              },
                              buildWhen: (previous, current) =>
                                  current is ProstheticBloc_LoadingDataState ||
                                  current is ProstheticBloc_DataLoadingErrorState ||
                                  current is ProstheticBloc_DiagnosticDataLoadedSuccessfullyState,
                              builder: (context, state) {
                                if (state is ProstheticBloc_LoadingDataState)
                                  return LoadingWidget();
                                else if (state is ProstheticBloc_DataLoadingErrorState)
                                  return BigErrorPageWidget(message: state.message);
                                else if (state is ProstheticBloc_DiagnosticDataLoadedSuccessfullyState) {
                                  diagnosticSteps = state.data;
                                  medicalInfoShellBloc.emit(MedicalInfoBlocChangeDateState(date: null, data: null, dontChange: false));

                                  return StatefulBuilder(
                                    builder: (context, _setState) {
                                      diagnosticSteps.sort(
                                        (a, b) {
                                          if (a.date != null && b.date != null) return a.date!.isBefore(b.date!) ? 0 : 1;
                                          return 0;
                                        },
                                      );
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BlocBuilder<SettingsBloc, SettingsBloc_States>(
                                            buildWhen: (previous, current) => current is SettingsBloc_LoadedProstheticItemsSuccessfullyState,
                                            builder: (context, state) {
                                              if (state is SettingsBloc_LoadedProstheticItemsSuccessfullyState) diagnosticItems = state.data;
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                    children: diagnosticItems
                                                        .map(
                                                          (e) => Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: CIA_SecondaryButton(
                                                              label: e.name ?? "",
                                                              icon: Icon(Icons.add),
                                                              onTab: () => _setState(
                                                                () => diagnosticSteps = [
                                                                  ...diagnosticSteps,
                                                                  ProstheticStepEntity(
                                                                    date: DateTime.now(),
                                                                    item: e,
                                                                    itemId: e.id,
                                                                    patientId: widget.patientId,
                                                                    operator: BasicNameIdObjectEntity(
                                                                      id: siteController.getUserId(),
                                                                      name: siteController.getUserName(),
                                                                    ),
                                                                    operatorId: siteController.getUserId(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList()),
                                              );
                                            },
                                          ),
                                          Expanded(
                                            child: ListView(
                                                children: diagnosticSteps
                                                    .mapIndexed((i, e) => DiagnosticProsthesis_StepWidget(
                                                          index: i + 1,
                                                          data: e,
                                                          onDelete: () => _setState(() => diagnosticSteps.remove(e)),
                                                        ))
                                                    .toList()),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else
                                  return Container();
                              },
                            ));
                      }),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 500,
                          child: TabBar(
                            onTap: (value) {
                              if (value == 0) {
                                bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent(id: widget.patientId));
                                currentPage = 1;
                              } else if (value == 1) {
                                bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisFullArchEvent(id: widget.patientId));
                                currentPage = 2;
                              }
                              saveMethod();
                            },
                            labelColor: Colors.black,
                            indicatorColor: Colors.orange,
                            tabs: [
                              Tab(
                                text: "Single & Bridge",
                              ),
                              Tab(
                                text: "Full Arch",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                                  bloc: medicalInfoShellBloc,
                                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                                  builder: (context, stateShell) {
                                    return BlocConsumer<ProstheticBloc, ProstheticBloc_States>(
                                      listener: (context, state) {
                                        print(state);
                                        if (state is ProstheticBloc_UpdatedProstheticSinlgeBridgeSuccessfullyState && currentPage == 1)
                                          bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent(id: widget.patientId));
                                      },
                                      buildWhen: (previous, current) =>
                                          current is ProstheticBloc_LoadingDataState ||
                                          current is ProstheticBloc_DataLoadingErrorState ||
                                          current is ProstheticBloc_SingleAndBridgeDataLoadedSuccessfullyState,
                                      builder: (context, state) {
                                        if (state is ProstheticBloc_LoadingDataState)
                                          return LoadingWidget();
                                        else if (state is ProstheticBloc_DataLoadingErrorState)
                                          return BigErrorPageWidget(message: state.message);
                                        else if (state is ProstheticBloc_SingleAndBridgeDataLoadedSuccessfullyState) {
                                          singleBridgeEntity = state.data;

                                          medicalInfoShellBloc.emit(MedicalInfoBlocChangeDateState(date: null, data: null, dontChange: false));

                                          return AbsorbPointer(
                                              absorbing: () {
                                                if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                                  edit = stateShell.edit;
                                                  return !edit;
                                                } else {
                                                  return !edit;
                                                }
                                              }(),
                                              child: FinalProsthesisStepWidget(
                                                patientId: widget.patientId,
                                                data: singleBridgeEntity,
                                              ));
                                        }
                                        return Container();
                                      },
                                    );
                                  }),
                              BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                                  bloc: medicalInfoShellBloc,
                                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                                  builder: (context, stateShell) {
                                    return BlocConsumer<ProstheticBloc, ProstheticBloc_States>(
                                      listener: (context, state) {
                                        if (state is ProstheticBloc_UpdatedProstheticFullArchSuccessfullyState && currentPage == 2)
                                          bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisFullArchEvent(id: widget.patientId));
                                      },
                                      buildWhen: (previous, current) =>
                                          current is ProstheticBloc_LoadingDataState ||
                                          current is ProstheticBloc_DataLoadingErrorState ||
                                          current is ProstheticBloc_FullArchDataLoadedSuccessfullyState,
                                      builder: (context, state) {
                                        if (state is ProstheticBloc_LoadingDataState)
                                          return LoadingWidget();
                                        else if (state is ProstheticBloc_DataLoadingErrorState)
                                          return BigErrorPageWidget(message: state.message);
                                        else if (state is ProstheticBloc_FullArchDataLoadedSuccessfullyState) {
                                          fullArchEntity = state.data;
                                          medicalInfoShellBloc.emit(MedicalInfoBlocChangeDateState(date: null, data: null, dontChange: false));

                                          return AbsorbPointer(
                                              absorbing: () {
                                                if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                                  edit = stateShell.edit;
                                                  return !edit;
                                                } else {
                                                  return !edit;
                                                  //return true;
                                                }
                                              }(),
                                              child: FinalProsthesisStepWidget(
                                                patientId: widget.patientId,
                                                data: fullArchEntity,
                                                fullArch: true,
                                              ));
                                        }
                                        return Container();
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (edit) {
      saveMethod();
    }

    super.dispose();
  }
}
