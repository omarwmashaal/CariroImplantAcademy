import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/postSurgeryWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/toothWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Models/MedicalModels/TreatmentPrices.dart';
import '../../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import '../../../../../../presentation/widgets/bigErrorPageWidget.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../domain/entities/surgicalTreatmentEntity.dart';
import '../../domain/entities/treatmentPlanEntity.dart';
import '../bloc/treatmentBloc.dart';
import '../bloc/treatmentBloc_Events.dart';
import '../bloc/treatmentBloc_States.dart';

TreatmentPrices prices = TreatmentPrices();

// TODO: Listen to models and higlight chips
class TreatmentWidget extends StatefulWidget {
  TreatmentWidget({
    Key? key,
    required this.patientId,
    this.surgical = false,
  }) : super(key: key);

  int patientId;
  bool surgical;

  @override
  State<TreatmentWidget> createState() => _TreatmentWidgetState();
}

class _TreatmentWidgetState extends State<TreatmentWidget> {
  List<int> selectedTeeth = [];
  List<String> selectedStatus = [];
  bool viewOnlyMode = false;
  late TreatmentPlanEntity treatmentPlanEntity;
  late SurgicalTreatmentEntity surgicalTreatmentEntity;
  bool editMode = false;
  late MedicalInfoShellBloc medicalShellBloc;
  late TreatmentBloc bloc;
  int totalPrice = 0;
  TreatmentPricesEntity prices = TreatmentPricesEntity();

  @override
  void dispose() {
    if (medicalShellBloc.allowEdit) {
      if (widget.surgical) {
        bloc.add(TreatmentBloc_SaveSurgicalTreatmentDataEvent(id: widget.patientId, data: surgicalTreatmentEntity));
      } else {
        bloc.add(TreatmentBloc_SaveTreatmentPlanDataEvent(id: widget.patientId, data: treatmentPlanEntity.treatmentPlan ?? []));
      }
    }
    super.dispose();
  }

  @override
  void initState() {
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc = BlocProvider.of<TreatmentBloc>(context);
    if (widget.surgical)
      bloc.add(TreatmentBloc_GetSurgicalTreatmentDataEvent(id: widget.patientId));
    else
      bloc.add(TreatmentBloc_GetTreatmentPlanDataEvent(id: widget.patientId));
    bloc.add(TreatmentBloc_GetTreatmentPrices());
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: widget.surgical ? "Surgical Treatment" : "Treatment Plan"));
    medicalShellBloc.saveChanges = () {
      if (widget.surgical) {
        bloc.add(TreatmentBloc_SaveSurgicalTreatmentDataEvent(id: widget.patientId, data: surgicalTreatmentEntity));
      } else {
        bloc.add(TreatmentBloc_SaveTreatmentPlanDataEvent(id: widget.patientId, data: treatmentPlanEntity.treatmentPlan ?? []));
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
        bloc: medicalShellBloc,
        buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
        builder: (context, stateShell) {
          return BlocConsumer<TreatmentBloc, TreatmentBloc_States>(
            listener: (context, state) {
              if (state is TreatmentBloc_SavedTreatmentDataSuccessfullyState) {
                if (widget.surgical)
                  bloc.add(TreatmentBloc_GetSurgicalTreatmentDataEvent(id: widget.patientId));
                else
                  bloc.add(TreatmentBloc_GetTreatmentPlanDataEvent(id: widget.patientId));
              } else if (state is TreatmentBloc_ChangedViewState) {
                viewOnlyMode = !state.edit;
                if (viewOnlyMode) totalPrice = state.total;
              } else if (state is TreatmentBloc_LoadedTreatmentPricesState)
                prices = state.prices;
              else if (state is TreatmentBloc_ConsumedItemSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true, message: state.message);
              } else if (state is TreatmentBloc_ConsumeItemErrorState) {
                ShowSnackBar(context, isSuccess: false, message: state.message);
              } else if (state is TreatmentBloc_UpdatedToothState) {
                selectedStatus.clear();
                selectedTeeth.clear();
                bloc.emit(TreatmentBloc_SelectedStatusState());
                bloc.emit(TreatmentBloc_ShowTickState(showTick: false));
              } else if (state is TreatmentBloc_ShowPostSurgeryState) {
                int tempScrews = (surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber ?? 0);
                int? membraneSizeId = surgicalTreatmentEntity.openSinusLift_Membrane != null ? surgicalTreatmentEntity.openSinusLift_Membrane!.id : null;
                int tacsNumber = surgicalTreatmentEntity.openSinusLiftTacsNumber ?? 0;
                int tacCompany = surgicalTreatmentEntity.openSinusLift_TacsCompanyID ?? 0;
                CIA_ShowPopUp(
                  width: 1000,
                  height: 600,
                  context: context,
                  onSave: () async {
                    if (tempScrews != (surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber ?? 0)) {
                      if (((surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber ?? 0)) > tempScrews) {
                        await CIA_ShowPopUpYesNo(
                            title: "Consume ${((surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber ?? 0)) - tempScrews} Screws?",
                            context: context,
                            onSave: () {
                              bloc.add(
                                TreatmentBloc_ConsumeItemByNameEvent(
                                  name: "Screws",
                                  count: ((surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber ?? 0) - tempScrews),
                                ),
                              );
                            });
                      }
                    }
                    if (tacCompany != surgicalTreatmentEntity.openSinusLift_TacsCompanyID) tacsNumber = 0;
                    if (tacsNumber != (surgicalTreatmentEntity.openSinusLiftTacsNumber ?? 0)) {
                      if ((surgicalTreatmentEntity.openSinusLiftTacsNumber ?? 0) > tacsNumber) {
                        await CIA_ShowPopUpYesNo(
                            title: "Consume ${((surgicalTreatmentEntity.openSinusLiftTacsNumber ?? 0)) - tacsNumber} Tacs?",
                            context: context,
                            onSave: () async {
                              bloc.add(TreatmentBloc_ConsumeItemByIdEvent(
                                  id: surgicalTreatmentEntity.openSinusLift_TacsCompanyID!,
                                  count: ((surgicalTreatmentEntity.openSinusLiftTacsNumber ?? 0)) - tacsNumber));
                            });
                      }
                    }

                    if (membraneSizeId != surgicalTreatmentEntity.openSinusLift_MembraneID) {
                      if (surgicalTreatmentEntity.openSinusLift_MembraneID != null) {
                        await CIA_ShowPopUpYesNo(
                            title: "Consume 1 ${surgicalTreatmentEntity.openSinusLift_Membrane!.size ?? ""} Membrane?",
                            context: context,
                            onSave: () {
                              bloc.add(TreatmentBloc_ConsumeItemByIdEvent(id: surgicalTreatmentEntity.openSinusLift_MembraneID!, count: 1));
                            });
                      }
                    }
                  },
                  child: PostSurgeryWidget(surgicalTreatmentEntity: surgicalTreatmentEntity),
                );
              } else if (state is TreatmentBloc_AcceptingChangesErrorState) {
                ShowSnackBar(context, isSuccess: false, message: state.message);
              } else if (state is TreatmentBloc_AcceptedChangesSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true);

                if (state.requestChangeEntity?.requestEnum == RequestChangeEnum.ImplantChange) {
                  bloc.add(TreatmentBloc_ConsumeImplantEvent(id: state.requestChangeEntity!.dataId!));
                } else {
                  bloc.add(TreatmentBloc_ConsumeItemByIdEvent(id: state.requestChangeEntity!.dataId!, count: 1));
                }
              }
              if (state is TreatmentBloc_AcceptingChangesState) {
                CustomLoader.show(context);
              } else
                CustomLoader.hide();
            },
            buildWhen: (previous, current) =>
                current is TreatmentBloc_LoadingTreatmentDataState ||
                current is TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState ||
                current is TreatmentBloc_LoadedSurgicalTreatmentDataSuccessfullyState ||
                current is TreatmentBloc_LoadingTreatmentDataErrorState,
            builder: (context, state) {
              if (state is TreatmentBloc_LoadingTreatmentDataState)
                return LoadingWidget();
              else if (state is TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState || state is TreatmentBloc_LoadedSurgicalTreatmentDataSuccessfullyState) {
                if (state is TreatmentBloc_LoadedSurgicalTreatmentDataSuccessfullyState) {
                  surgicalTreatmentEntity = state.data;
                  medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.data.date, data: surgicalTreatmentEntity));
                } else if (state is TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState) {
                  treatmentPlanEntity = state.data;
                  medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.data.date, data: treatmentPlanEntity));
                }
                return FocusTraversalGroup(
                  policy: OrderedTraversalPolicy(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AbsorbPointer(
                              absorbing: () {
                                if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                  editMode = stateShell.edit;
                                  return !editMode;
                                } else {
                                  editMode = false;
                                  return true;
                                }
                              }(),
                              child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                                buildWhen: (previous, current) => current is TreatmentBloc_SelectedStatusState,
                                builder: (context, state) {
                                  return CIA_TeethChart(
                                    onChange: (selectedTeethList) {
                                      selectedTeeth = selectedTeethList;
                                      // bloc.emit(TreatmentPlanBloc_TeethSelectedState());
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          CIA_MultiSelectChipWidget(
                            onChange: (item, isSelected) async {
                              if (item == "View Only Mode") {
                                bloc.add(TreatmentBloc_SwitchEditAndSummaryViewsEvent(data: treatmentPlanEntity.treatmentPlan ?? []));
                              }
                              if (item == "Post Surgery") {
                                bloc.emit(TreatmentBloc_ShowPostSurgeryState());
                              }
                            },
                            labels: widget.surgical
                                ? [
                                    CIA_MultiSelectChipWidgeModel(
                                        label: "Post Surgery", borderColor: Colors.black, round: false, isSelected: false, isButton: true),
                                  ]
                                : [
                                    CIA_MultiSelectChipWidgeModel(label: "View Only Mode", borderColor: Colors.black, round: false),
                                  ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      AbsorbPointer(
                        absorbing: () {
                          if (stateShell is MedicalInfoBlocChangeViewEditState) {
                            editMode = stateShell.edit;
                            return !editMode;
                          } else {
                            editMode = false;
                            return true;
                          }
                        }(),
                        child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentBloc_SelectedStatusState,
                          builder: (context, state) {
                            return CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                onChange: (item, isSelected) {
                                  if (item == "Scaling") {
                                    selectedStatus = [item];
                                    selectedTeeth = [0];
                                    bloc.emit(TreatmentBloc_ShowTickState(showTick: true));
                                  }
                                },
                                onChangeList: (selectedItems) {
                                   if (selectedTeeth.isEmpty) {
                                    selectedStatus.clear();
                                    bloc.emit(TreatmentBloc_SelectedStatusState());
                                  } else {
                                    selectedStatus = selectedItems;

                                    bloc.emit(TreatmentBloc_ShowTickState(showTick: true));
                                  }
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Simple Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Immediate Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Guided Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Expansion With Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Splitting With Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "GBR With Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Open Sinus With Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Closed Sinus With Implant",
                                    borderColor: Colors.orange,
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Expansion Without Implant",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Splitting Without Implant",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "GBR Without Implant",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Open Sinus Without Implant",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Closed Sinus Without Implant",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Extraction",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Restoration",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Root Canal Treatment",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Pontic",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Scaling",
                                  ),
                                  CIA_MultiSelectChipWidgeModel(
                                    label: "Crown",
                                  ),
                                ]);
                          },
                        ),
                      ),
                      AbsorbPointer(
                        absorbing: () {
                          if (stateShell is MedicalInfoBlocChangeViewEditState) {
                            editMode = stateShell.edit;
                            return !editMode;
                          } else {
                            editMode = false;
                            return true;
                          }
                        }(),
                        child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentBloc_ShowTickState,
                          builder: (context, state) {
                            bool showTick = false;
                            if (state is TreatmentBloc_ShowTickState) {
                              showTick = state.showTick;
                            }
                            return Visibility(
                              visible: showTick,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      bloc.add(TreatmentBloc_UpdateTeethStatusEvent(
                                        teethData: widget.surgical ? surgicalTreatmentEntity.surgicalTreatment ?? [] : treatmentPlanEntity.treatmentPlan ?? [],
                                        selectedStatus: selectedStatus,
                                        selectedTeeth: selectedTeeth,
                                        patientId: widget.patientId,
                                        isSurgical: widget.surgical,
                                        patientsDoctor: widget.surgical ? surgicalTreatmentEntity.doctor : treatmentPlanEntity.doctor,
                                      ));
                                    },
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      selectedStatus.clear();
                                      selectedStatus.clear();
                                      bloc.emit(TreatmentBloc_SelectedStatusState());
                                    },
                                    child: Icon(
                                      Icons.highlight_remove,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentBloc_UpdatedToothState || current is TreatmentBloc_ChangedViewState,
                          builder: (context, state) {
                            if (state is TreatmentBloc_ChangedViewState) {
                              if (!state.edit) totalPrice = state.total;
                            }
                            if (state is TreatmentBloc_UpdatedToothState) if (widget.surgical) {
                              surgicalTreatmentEntity.surgicalTreatment = state.data;
                            } else {
                              treatmentPlanEntity.treatmentPlan = state.data;
                            }
                            return ListView(children: _buildTeethWidgets(stateShell));
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is TreatmentBloc_LoadingTreatmentDataErrorState)
                return BigErrorPageWidget(message: state.message);
              else
                return Container();
            },
          );
        },
      ),
    );
  }

  _buildTeethWidgets(MedicalInfoShellBloc_State stateShell) {
    List<Widget> returnValue = [];
    for (var model in (widget.surgical ? surgicalTreatmentEntity.surgicalTreatment : treatmentPlanEntity.treatmentPlan) ?? []) {
      returnValue.add(
        AbsorbPointer(
          absorbing: () {
            if (stateShell is MedicalInfoBlocChangeViewEditState) {
              editMode = stateShell.edit;
              return !editMode;
            } else {
              editMode = false;
              return true;
            }
          }(),
          child: ToothWidget(
            viewOnlyMode: viewOnlyMode,
            key: GlobalKey(),
            patientId: widget.patientId,
            toothID: model!.tooth!,
            isSurgical: widget.surgical,
            prices: prices,
            acceptChanges: (request) => bloc.add(
              TreatmentBloc_AcceptChangesEvent(requestChangeEntity: request, patientId: widget.patientId, surgicalTreatmentEntity: surgicalTreatmentEntity),
            ),
            teethData: widget.surgical ? surgicalTreatmentEntity.surgicalTreatment ?? [] : treatmentPlanEntity.treatmentPlan ?? [],
            onChange: () => bloc.emit(TreatmentBloc_UpdatedToothState(
                data: widget.surgical ? surgicalTreatmentEntity.surgicalTreatment ?? [] : treatmentPlanEntity.treatmentPlan ?? [])),
          ),
        ),
      );
      returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
    }
    if (viewOnlyMode) {
      returnValue.add(SizedBox(height: 20));
      returnValue.add(Row(
        children: [
          Expanded(
            child: Text(
              "Total",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(
            child: Text(
              "$totalPrice EGP",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));
      returnValue.add(SizedBox(height: 20));
    }

    return returnValue;
  }
}
