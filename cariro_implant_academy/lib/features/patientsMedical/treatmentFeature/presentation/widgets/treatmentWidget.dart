import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/postSurgeryWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/toothStatusWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/toothWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../../Models/MedicalModels/TreatmentPrices.dart';
import '../../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import '../../../../../../presentation/widgets/bigErrorPageWidget.dart';
import '../../../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../domain/entities/postSurgicalTreatmentEntity.dart';
import '../../domain/entities/treatmentPlanEntity.dart';
import '../bloc/treatmentBloc.dart';
import '../bloc/treatmentBloc_Events.dart';
import '../bloc/treatmentBloc_States.dart';

TreatmentPrices prices = TreatmentPrices();

enum _EnumSorting {
  SortDateAsc,
  SortDateDesc,
  GroupTeeth,
}

// TODO: Listen to models and higlight chips
class TreatmentWidget extends StatefulWidget {
  TreatmentWidget({
    Key? key,
    required this.patientId,
    this.surgical = false,
  }) : super(key: key);

  int patientId;
  bool surgical;
  _EnumSorting sorting = _EnumSorting.GroupTeeth;
  @override
  State<TreatmentWidget> createState() => _TreatmentWidgetState();
}

class _TreatmentWidgetState extends State<TreatmentWidget> {
  List<int> selectedTeeth = [];
  List<int> selectedTreatmentItemId = [];
  bool viewOnlyMode = false;
  late List<TreatmentDetailsEntity> treatmentDetails;
  late List<TreatmentItemEntity> treatmentItems;
  late TreatmentPlanEntity treatmentPlanEntity;
  bool editMode = false;
  late MedicalInfoShellBloc medicalShellBloc;
  late TreatmentBloc bloc;
  int totalPrice = 0;
  // TreatmentPricesEntity prices = TreatmentPricesEntity();

  BasicNameIdObjectEntity? tempCandidate;
  BasicNameIdObjectEntity? tempSuperVisor;
  int? tempCandidateBatch;

  save() {
    if (medicalShellBloc.allowEdit) {
      bloc.add(TreatmentBloc_SaveTreatmentDetailsEvent(
        id: widget.patientId,
        data: treatmentDetails,
        generalData: treatmentPlanEntity,
      ));
    }
  }

  @override
  void dispose() {
    save();
    super.dispose();
  }

  @override
  void initState() {
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc = BlocProvider.of<TreatmentBloc>(context);
    bloc.add(TreatmentBloc_GetTreatmentPlanDataEvent(id: widget.patientId));
    //bloc.add(TreatmentBloc_GetTreatmentPrices());
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: widget.surgical ? "Surgical Treatment" : "Treatment Plan"));
    medicalShellBloc.saveChanges = () => save();
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
                bloc.add(TreatmentBloc_GetTreatmentPlanDataEvent(id: widget.patientId));
                ShowSnackBar(context, isSuccess: true);
              } else if (state is TreatmentBloc_SavingTreatmentDataErrorState) {
                ShowSnackBar(context, isSuccess: false, message: state.message);
              } else if (state is TreatmentBloc_ChangedViewState) {
                viewOnlyMode = !state.edit;
                if (viewOnlyMode) totalPrice = state.total;
              } else if (state is TreatmentBloc_ConsumedItemSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true, message: state.message);
              } else if (state is TreatmentBloc_ConsumeItemErrorState) {
                ShowSnackBar(context, isSuccess: false, message: state.message);
              } else if (state is TreatmentBloc_UpdatedToothState) {
                selectedTreatmentItemId.clear();
                selectedTeeth.clear();
                bloc.emit(TreatmentBloc_SelectedStatusState());
                bloc.emit(TreatmentBloc_ShowTickState(showTick: false));
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
              if (state is TreatmentBloc_AcceptingChangesState || state is TreatmentBloc_SavingTreatmentDataState) {
                CustomLoader.show(context);
              } else
                CustomLoader.hide();
            },
            buildWhen: (previous, current) =>
                current is TreatmentBloc_LoadingTreatmentDataState ||
                current is TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState ||
                current is TreatmentBloc_LoadingTreatmentDataErrorState,
            builder: (context, state) {
              if (state is TreatmentBloc_LoadingTreatmentDataState)
                return LoadingWidget();
              else if (state is TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState) {
                treatmentDetails = state.details;
                treatmentPlanEntity = state.data;
                treatmentItems = state.treatmentItems;
                medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: treatmentPlanEntity.date, data: treatmentPlanEntity));

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
                          Column(
                            children: [
                              CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) async {
                                  if (item == "View Only Mode") {
                                    bloc.add(TreatmentBloc_SwitchEditAndSummaryViewsEvent(data: treatmentDetails));
                                  }
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "View Only Mode", borderColor: Colors.black, round: false),
                                ],
                              ),
                              SizedBox(height: 10),
                              CIA_CheckBoxWidget(
                                text: "Clearance Upper",
                                value: treatmentPlanEntity?.clearanceUpper ?? false,
                                onChange: (value) => treatmentPlanEntity?.clearanceUpper = value,
                              ),
                              SizedBox(height: 10),
                              CIA_CheckBoxWidget(
                                text: "Clearance Lower",
                                value: treatmentPlanEntity?.clearanceLower ?? false,
                                onChange: (value) => treatmentPlanEntity?.clearanceLower = value,
                              )
                            ],
                          )
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
                                  if (treatmentItems.firstWhere((element) => element.id == int.parse(item)).name == "Scaling") {
                                    selectedTreatmentItemId = [int.parse(item)];
                                    selectedTeeth = [0];
                                    bloc.emit(TreatmentBloc_ShowTickState(showTick: true));
                                  }
                                },
                                onChangeList: (selectedItems) {
                                  if (selectedTeeth.isEmpty) {
                                    selectedTreatmentItemId.clear();
                                    bloc.emit(TreatmentBloc_SelectedStatusState());
                                  } else {
                                    selectedTreatmentItemId = selectedItems.map((e) => int.parse(e)).toList();

                                    bloc.emit(TreatmentBloc_ShowTickState(showTick: true));
                                  }
                                },
                                labels: treatmentItems
                                    .map(
                                      (e) => CIA_MultiSelectChipWidgeModel(
                                        label: e.name ?? "",
                                        borderColor: e.isImplant() ? Colors.orange : null,
                                        value: e.id?.toString() ?? "0",
                                      ),
                                    )
                                    .toList()

                                //  [
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Simple Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Immediate Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Guided Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Expansion With Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Splitting With Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "GBR With Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Open Sinus With Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Closed Sinus With Implant",
                                //     borderColor: Colors.orange,
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Expansion Without Implant",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Splitting Without Implant",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "GBR Without Implant",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Open Sinus Without Implant",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Closed Sinus Without Implant",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Extraction",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Restoration",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Root Canal Treatment",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Pontic",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Scaling",
                                //   ),
                                //   CIA_MultiSelectChipWidgeModel(
                                //     label: "Crown",
                                //   ),
                                // ]

                                );
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
                                  CIA_GestureWidget(
                                    onTap: () {
                                      bloc.add(TreatmentBloc_UpdateTeethStatusEvent(
                                        teethData: treatmentDetails,
                                        selectedTreatmentItemId: selectedTreatmentItemId,
                                        selectedTeeth: selectedTeeth,
                                        patientId: widget.patientId,
                                        isSurgical: widget.surgical,
                                        patientsDoctor: treatmentPlanEntity.doctor,
                                      ));
                                    },
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  CIA_GestureWidget(
                                    onTap: () {
                                      selectedTreatmentItemId.clear();
                                      selectedTreatmentItemId.clear();
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
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          FormTextValueWidget(text: "Sort By"),
                          SizedBox(width: 10),
                          widget.sorting == _EnumSorting.GroupTeeth
                              ? CIA_PrimaryButton(
                                  label: "Teeth",
                                  onTab: () => null,
                                  isLong: true,
                                )
                              : CIA_SecondaryButton(
                                  label: "Teeth",
                                  onTab: () => setState(() => widget.sorting = _EnumSorting.GroupTeeth),
                                ),
                          SizedBox(width: 10),
                          widget.sorting == _EnumSorting.SortDateAsc
                              ? CIA_PrimaryButton(
                                  label: "Date Asscending",
                                  onTab: () => null,
                                  icon: Icon(Icons.arrow_upward),
                                  isLong: true,
                                )
                              : CIA_SecondaryButton(
                                  label: "Date Asscending",
                                  onTab: () => setState(() => widget.sorting = _EnumSorting.SortDateAsc),
                                  icon: Icon(Icons.arrow_upward)),
                          SizedBox(width: 10),
                          widget.sorting == _EnumSorting.SortDateDesc
                              ? CIA_PrimaryButton(
                                  label: "Date Descending",
                                  onTab: () => null,
                                  isLong: true,
                                  icon: Icon(Icons.arrow_downward),
                                )
                              : CIA_SecondaryButton(
                                  label: "Date Descending",
                                  onTab: () => setState(() => widget.sorting = _EnumSorting.SortDateDesc),
                                  icon: Icon(Icons.arrow_downward)),
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentBloc_UpdatedToothState || current is TreatmentBloc_ChangedViewState,
                          builder: (context, state) {
                            if (state is TreatmentBloc_ChangedViewState) {
                              if (!state.edit) totalPrice = state.total;
                            }
                            if (state is TreatmentBloc_UpdatedToothState) treatmentDetails = state.data;
                            return ListView(
                              children: _buildTeethWidgets(
                                stateShell,
                                sort: widget.sorting,
                              ),
                            );
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

  _buildTeethWidgets(MedicalInfoShellBloc_State stateShell, {required _EnumSorting sort}) {
    List<Widget> returnValue = [];

    if (sort != _EnumSorting.GroupTeeth) {
      if (sort == _EnumSorting.SortDateDesc)
        treatmentDetails.sort((a, b) => (b.date?.millisecondsSinceEpoch ?? 0).compareTo(a.date?.millisecondsSinceEpoch ?? 0));
      else
        treatmentDetails.sort((a, b) => (a.date?.millisecondsSinceEpoch ?? 0).compareTo(b.date?.millisecondsSinceEpoch ?? 0));

      for (var procedure in treatmentDetails) {
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
            child: ToothStatusWidget(
              bloc: bloc,
              isSurgical: widget.surgical,
              viewOnlyMode: viewOnlyMode,
              acceptChanges: (request) => bloc.add(TreatmentBloc_AcceptChangesEvent(requestChangeEntity: request, patientId: widget.patientId)),
              patientId: widget.patientId,
              data: procedure,
              onDelete: () {
                bloc.emit(TreatmentBloc_UpdatedToothState(data: treatmentDetails));
              },
            ),
          ),
        );
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
      }
    } else {
      var teeth = treatmentDetails.map((e) => e.tooth).toSet().toList();
      teeth.sort();
      for (var tooth in teeth) {
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
              bloc: bloc,
              viewOnlyMode: viewOnlyMode,
              key: GlobalKey(),
              patientId: widget.patientId,
              toothID: tooth!,
              isSurgical: widget.surgical,
              acceptChanges: (request) => bloc.add(
                TreatmentBloc_AcceptChangesEvent(requestChangeEntity: request, patientId: widget.patientId),
              ),
              teethData: treatmentDetails,
              onChange: () => bloc.emit(TreatmentBloc_UpdatedToothState(
                data: treatmentDetails,
              )),
            ),
          ),
        );
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
      }
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
