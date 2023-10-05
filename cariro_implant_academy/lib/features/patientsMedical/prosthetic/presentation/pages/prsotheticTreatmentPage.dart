import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentFinalProthesisFullArchUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../Controllers/SiteController.dart';
import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/injection_contianer.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import '../../domain/enums/enum.dart';

class ProstheticTreatmentPage extends StatefulWidget {
  ProstheticTreatmentPage({Key? key, required this.patientId}) : super(key: key);
  int patientId;
  static String routeName = "ProstheticTreatment";
  static String routePath = "Patient/:id/ProstheticTreatment";

  @override
  State<ProstheticTreatmentPage> createState() => _PatientProstheticTreatmentState();
}

class _PatientProstheticTreatmentState extends State<ProstheticTreatmentPage> {
  ProstheticTreatmentEntity? diagnosticEntity;
  ProstheticTreatmentEntity? singleBridgeEntity;
  ProstheticTreatmentEntity? fullArchEntity;
  late ProstheticBloc bloc;
  late MedicalInfoShellBloc medicalInfoShellBloc;
  bool edit = false;

  @override
  void initState() {
    bloc = BlocProvider.of<ProstheticBloc>(context);
    medicalInfoShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
    medicalInfoShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Prosthetic Treatment"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: TabBar(
              onTap: (value) {
                if (value == 0)
                  bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
                else if (value == 1) bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent(id: widget.patientId));
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
                      return AbsorbPointer(absorbing: () {
                        if (stateShell is MedicalInfoBlocChangeViewEditState) {
                          edit = stateShell.edit;
                          return !edit;
                        } else {
                          edit = false;
                          return true;
                        }
                      }(), child: BlocBuilder<ProstheticBloc, ProstheticBloc_States>(
                        builder: (context, state) {
                          if (state is ProstheticBloc_LoadingDataState)
                            return LoadingWidget();
                          else if (state is ProstheticBloc_DataLoadingErrorState)
                            return BigErrorPageWidget(message: state.message);
                          else if (state is ProstheticBloc_DiagnosticDataLoadedSuccessfullyState) {
                            diagnosticEntity = state.data;
                            return StatefulBuilder(
                              builder: (context, _setState) {
                                return ListView(children: () {
                                  List<Widget> r = [];
                                  if (diagnosticEntity!.prostheticDiagnostic_DiagnosticImpression!.isEmpty) {
                                    diagnosticEntity!.prostheticDiagnostic_DiagnosticImpression!.add(DiagnosticImpressionEntity());
                                  }
                                  if (diagnosticEntity!.prostheticDiagnostic_Bite!.isEmpty) {
                                    diagnosticEntity!.prostheticDiagnostic_Bite!.add(BiteEntity());
                                  }
                                  if (diagnosticEntity!.prostheticDiagnostic_ScanAppliance!.isEmpty) {
                                    diagnosticEntity!.prostheticDiagnostic_ScanAppliance!.add(ScanApplianceEntity());
                                  }

                                  r.add(Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FormTextKeyWidget(text: "Diagnostic Impression"),
                                  ));
                                  r.addAll(diagnosticEntity!.prostheticDiagnostic_DiagnosticImpression!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_DropDownSearch(
                                                    label: "Diagnostic",
                                                    selectedItem: () {
                                                      if (e.diagnostic != null) {
                                                        return DropDownDTO(name: e.diagnostic!.name.replaceAll("_", " "));
                                                      }
                                                      return null;
                                                    }(),
                                                    onSelect: (value) {
                                                      e.diagnostic = EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[value.id!];
                                                    },
                                                    items: [
                                                      DropDownDTO(name: "Physical", id: 0),
                                                      DropDownDTO(name: "Digital", id: 1),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: CIA_DropDownSearch(
                                                    label: "Next Step",
                                                    selectedItem: () {
                                                      if (e.nextStep != null) {
                                                        return DropDownDTO(name: e.nextStep!.name.replaceAll("_", " "));
                                                      }
                                                      return null;
                                                    }(),
                                                    onSelect: (value) {
                                                      e.nextStep = EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];
                                                    },
                                                    items: [
                                                      DropDownDTO(name: "Ready for implant", id: 0),
                                                      DropDownDTO(name: "Bite", id: 1),
                                                      DropDownDTO(name: "Needs new impression", id: 2),
                                                      DropDownDTO(name: "Needs scan PPT", id: 3),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                CIA_CheckBoxWidget(
                                                  text: "Needs Remake",
                                                  onChange: (v) => e.needsRemake = v,
                                                  value: e.needsRemake ?? false,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                        align: TextAlign.center,
                                                        text: e.operator!.name ?? "",
                                                        secondaryInfo: true,
                                                      )),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                        align: TextAlign.center,
                                                        text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                                        secondaryInfo: true,
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_DiagnosticImpression!.add(DiagnosticImpressionEntity(
                                                            operatorId: sl<SharedPreferences>().getInt("userid"),
                                                            operator: BasicNameIdObjectEntity(
                                                              name: siteController.getUserName(),
                                                              id: sl<SharedPreferences>().getInt("userid"),
                                                            )));
                                                      });
                                                    },
                                                    icon: Icon(Icons.add))
                                              ],
                                            ),
                                          ))
                                      .toList());

                                  r.add(Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FormTextKeyWidget(text: "Bite"),
                                  ));
                                  r.addAll(diagnosticEntity!.prostheticDiagnostic_Bite!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_DropDownSearch(
                                                    label: "Diagnostic",
                                                    selectedItem: () {
                                                      if (e.diagnostic != null) {
                                                        return DropDownDTO(name: e.diagnostic!.name.replaceAll("_", " "));
                                                      }
                                                      return null;
                                                    }(),
                                                    onSelect: (value) {
                                                      e.diagnostic = EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                                                    },
                                                    items: [
                                                      DropDownDTO(name: "Done", id: 0),
                                                      DropDownDTO(name: "Needs ReScan", id: 1),
                                                      DropDownDTO(name: "Needs ReImpression", id: 2),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: CIA_DropDownSearch(
                                                    label: "Next Step",
                                                    selectedItem: () {
                                                      if (e.nextStep != null) {
                                                        return DropDownDTO(name: e.nextStep!.name.replaceAll("_", " "));
                                                      }
                                                      return null;
                                                    }(),
                                                    onSelect: (value) {
                                                      e.nextStep = EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                                                    },
                                                    items: [
                                                      DropDownDTO(name: "Scan Appliance", id: 0),
                                                      DropDownDTO(name: "ReImpression", id: 1),
                                                      DropDownDTO(name: "ReBite", id: 2),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                CIA_CheckBoxWidget(
                                                  text: "Needs Remake",
                                                  onChange: (v) => e.needsRemake = v,
                                                  value: e.needsRemake ?? false,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                        align: TextAlign.center,
                                                        text: e.operator!.name ?? "",
                                                        secondaryInfo: true,
                                                      )),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                        align: TextAlign.center,
                                                        text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                                        secondaryInfo: true,
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_Bite!.add(BiteEntity());
                                                      });
                                                    },
                                                    icon: Icon(Icons.add))
                                              ],
                                            ),
                                          ))
                                      .toList());

                                  r.add(Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FormTextKeyWidget(text: "Scan Appliance"),
                                  ));
                                  r.addAll(diagnosticEntity!.prostheticDiagnostic_ScanAppliance!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_DropDownSearch(
                                                    label: "Diagnostic",
                                                    selectedItem: () {
                                                      if (e.diagnostic != null) {
                                                        return DropDownDTO(name: e.diagnostic!.name.replaceAll("_", " "));
                                                      }
                                                      return null;
                                                    }(),
                                                    onSelect: (value) {
                                                      e.diagnostic = EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];
                                                    },
                                                    items: [
                                                      DropDownDTO(name: "Done", id: 0),
                                                      DropDownDTO(name: "Needs ReBite", id: 1),
                                                      DropDownDTO(name: "Needs ReImpression", id: 2),
                                                      DropDownDTO(name: "Needs ReDesign", id: 3),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(child: SizedBox()),
                                                SizedBox(width: 10),
                                                CIA_CheckBoxWidget(
                                                  text: "Needs Remake",
                                                  onChange: (v) => e.needsRemake = v,
                                                  value: e.needsRemake ?? false,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                        align: TextAlign.center,
                                                        text: e.operator!.name ?? "",
                                                        secondaryInfo: true,
                                                      )),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                          child: FormTextValueWidget(
                                                        align: TextAlign.center,
                                                        text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                                        secondaryInfo: true,
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_ScanAppliance!.add(ScanApplianceEntity());
                                                      });
                                                    },
                                                    icon: Icon(Icons.add))
                                              ],
                                            ),
                                          ))
                                      .toList());

                                  // r = r.map((e) => CIA_MedicalAbsrobPointerWidget(child: e)).toList();
                                  return r;
                                  /*
                        * FormTextKeyWidget(text: "Diagnostic Impression"),
                        Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Diagnostic",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticDiagnosticImpressionDiagnostic != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticDiagnosticImpressionDiagnostic!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticDiagnosticImpressionDiagnostic =
                                      EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Physical", id: 0),
                                  DropDownDTO(name: "Digital", id: 1),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Next Step",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticDiagnosticImpressionNextStep != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticDiagnosticImpressionNextStep!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticDiagnosticImpressionNextStep =
                                      EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Ready for implant", id: 0),
                                  DropDownDTO(name: "Bite", id: 1),
                                  DropDownDTO(name: "Needs new impression", id: 2),
                                  DropDownDTO(name: "Needs scan PPT", id: 3),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              onChange: (v) => model.prostheticDiagnosticDiagnosticImpressionNeedsRemake = v,
                              value: model.prostheticDiagnosticDiagnosticImpressionNeedsRemake ?? false,
                            ),
                          ],
                        ),
                        FormTextKeyWidget(text: "Bite"),
                        Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Diagnostic",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticBiteDiagnostic != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticBiteDiagnostic!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticBiteDiagnostic = EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Done", id: 0),
                                  DropDownDTO(name: "Needs ReScan", id: 1),
                                  DropDownDTO(name: "Needs ReImpression", id: 2),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Next Step",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticBiteNextStep != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticBiteNextStep!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticBiteNextStep = EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Scan Appliance", id: 0),
                                  DropDownDTO(name: "ReImpression", id: 1),
                                  DropDownDTO(name: "ReBite", id: 2),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              onChange: (v) => model.prostheticDiagnosticBiteNeedsRemake = v,
                              value: model.prostheticDiagnosticBiteNeedsRemake ?? false,
                            ),
                          ],
                        ),
                        FormTextKeyWidget(text: "Scan Appliance"),
                        Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Diagnostic",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticScanApplianceDiagnostic != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticScanApplianceDiagnostic!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticScanApplianceDiagnostic = EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Done", id: 0),
                                  DropDownDTO(name: "Needs ReBite", id: 1),
                                  DropDownDTO(name: "Needs ReImpression", id: 2),
                                  DropDownDTO(name: "Needs ReDesign", id: 3),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: SizedBox()),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              onChange: (v) => model.prostheticDiagnosticScanApplianceNeedsRemake = v,
                              value: model.prostheticDiagnosticScanApplianceNeedsRemake ?? false,
                            ),
                          ],
                        ),
                        CIA_PrimaryButton(label: "Save", onTab: ()async{
                          await MedicalAPI.UpdatePatientProstheticTreatmentDiagnostic(widget.patientId, model);
                        })

                      ,*/
                                }());
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
                            if (value == 0)
                              bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent(id: widget.patientId));
                            else if (value == 1) bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisFullArchEvent(id: widget.patientId));
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
                                  return BlocBuilder<ProstheticBloc, ProstheticBloc_States>(
                                    builder: (context, state) {
                                      if (state is ProstheticBloc_LoadingDataState)
                                        return LoadingWidget();
                                      else if (state is ProstheticBloc_DataLoadingErrorState)
                                        return BigErrorPageWidget(message: state.message);
                                      else if (state is ProstheticBloc_SingleAndBridgeDataLoadedSuccessfullyState) {
                                        singleBridgeEntity = state.data;
                                        return AbsorbPointer(
                                            absorbing: () {
                                              if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                                edit = stateShell.edit;
                                                return !edit;
                                              } else {
                                                edit = false;
                                                return true;
                                              }
                                            }(),
                                            child: ListView(
                                              children: [
                                                CIA_TeethChart(
                                                  onChange: (selectedTeethList) {
                                                    singleBridgeEntity!.finalProthesisSingleBridgeTeeth = selectedTeethList;
                                                  },
                                                  selectedTeeth: singleBridgeEntity!.finalProthesisSingleBridgeTeeth ?? [],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CIA_CheckBoxWidget(
                                                        text: "Healing Collar",
                                                        onChange: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeHealingCollar = value;
                                                        },
                                                        value: singleBridgeEntity!.finalProthesisSingleBridgeHealingCollar ?? false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Customization",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeHealingCollarStatus != null) {
                                                            return DropDownDTO(
                                                                name: singleBridgeEntity!.finalProthesisSingleBridgeHealingCollarStatus!.name
                                                                    .replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeHealingCollarStatus =
                                                              EnumFinalProthesisSingleBridgeHealingCollarStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "With Customization", id: 0),
                                                          DropDownDTO(name: "Without Customization", id: 1),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(child: SizedBox()),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CIA_CheckBoxWidget(
                                                        text: "Impression",
                                                        onChange: (v) => singleBridgeEntity!.finalProthesisSingleBridgeImpression = v,
                                                        value: singleBridgeEntity!.finalProthesisSingleBridgeImpression ?? false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Procedure",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeImpressionStatus != null) {
                                                            return DropDownDTO(
                                                                name:
                                                                    singleBridgeEntity!.finalProthesisSingleBridgeImpressionStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeImpressionStatus =
                                                              EnumFinalProthesisSingleBridgeImpressionStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Scan by scan body", id: 0),
                                                          DropDownDTO(name: "Scan by abutment", id: 1),
                                                          DropDownDTO(name: "Physical Impression open tray", id: 2),
                                                          DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Next Visit",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeImpressionNextVisit != null) {
                                                            return DropDownDTO(
                                                                name: singleBridgeEntity!.finalProthesisSingleBridgeImpressionNextVisit!.name
                                                                    .replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeImpressionNextVisit =
                                                              EnumFinalProthesisSingleBridgeImpressionNextVisit.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Custom Abutment", id: 0),
                                                          DropDownDTO(name: "Try In", id: 1),
                                                          DropDownDTO(name: "Delivery", id: 2),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: CIA_CheckBoxWidget(
                                                      text: "Try in",
                                                      onChange: (v) => singleBridgeEntity!.finalProthesisSingleBridgeTryIn = v,
                                                      value: singleBridgeEntity!.finalProthesisSingleBridgeTryIn ?? false,
                                                    )),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Procedure",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeTryInStatus != null) {
                                                            return DropDownDTO(
                                                                name: singleBridgeEntity!.finalProthesisSingleBridgeTryInStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeTryInStatus =
                                                              EnumFinalProthesisSingleBridgeTryInStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                                                          DropDownDTO(name: "Try in PMMA", id: 1),
                                                          DropDownDTO(name: "Try in on scan abutment PMMY", id: 2),
                                                          DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Next Visit",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeTryInNextVisit != null) {
                                                            return DropDownDTO(
                                                                name: singleBridgeEntity!.finalProthesisSingleBridgeTryInNextVisit!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeTryInNextVisit =
                                                              EnumFinalProthesisSingleBridgeTryInNextVisit.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Delivery", id: 0),
                                                          DropDownDTO(name: "Try in PMMA", id: 1),
                                                          DropDownDTO(name: "ReImpression", id: 2),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: CIA_CheckBoxWidget(
                                                      text: "Delivery",
                                                      onChange: (v) => singleBridgeEntity!.finalProthesisSingleBridgeDelivery = v,
                                                      value: singleBridgeEntity!.finalProthesisSingleBridgeDelivery ?? false,
                                                    )),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Status",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeDeliveryStatus != null) {
                                                            return DropDownDTO(
                                                                name: singleBridgeEntity!.finalProthesisSingleBridgeDeliveryStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeDeliveryStatus =
                                                              EnumFinalProthesisSingleBridgeDeliveryStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Done", id: 0),
                                                          DropDownDTO(name: "ReDesign", id: 1),
                                                          DropDownDTO(name: "ReImpression", id: 2),
                                                          DropDownDTO(name: "ReTryIn", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Next Visit",
                                                        selectedItem: () {
                                                          if (singleBridgeEntity!.finalProthesisSingleBridgeDeliveryNextVisit != null) {
                                                            return DropDownDTO(
                                                                name:
                                                                    singleBridgeEntity!.finalProthesisSingleBridgeDeliveryNextVisit!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          singleBridgeEntity!.finalProthesisSingleBridgeDeliveryNextVisit =
                                                              EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Done", id: 0),
                                                          DropDownDTO(name: "ReDesign", id: 1),
                                                          DropDownDTO(name: "ReImpression", id: 2),
                                                          DropDownDTO(name: "ReTryIn", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
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
                                  return BlocBuilder<ProstheticBloc, ProstheticBloc_States>(
                                    builder: (context, state) {
                                      if (state is ProstheticBloc_LoadingDataState)
                                        return LoadingWidget();
                                      else if (state is ProstheticBloc_DataLoadingErrorState)
                                        return BigErrorPageWidget(message: state.message);
                                      else if (state is ProstheticBloc_FullArchDataLoadedSuccessfullyState) {
                                        fullArchEntity = state.data;
                                        return AbsorbPointer(
                                            absorbing: () {
                                              if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                                edit = stateShell.edit;
                                                return !edit;
                                              } else {
                                                edit = false;
                                                return true;
                                              }
                                            }(),
                                            child: ListView(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: CIA_CheckBoxWidget(
                                                      text: "Healing Collar",
                                                      onChange: (value) {
                                                        fullArchEntity!.finalProthesisFullArchHealingCollar = value;
                                                      },
                                                      value: fullArchEntity!.finalProthesisFullArchHealingCollar ?? false,
                                                    )),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Customization",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchHealingCollarStatus != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchHealingCollarStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchHealingCollarStatus =
                                                              EnumFinalProthesisSingleBridgeHealingCollarStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "With Customization", id: 0),
                                                          DropDownDTO(name: "Without Customization", id: 1),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(child: SizedBox()),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CIA_CheckBoxWidget(
                                                        text: "Impression",
                                                        onChange: (v) => fullArchEntity!.finalProthesisFullArchImpression = v,
                                                        value: fullArchEntity!.finalProthesisFullArchImpression ?? false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Procedure",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchImpressionStatus != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchImpressionStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchImpressionStatus =
                                                              EnumFinalProthesisSingleBridgeImpressionStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Scan by scan body", id: 0),
                                                          DropDownDTO(name: "Scan by abutment", id: 1),
                                                          DropDownDTO(name: "Physical Impression open tray", id: 2),
                                                          DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Next Visit",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchImpressionNextVisit != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchImpressionNextVisit!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchImpressionNextVisit =
                                                              EnumFinalProthesisSingleBridgeImpressionNextVisit.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Custom Abutment", id: 0),
                                                          DropDownDTO(name: "Try In", id: 1),
                                                          DropDownDTO(name: "Delivery", id: 2),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: CIA_CheckBoxWidget(
                                                      text: "Try in",
                                                      onChange: (v) => fullArchEntity!.finalProthesisFullArchTryIn = v,
                                                      value: fullArchEntity!.finalProthesisFullArchTryIn ?? false,
                                                    )),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Procedure",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchTryInStatus != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchTryInStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchTryInStatus =
                                                              EnumFinalProthesisSingleBridgeTryInStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                                                          DropDownDTO(name: "Try in PMMA", id: 1),
                                                          DropDownDTO(name: "Try in on scan abutment PMMY", id: 2),
                                                          DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Next Visit",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchTryInNextVisit != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchTryInNextVisit!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchTryInNextVisit =
                                                              EnumFinalProthesisSingleBridgeTryInNextVisit.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Delivery", id: 0),
                                                          DropDownDTO(name: "Try In PMMA", id: 1),
                                                          DropDownDTO(name: "ReImpression", id: 2),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: CIA_CheckBoxWidget(
                                                      text: "Delivery",
                                                      onChange: (v) => fullArchEntity!.finalProthesisFullArchDelivery = v,
                                                      value: fullArchEntity!.finalProthesisFullArchDelivery ?? false,
                                                    )),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Status",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchDeliveryStatus != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchDeliveryStatus!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchDeliveryStatus =
                                                              EnumFinalProthesisSingleBridgeDeliveryStatus.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Done", id: 0),
                                                          DropDownDTO(name: "ReDesign", id: 1),
                                                          DropDownDTO(name: "ReImpression", id: 2),
                                                          DropDownDTO(name: "ReTryIn", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_DropDownSearch(
                                                        label: "Next Visit",
                                                        selectedItem: () {
                                                          if (fullArchEntity!.finalProthesisFullArchDeliveryNextVisit != null) {
                                                            return DropDownDTO(
                                                                name: fullArchEntity!.finalProthesisFullArchDeliveryNextVisit!.name.replaceAll("_", " "));
                                                          }
                                                          return null;
                                                        }(),
                                                        onSelect: (value) {
                                                          fullArchEntity!.finalProthesisFullArchDeliveryNextVisit =
                                                              EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[value.id!];
                                                        },
                                                        items: [
                                                          DropDownDTO(name: "Done", id: 0),
                                                          DropDownDTO(name: "ReDesign", id: 1),
                                                          DropDownDTO(name: "ReImpression", id: 2),
                                                          DropDownDTO(name: "ReTryIn", id: 3),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(child: SizedBox())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
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
    );
  }

  @override
  void dispose() {
    if (edit) {
      Future.delayed(Duration.zero, () async {
        try {
          if (fullArchEntity != null) bloc.add(ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisFullArchEvent(data: fullArchEntity!));
        } on Exception catch (e) {
          // print(e);
        }
        try {
          if (diagnosticEntity != null) bloc.add(ProstheticBloc_UpdatePatientProstheticTreatmentDiagnosticEvent(data: diagnosticEntity!));
        } on Exception catch (e) {
          // print(e);
        }
        try {
          if (singleBridgeEntity != null) bloc.add(ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeEvent(data: singleBridgeEntity!));
        } on Exception catch (e) {
          //print(e);
        }
      });
    }

    super.dispose();
  }
}
