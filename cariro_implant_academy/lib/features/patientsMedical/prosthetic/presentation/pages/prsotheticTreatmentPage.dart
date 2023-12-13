import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisDeliveryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisHealingCollarEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisTryInEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentFinalProthesisFullArchUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesisWidget.dart';
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
import '../../domain/entities/prostheticTreatmentFinalEntity.dart';
import '../../domain/enums/enum.dart';

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
  ProstheticTreatmentEntity? diagnosticEntity;
  ProstheticTreatmentFinalEntity? singleBridgeEntity;
  ProstheticTreatmentFinalEntity? fullArchEntity;
  late ProstheticBloc bloc;
  late MedicalInfoShellBloc medicalInfoShellBloc;
  bool edit = false;

  @override
  void initState() {
    bloc = BlocProvider.of<ProstheticBloc>(context);
    medicalInfoShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
    medicalInfoShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Prosthetic Treatment"));
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
                  } else if (value == 1) {
                    bloc.add(ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent(id: widget.patientId));
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
                        return AbsorbPointer(absorbing: () {
                          if (stateShell is MedicalInfoBlocChangeViewEditState) {
                            edit = stateShell.edit;
                            return !edit;
                          } else {
                            return !edit;
                          }
                        }(), child: BlocConsumer<ProstheticBloc, ProstheticBloc_States>(
                          listener: (context, state) {
                            if(state is ProstheticBloc_UpdatedProstheticDiagnosticSuccessfullyState)
                              bloc.add(ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent(id: widget.patientId));
                          },
                          buildWhen: (previous, current) =>
                          current is ProstheticBloc_LoadingDataState ||
                          current is ProstheticBloc_DataLoadingErrorState ||
                          current is ProstheticBloc_DiagnosticDataLoadedSuccessfullyState

                          ,
                          builder: (context, state) {
                            if (state is ProstheticBloc_LoadingDataState)
                              return LoadingWidget();
                            else if (state is ProstheticBloc_DataLoadingErrorState)
                              return BigErrorPageWidget(message: state.message);
                            else if (state is ProstheticBloc_DiagnosticDataLoadedSuccessfullyState) {
                              diagnosticEntity = state.data;
                              medicalInfoShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.data.date, data: diagnosticEntity));

                              return

                                StatefulBuilder(
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
                                                  e.operatorId = siteController.getUserId();
                                                  _setState(() {
                                                    e.operator =BasicNameIdObjectEntity(name:  siteController.getUserName());
                                                    e.date = DateTime.now();
                                                  });
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
                                                  e.operatorId = siteController.getUserId();
                                                  e.nextStep = EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];
                                                  _setState(() {
                                                    e.operator =BasicNameIdObjectEntity(name:  siteController.getUserName());
                                                    e.date = DateTime.now();
                                                  });
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
                                              onChange: (v) {
                                                e.operatorId = siteController.getUserId();
                                                if (v) e.scanned = false;
                                                _setState(() {});
                                                e.needsRemake = v;
                                              },
                                              value: e.needsRemake ?? false,
                                            ),
                                            SizedBox(width: 10),
                                            CIA_CheckBoxWidget(
                                              text: "Scanned",
                                              onChange: (v) {
                                                e.operatorId = siteController.getUserId();
                                                if (v) e.needsRemake = false;
                                                _setState(() {});
                                                return e.scanned = v;
                                              },
                                              value: e.scanned ?? false,
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
                                                      child: CIA_GestureWidget(
                                                        onTap: (){
                                                          CIA_PopupDialog_DateTimePicker(context, "Change Date and Time", (v){
                                                           _setState(() {
                                                             e.date = v;
                                                           });

                                                          });
                                                        },
                                                        child: FormTextValueWidget(
                                                          align: TextAlign.center,
                                                          text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                                          secondaryInfo: true,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Row(
                                              children: [
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
                                                    icon: Icon(Icons.add)),
                                                SizedBox(width:10),
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_DiagnosticImpression!.remove(e);
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ),
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
                                                  e.operatorId = siteController.getUserId();
                                                  e.diagnostic = EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                                                  _setState(() {
                                                    e.operator =BasicNameIdObjectEntity(name:  siteController.getUserName());
                                                    e.date = DateTime.now();
                                                  });
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
                                                  e.operatorId = siteController.getUserId();
                                                  e.nextStep = EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                                                  _setState(() {
                                                    e.operator =BasicNameIdObjectEntity(name:  siteController.getUserName());
                                                    e.date = DateTime.now();
                                                  });
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
                                              onChange: (v) {
                                                e.operatorId = siteController.getUserId();
                                                if (v) e.scanned = false;
                                                _setState(() {});
                                                return e.needsRemake = v;
                                              },
                                              value: e.needsRemake ?? false,
                                            ),
                                            SizedBox(width: 10),
                                            CIA_CheckBoxWidget(
                                              text: "Scanned",
                                              onChange: (v) {
                                                e.operatorId = siteController.getUserId();
                                                if (v) e.needsRemake = false;
                                                _setState(() {});
                                                return e.scanned = v;
                                              },
                                              value: e.scanned ?? false,
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
                                                      child:  CIA_GestureWidget(
                                                        onTap: (){
                                                          CIA_PopupDialog_DateTimePicker(context, "Change Date and Time", (v){
                                                            _setState(() {
                                                              e.date = v;
                                                            });

                                                          });
                                                        },
                                                        child: FormTextValueWidget(
                                                          align: TextAlign.center,
                                                          text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                                          secondaryInfo: true,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_Bite!.add(BiteEntity());
                                                      });
                                                    },
                                                    icon: Icon(Icons.add)),
                                                SizedBox(width:10),
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_Bite!.remove(e);
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ),
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
                                                  e.operatorId = siteController.getUserId();
                                                  e.diagnostic = EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];
                                                  _setState(() {
                                                    e.operator =BasicNameIdObjectEntity(name:  siteController.getUserName());
                                                    e.date = DateTime.now();
                                                  });
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
                                              onChange: (v) {
                                                e.operatorId = siteController.getUserId();
                                                if (v) e.scanned = false;
                                                _setState(() {});
                                                return e.needsRemake = v;
                                              },
                                              value: e.needsRemake ?? false,
                                            ),
                                            SizedBox(width: 10),
                                            CIA_CheckBoxWidget(
                                              text: "Scanned",
                                              onChange: (v) {
                                                e.operatorId = siteController.getUserId();
                                                if (v) e.needsRemake = false;
                                                _setState(() {});
                                                return e.scanned = v;
                                              },
                                              value: e.scanned ?? false,
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
                                                      child: CIA_GestureWidget(
                                                        onTap: (){
                                                          CIA_PopupDialog_DateTimePicker(context, "Change Date and Time", (v){
                                                            _setState(() {
                                                              e.date = v;
                                                            });

                                                          });
                                                        },
                                                        child: FormTextValueWidget(
                                                          align: TextAlign.center,
                                                          text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!),
                                                          secondaryInfo: true,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_ScanAppliance!.add(ScanApplianceEntity());
                                                      });
                                                    },
                                                    icon: Icon(Icons.add)),
                                                SizedBox(width:10),
                                                IconButton(
                                                    onPressed: () {
                                                      _setState(() {
                                                        diagnosticEntity!.prostheticDiagnostic_ScanAppliance!.remove(e);
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ),
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
                                        if(state is ProstheticBloc_UpdatedProstheticSinlgeBridgeSuccessfullyState)
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
                                          medicalInfoShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.data.date, data: singleBridgeEntity));

                                          return AbsorbPointer(
                                              absorbing: () {
                                                if (stateShell is MedicalInfoBlocChangeViewEditState) {
                                                  edit = stateShell.edit;
                                                  return !edit;
                                                } else {
                                                  return !edit;
                                                }
                                              }(),
                                              child: FinalProsthesisWidget(
                                                patientId: widget.patientId,
                                                data: singleBridgeEntity!,
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
                                        if(state is ProstheticBloc_UpdatedProstheticFullArchSuccessfullyState)
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
                                          medicalInfoShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.data.date, data: fullArchEntity));

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
                                              child: FinalProsthesisWidget(
                                                patientId: widget.patientId,
                                                data: fullArchEntity!,
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
