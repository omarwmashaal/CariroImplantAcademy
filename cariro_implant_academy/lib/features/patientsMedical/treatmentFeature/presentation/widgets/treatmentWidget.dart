import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/SurgicalTreatmentModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_IncrementalTextField.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethTreatmentWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/toothWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../../../Models/MedicalModels/TreatmentPrices.dart';
import '../../../../../../Widgets/CIA_MedicalAbsrobPointerWidget.dart';
import '../../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import '../../../../../../presentation/widgets/bigErrorPageWidget.dart';
import '../../domain/entities/treatmentPlanEntity.dart';
import '../bloc/treatmentPlanBloc.dart';
import '../bloc/treatmentPlanBloc_Events.dart';
import '../bloc/treatmentPlanBloc_States.dart';

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
  bool editMode = false;
  late MedicalInfoShellBloc medicalShellBloc;
  late TreatmentPlanBloc bloc;
  int totalPrice = 0;
  TreatmentPricesEntity prices = TreatmentPricesEntity();

  @override
  void dispose() {
    if(medicalShellBloc.allowEdit){
      if (widget.surgical) {
      } else {
        bloc.add(TreatmentPlanBloc_SaveDataEvent(id: widget.patientId, data: treatmentPlanEntity.treatmentPlan ?? []));
      }
    }
  }

  @override
  void initState() {
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc = BlocProvider.of<TreatmentPlanBloc>(context);
    bloc.add(TreatmentPlanBloc_GetDataEvent(id: widget.patientId));
    bloc.add(TreatmentPlanBloc_GetTreatmentPrices());
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
        bloc: medicalShellBloc,
        buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
        builder: (context, stateShell) {
          return BlocConsumer<TreatmentPlanBloc, TreatmentPlanBloc_States>(
            listener: (context, state) {
              if (state is TreatmentPlanBloc_ChangedViewState) {
                viewOnlyMode = !state.edit;
                if (viewOnlyMode) totalPrice = state.total;
              } else if (state is TreatmentPlanBloc_LoadedTreatmentPricesState)
                prices = state.prices;
              else if (state is TreatmentPlanBloc_UpdatedToothState) {
                selectedStatus.clear();
                selectedTeeth.clear();
                bloc.emit(TreatmentPlanBloc_SelectedStatusState());
                bloc.emit(TreatmentPlanBloc_ShowTickState(showTick: false));
              }
            },
            buildWhen: (previous, current) =>
                current is TreatmentPlanBloc_LoadingTreatmentPlanDataState || current is TreatmentPlanBloc_LoadedTreatmentPlanDataSuccessfullyState,
            builder: (context, state) {
              if (state is TreatmentPlanBloc_LoadingTreatmentPlanDataState)
                return LoadingWidget();
              else if (state is TreatmentPlanBloc_LoadedTreatmentPlanDataSuccessfullyState) {
                treatmentPlanEntity = state.data;
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
                              child: BlocBuilder<TreatmentPlanBloc, TreatmentPlanBloc_States>(
                                buildWhen: (previous, current) => current is TreatmentPlanBloc_SelectedStatusState,
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
                                bloc.add(TreatmentPlanBloc_SwitchEditAndSummaryViewsEvent(data: treatmentPlanEntity.treatmentPlan ?? []));
                              }
                              /* if (item == "Post Surgery") {
                                int tempScrews = (surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? 0);
                                int? membraneSizeId =
                                surgicalTreatmentModel.openSinusLift_Membrane != null ? surgicalTreatmentModel.openSinusLift_Membrane!.id : null;
                                int tacsNumber = surgicalTreatmentModel.openSinusLiftTacsNumber ?? 0;
                                int tacCompany = surgicalTreatmentModel.openSinusLift_TacsCompanyID ?? 0;

                                await CIA_ShowPopUp(
                                  width: 1000,
                                  height: 600,
                                  context: context,
                                  onSave: () async {
                                    if (tempScrews != (surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? 0)) {
                                      if (((surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? 0)) > tempScrews) {
                                        await CIA_ShowPopUpYesNo(
                                            title:
                                            "Consume ${((surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? 0)) - tempScrews} Screws?",
                                            context: context,
                                            onSave: () async {
                                              var t = await StockAPI.GetStockByName("Screws");
                                              if (t.statusCode == 200) {
                                                var y = await StockAPI.ConsumeItem((t.result as StockModel).id!,
                                                    ((surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? 0)) - tempScrews);
                                                ShowSnackBar(context,
                                                    isSuccess: y.statusCode == 200,
                                                    message: y.statusCode == 200 ? "Screws consumed" : "Failed to consume screws");
                                              }
                                            });
                                      }
                                    }
                                    if (tacCompany != surgicalTreatmentModel.openSinusLift_TacsCompanyID) tacsNumber = 0;
                                    if (tacsNumber != (surgicalTreatmentModel.openSinusLiftTacsNumber ?? 0)) {
                                      if ((surgicalTreatmentModel.openSinusLiftTacsNumber ?? 0) > tacsNumber) {
                                        await CIA_ShowPopUpYesNo(
                                            title: "Consume ${((surgicalTreatmentModel.openSinusLiftTacsNumber ?? 0)) - tacsNumber} Tacs?",
                                            context: context,
                                            onSave: () async {
                                              var y = await StockAPI.ConsumeItem((surgicalTreatmentModel.openSinusLift_TacsCompanyID)!,
                                                  ((surgicalTreatmentModel.openSinusLiftTacsNumber ?? 0)) - tacsNumber);
                                              ShowSnackBar(context,
                                                  isSuccess: y.statusCode == 200,
                                                  message: y.statusCode == 200 ? "Tacs consumed" : "Failed to consume tacs");
                                            });
                                      }
                                    }

                                    if (membraneSizeId != surgicalTreatmentModel.openSinusLift_MembraneID) {
                                      if (surgicalTreatmentModel.openSinusLift_MembraneID != null) {
                                        await CIA_ShowPopUpYesNo(
                                            title: "Consume 1 ${surgicalTreatmentModel.openSinusLift_Membrane!.size ?? ""} Membrane?",
                                            context: context,
                                            onSave: () async {
                                              var y = await StockAPI.ConsumeItem((surgicalTreatmentModel.openSinusLift_MembraneID)!, 1);
                                              ShowSnackBar(context,
                                                  isSuccess: y.statusCode == 200,
                                                  message: y.statusCode == 200 ? "Membrane consumed" : "Failed to consume Membrane");
                                            });
                                      }
                                    }
                                  },
                                  child: _PostSurgeryWidget(),
                                );
                              }*/
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
                        child: BlocBuilder<TreatmentPlanBloc, TreatmentPlanBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentPlanBloc_SelectedStatusState,
                          builder: (context, state) {
                            return CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                onChangeList: (selectedItems) {
                                  if (selectedTeeth.isEmpty) {
                                    selectedStatus.clear();
                                    bloc.emit(TreatmentPlanBloc_SelectedStatusState());
                                  } else {
                                    selectedStatus = selectedItems;

                                    bloc.emit(TreatmentPlanBloc_ShowTickState(showTick: true));
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
                        child: BlocBuilder<TreatmentPlanBloc, TreatmentPlanBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentPlanBloc_ShowTickState,
                          builder: (context, state) {
                            bool showTick = false;
                            if (state is TreatmentPlanBloc_ShowTickState) {
                              showTick = state.showTick;
                            }
                            return Visibility(
                              visible: showTick,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      bloc.add(TreatmentPlanBloc_UpdateTeethStatusEvent(
                                        teethData: treatmentPlanEntity.treatmentPlan ?? [],
                                        selectedStatus: selectedStatus,
                                        selectedTeeth: selectedTeeth,
                                        patientId: widget.patientId,
                                        isSurgical: widget.surgical,
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
                                      bloc.emit(TreatmentPlanBloc_SelectedStatusState());
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
                        child: BlocBuilder<TreatmentPlanBloc, TreatmentPlanBloc_States>(
                          buildWhen: (previous, current) => current is TreatmentPlanBloc_UpdatedToothState || current is TreatmentPlanBloc_ChangedViewState,
                          builder: (context, state) {
                            if (state is TreatmentPlanBloc_ChangedViewState) {
                              if (!state.edit) totalPrice = state.total;
                            }
                            if (state is TreatmentPlanBloc_UpdatedToothState) treatmentPlanEntity.treatmentPlan = state.data;
                            return ListView(children: _buildTeethWidgets(stateShell));
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is TreatmentPlanBloc_LoadingTreatmentPlanDataErrorState)
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
    for (var model in treatmentPlanEntity.treatmentPlan ?? []) {
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
          child: new ToothWidget(
            viewOnlyMode: viewOnlyMode,
            key: GlobalKey(),
            toothID: model!.tooth!,
            isSurgical: widget.surgical,
            prices: prices,
            teethData: treatmentPlanEntity.treatmentPlan ?? [],
            onChange: () => bloc.emit(TreatmentPlanBloc_UpdatedToothState(data: treatmentPlanEntity.treatmentPlan ?? [])), //setState(() {}),
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

class _PostSurgeryWidget extends StatefulWidget {
  const _PostSurgeryWidget({Key? key}) : super(key: key);

  @override
  State<_PostSurgeryWidget> createState() => _PostSurgeryWidgetState();
}

class _PostSurgeryWidgetState extends State<_PostSurgeryWidget> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(); /*
    return DefaultTabController(
        length: 4,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Suture & Temporization & X-ray",
                  ),
                  Tab(
                    text: "Guided Bone Regeneration",
                  ),
                  Tab(
                    text: "Open Sinus Lift",
                  ),
                  Tab(
                    text: "Soft Tissue Graft",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CIA_MedicalAbsrobPointerWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Suture Size")),
                            Expanded(
                              flex: 4,
                              child: CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) {
                                  switch (item) {
                                    case "3-0":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize30 = isSelected;
                                      break;
                                    case "4-0":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize40 = isSelected;
                                      break;
                                    case "5-0":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize50 = isSelected;
                                      break;
                                    case "6-0":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize60 = isSelected;
                                      break;
                                    case "7-0":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize70 = isSelected;
                                      break;
                                    case "Implant Subcrestal":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = isSelected;
                                      break;
                                  }
                                  setState(() {});
                                },
                                singleSelect: true,
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "3-0", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize30!),
                                  CIA_MultiSelectChipWidgeModel(label: "4-0", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize40!),
                                  CIA_MultiSelectChipWidgeModel(label: "5-0", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize50!),
                                  CIA_MultiSelectChipWidgeModel(label: "6-0", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize60!),
                                  CIA_MultiSelectChipWidgeModel(label: "7-0", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSize70!),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Implant Subcrestal",
                                      isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal!),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Suture Material")),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_MultiSelectChipWidget(
                                      onChange: (item, isSelected) {
                                        switch (item) {
                                          case "Vicryl":
                                            surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialVicryl = isSelected;
                                            break;
                                          case "Proline":
                                            surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialProline = isSelected;
                                            break;
                                          case "X-ray":
                                            surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialXRay = isSelected;
                                            break;
                                        }
                                        setState(() {});
                                      },
                                      singleSelect: true,
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Vicryl", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialVicryl!),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Proline", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialProline!),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "X-ray", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialXRay!),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Suture Technique",
                                      onChange: (value) {
                                        surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialSutureTechnique = value;
                                      },
                                      controller: TextEditingController(
                                        text: surgicalTreatmentModel.sutureAndTemporizationAndXRayMaterialSutureTechnique ?? "",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Temporary")),
                            Expanded(
                              flex: 4,
                              child: CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) {
                                  switch (item) {
                                    case "Healing Collar":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryHealingCollar = isSelected;
                                      break;
                                    case "Customized Healling Collar":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar = isSelected;
                                      break;
                                    case "Crown":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryCrown = isSelected;
                                      break;
                                    case "Maryland Bridge":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryMarylandBridge = isSelected;
                                      break;
                                    case "Bridge on teeth":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = isSelected;
                                      break;
                                    case "Denture with glass fiber":
                                      surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = isSelected;
                                      break;
                                  }
                                  setState(() {});
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Healing Collar", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryHealingCollar!),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Customized Healling Collar",
                                      isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar!),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Crown", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryCrown!),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Maryland Bridge", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryMarylandBridge!),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Bridge on teeth", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth!),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Denture with glass fiber",
                                      isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber!),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  CIA_MedicalAbsrobPointerWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Block Graft")),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_MultiSelectChipWidget(
                                      onChange: (item, isSelected) {
                                        switch (item) {
                                          case "Chin":
                                            surgicalTreatmentModel.guidedBoneRegenerationBlockGraftChin = isSelected;
                                            break;
                                          case "Ramus":
                                            surgicalTreatmentModel.guidedBoneRegenerationBlockGraftRamus = isSelected;
                                            break;
                                          case "Tuberosity":
                                            surgicalTreatmentModel.guidedBoneRegenerationBlockGraftTuberosity = isSelected;
                                            break;
                                        }
                                        setState(() {});
                                      },
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "Chin", isSelected: surgicalTreatmentModel.guidedBoneRegenerationBlockGraftChin!),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Ramus", isSelected: surgicalTreatmentModel.guidedBoneRegenerationBlockGraftRamus!),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Tuberosity", isSelected: surgicalTreatmentModel.guidedBoneRegenerationBlockGraftTuberosity!),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Other Specify",
                                      onChange: (value) {
                                        surgicalTreatmentModel.guidedBoneRegenerationBlockGraftOther = value;
                                      },
                                      controller: TextEditingController(text: surgicalTreatmentModel.guidedBoneRegenerationBlockGraftOther ?? ""),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Cut By")),
                            Expanded(
                              flex: 4,
                              child: CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) {
                                  switch (item) {
                                    case "Disc":
                                      surgicalTreatmentModel.guidedBoneRegenerationCutByDisc = isSelected;
                                      break;
                                    case "Piezo":
                                      surgicalTreatmentModel.guidedBoneRegenerationCutByPiezo = isSelected;
                                      break;
                                  }
                                  setState(() {});
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "Disc", isSelected: surgicalTreatmentModel.guidedBoneRegenerationCutByDisc!),
                                  CIA_MultiSelectChipWidgeModel(label: "Piezo", isSelected: surgicalTreatmentModel.guidedBoneRegenerationCutByPiezo!),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Screws")),
                            Expanded(
                              flex: 2,
                              child: CIA_TextFormField(
                                label: "No of screws",
                                onChange: (value) {
                                  surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber = int.parse(value);
                                },
                                isNumber: true,
                                controller: TextEditingController(
                                  text: (surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? 0).toString(),
                                ),
                              ),
                            ),
                            Expanded(flex: 2, child: SizedBox())
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Bone Particle")),
                            Expanded(
                              flex: 4,
                              child: StatefulBuilder(builder: (context, _setSatate) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CIA_TextFormField(
                                        label: "Autogenous %",
                                        suffix: "%",
                                        isNumber: true,
                                        onChange: (value) {
                                          surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous = int.parse(value);
                                          if (surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous! > 100)
                                            surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous = 100;
                                          surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Xenograft =
                                              100 - (surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous ?? 0);

                                          _setSatate(() {});
                                        },
                                        validator: (value) {
                                          if (int.parse(value) > 100) {
                                            surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous = 100;
                                            surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Xenograft =
                                                100 - (surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous ?? 0);

                                            return "100";
                                          }
                                          return value;
                                        },
                                        controller: TextEditingController(
                                          text: (surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous ?? 0).toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: CIA_TextFormField(
                                        enabled: false,
                                        label: "Xenograft %",
                                        suffix: "%",
                                        isNumber: true,
                                        controller: TextEditingController(
                                          text: (surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Xenograft ?? 0).toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(child: SizedBox()),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "ACM Bur")),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Area",
                                      onChange: (value) {
                                        surgicalTreatmentModel.guidedBoneRegenerationACMBurArea = value;
                                      },
                                      controller: TextEditingController(
                                        text: surgicalTreatmentModel.guidedBoneRegenerationACMBurArea ?? "",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Notes",
                                      onChange: (value) {
                                        surgicalTreatmentModel.guidedBoneRegenerationACMBurNotes = value;
                                      },
                                      controller: TextEditingController(
                                        text: surgicalTreatmentModel.guidedBoneRegenerationACMBurNotes ?? "",
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  CIA_MedicalAbsrobPointerWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Approach")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "",
                                onChange: (value) {
                                  surgicalTreatmentModel.openSinusLiftApproachString = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.openSinusLiftApproachString ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Fill Material")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "",
                                onChange: (value) {
                                  surgicalTreatmentModel.openSinusLiftFillMaterialString = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.openSinusLiftFillMaterialString ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Membrane")),
                            Expanded(
                              flex: 4,
                              child: SimpleBuilder(builder: (context) {
                                List<DropDownDTO> companies = [];
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            asyncItems: companies.isNotEmpty
                                                ? null
                                                : () async {
                                                    var res = await SettingsAPI.GetMembraneCompanies();
                                                    if (res.statusCode == 200) companies = res.result as List<DropDownDTO>;
                                                    return res;
                                                  },
                                            label: "Membrane Company",
                                            items: companies,
                                            selectedItem: surgicalTreatmentModel.openSinusLift_Membrane_Company != null
                                                ? surgicalTreatmentModel.openSinusLift_Membrane_Company
                                                : companies
                                                    .firstWhereOrNull((element) => element.id == surgicalTreatmentModel.openSinusLift_Membrane_CompanyID),
                                            onSelect: (value) {
                                              surgicalTreatmentModel.openSinusLift_Membrane_CompanyID = value.id;
                                              surgicalTreatmentModel.openSinusLift_Membrane_Company = value;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            label: "Membrane Size",
                                            asyncItems: surgicalTreatmentModel.openSinusLift_Membrane_CompanyID == null
                                                ? null
                                                : () async {
                                                    return await SettingsAPI.GetMembranes(surgicalTreatmentModel.openSinusLift_Membrane_CompanyID!);
                                                  },
                                            selectedItem: () {
                                              if (surgicalTreatmentModel.openSinusLift_Membrane != null)
                                                return DropDownDTO(
                                                    name: surgicalTreatmentModel.openSinusLift_Membrane!.name ??
                                                        surgicalTreatmentModel.openSinusLift_Membrane!.size,
                                                    id: surgicalTreatmentModel.openSinusLift_Membrane!.id);
                                              return null;
                                            }(),
                                            onSelect: (value) {
                                              surgicalTreatmentModel.openSinusLift_MembraneID = value.id;
                                              surgicalTreatmentModel.openSinusLift_Membrane = MembraneModel(id: value.id, size: value.name);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Tacs")),
                            Expanded(
                              flex: 4,
                              child: SimpleBuilder(builder: (context) {
                                List<TacCompanyModel> tacs = [];
                                SettingsAPI.GetTacsCompanies().then((value) {
                                  if (value.statusCode == 200) {
                                    tacs = value.result as List<TacCompanyModel>;
                                    if (surgicalTreatmentModel.openSinusLift_TacsCompanyID != null) {
                                      _getXController.availableTacsNumber.value =
                                          tacs.firstWhere((element) => element.id == surgicalTreatmentModel.openSinusLift_TacsCompanyID).count ?? 0;
                                    }
                                  }
                                });
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            asyncItems: () async {
                                              var res = await SettingsAPI.GetTacsCompanies();
                                              if (res.statusCode == 200) {
                                                tacs = res.result as List<TacCompanyModel>;
                                                res.result = tacs.map((e) => DropDownDTO(id: e.id, name: e.name)).toList();
                                              }
                                              return res;
                                            },
                                            label: "Tacs Company",
                                            selectedItem: surgicalTreatmentModel.openSinusLift_TacsCompany != null
                                                ? DropDownDTO(
                                                    id: surgicalTreatmentModel.openSinusLift_TacsCompany!.id,
                                                    name: surgicalTreatmentModel.openSinusLift_TacsCompany!.name)
                                                : null,
                                            onSelect: (value) {
                                              surgicalTreatmentModel.openSinusLiftTacsNumber = 0;
                                              surgicalTreatmentModel.openSinusLift_TacsCompanyID = value.id;
                                              surgicalTreatmentModel.openSinusLift_TacsCompany = tacs.firstWhere((element) => element.id == value.id);
                                              _getXController.availableTacsNumber.value = surgicalTreatmentModel.openSinusLift_TacsCompany!.count ?? 0;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            label: "Number",
                                            isNumber: true,
                                            onChange: (value) {
                                              surgicalTreatmentModel.openSinusLiftTacsNumber = int.parse(value);
                                            },
                                            controller: TextEditingController(
                                              text: (surgicalTreatmentModel.openSinusLiftTacsNumber ?? 0).toString(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(child: Obx(() => FormTextValueWidget(text: "Available number: ${_getXController.availableTacsNumber.value}")))
                                      ],
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  CIA_MedicalAbsrobPointerWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Surgery Type")),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_MultiSelectChipWidget(
                                      key: GlobalKey(),
                                      onChange: (item, isSelected) {
                                        switch (item) {
                                          case "stg":
                                            surgicalTreatmentModel.softTissueGraftSurgeryTypeSoftTissueGraft = isSelected;
                                            surgicalTreatmentModel.softTissueGraftSurgeryTypeAdvanced = !isSelected;
                                            break;
                                          case "advanced":
                                            surgicalTreatmentModel.softTissueGraftSurgeryTypeAdvanced = isSelected;
                                            surgicalTreatmentModel.softTissueGraftSurgeryTypeSoftTissueGraft = !isSelected;
                                            break;
                                        }
                                        setState(() {});
                                      },
                                      singleSelect: true,
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Soft Tissue Graft",
                                            value: "stg",
                                            isSelected: surgicalTreatmentModel.softTissueGraftSurgeryTypeSoftTissueGraft!),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Advanced", value: "advanced", isSelected: surgicalTreatmentModel.softTissueGraftSurgeryTypeAdvanced!),
                                      ],
                                    ),
                                  ),
                                  surgicalTreatmentModel.softTissueGraftSurgeryTypeSoftTissueGraft!
                                      ? Expanded(
                                          child: CIA_MultiSelectChipWidget(
                                              onChange: (item, isSelected) {
                                                switch (item) {
                                                  case "Free Gingival Graft":
                                                    surgicalTreatmentModel.softTissueGraftSurgeryTypeFreeGinivalGraft = isSelected;
                                                    break;
                                                  case "Connective Tissue Graft":
                                                    surgicalTreatmentModel.softTissueGraftSurgeryTypeConnectiveTissueGraft = isSelected;
                                                    break;
                                                }
                                                setState(() {});
                                              },
                                              labels: [
                                                CIA_MultiSelectChipWidgeModel(
                                                    label: "Free Gingival Graft",
                                                    isSelected: surgicalTreatmentModel.softTissueGraftSurgeryTypeFreeGinivalGraft!),
                                                CIA_MultiSelectChipWidgeModel(
                                                    label: "Connective Tissue Graft",
                                                    isSelected: surgicalTreatmentModel.softTissueGraftSurgeryTypeConnectiveTissueGraft!),
                                              ]),
                                        )
                                      : (surgicalTreatmentModel.softTissueGraftSurgeryTypeAdvanced!
                                          ? Expanded(
                                              child: CIA_TextFormField(
                                                label: "Surgery Technique",
                                                onChange: (value) {
                                                  surgicalTreatmentModel.softTissueGraftSurgeryTypeSurgeryTechnique = value;
                                                },
                                                controller: TextEditingController(
                                                  text: surgicalTreatmentModel.softTissueGraftSurgeryTypeSurgeryTechnique ?? "",
                                                ),
                                              ),
                                            )
                                          : SizedBox()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Exposure")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "Customized Healing Collar teeth numher",
                                onChange: (value) {
                                  surgicalTreatmentModel.softTissueGraftExposureCustomizedHealingCollarTeethNumber = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.softTissueGraftExposureCustomizedHealingCollarTeethNumber ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Donor Site")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "Notes",
                                onChange: (value) {
                                  surgicalTreatmentModel.softTissueGraftDonorSiteNotes = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.softTissueGraftDonorSiteNotes ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Stuture")),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Material",
                                      onChange: (value) {
                                        surgicalTreatmentModel.softTissueGraftSutureMaterial = value;
                                      },
                                      controller: TextEditingController(
                                        text: surgicalTreatmentModel.softTissueGraftSutureMaterial ?? "",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Technique",
                                      onChange: (value) {
                                        surgicalTreatmentModel.softTissueGraftSutureTechnique = value;
                                      },
                                      controller: TextEditingController(
                                        text: surgicalTreatmentModel.softTissueGraftSutureTechnique ?? "",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CIA_TextFormField(
                                      label: "Pack Type",
                                      onChange: (value) {
                                        surgicalTreatmentModel.softTissueGraftSuturePackType = value;
                                      },
                                      controller: TextEditingController(
                                        text: surgicalTreatmentModel.softTissueGraftSuturePackType ?? "",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Recipient Site")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "Area",
                                onChange: (value) {
                                  surgicalTreatmentModel.softTissueGraftRecipientSiteArea = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.softTissueGraftRecipientSiteArea ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Augmentation Site")),
                            Expanded(
                              flex: 4,
                              child: CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) {
                                  switch (item) {
                                    case "Buccal":
                                      surgicalTreatmentModel.softTissueGraftAugmentationBuccal = isSelected;
                                      break;
                                    case "Crestal":
                                      surgicalTreatmentModel.softTissueGraftAugmentationCrestal = isSelected;
                                      break;
                                    case "Lingual":
                                      surgicalTreatmentModel.softTissueGraftAugmentationLingual = isSelected;
                                      break;
                                    case "Mesial":
                                      surgicalTreatmentModel.softTissueGraftAugmentationMesial = isSelected;
                                      break;
                                    case "Distal":
                                      surgicalTreatmentModel.softTissueGraftAugmentationDistal = isSelected;
                                      break;
                                  }
                                  setState(() {});
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "Buccal", isSelected: surgicalTreatmentModel.softTissueGraftAugmentationBuccal!),
                                  CIA_MultiSelectChipWidgeModel(label: "Crestal", isSelected: surgicalTreatmentModel.softTissueGraftAugmentationCrestal!),
                                  CIA_MultiSelectChipWidgeModel(label: "Lingual", isSelected: surgicalTreatmentModel.softTissueGraftAugmentationLingual!),
                                  CIA_MultiSelectChipWidgeModel(label: "Mesial", isSelected: surgicalTreatmentModel.softTissueGraftAugmentationMesial!),
                                  CIA_MultiSelectChipWidgeModel(label: "Distal", isSelected: surgicalTreatmentModel.softTissueGraftAugmentationDistal!),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Frenectomy")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "",
                                onChange: (value) {
                                  surgicalTreatmentModel.softTissueGraftFrenectomyNotes = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.softTissueGraftFrenectomyNotes ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(child: FormTextValueWidget(text: "Bone Graft")),
                            Expanded(
                              flex: 4,
                              child: CIA_TextFormField(
                                label: "Type & Site",
                                onChange: (value) {
                                  surgicalTreatmentModel.softTissueGraftBoneGraftNotes = value;
                                },
                                controller: TextEditingController(
                                  text: surgicalTreatmentModel.softTissueGraftBoneGraftNotes ?? "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));*/
  }
}
