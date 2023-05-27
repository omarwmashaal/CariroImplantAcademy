import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/SurgicalTreatmentModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_IncrementalTextField.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../API/SettingsAPI.dart';
import '../Constants/Fonts.dart';
import '../Controllers/PatientMedicalController.dart';
import '../Models/API_Response.dart';
import '../Models/MedicalModels/TreatmentPlanModel.dart';
import '../Models/MedicalModels/TreatmentPrices.dart';
import '../Models/MembraneModel.dart';
import '../Models/TacCompanyModel.dart';
import 'CIA_TextFormField.dart';
import 'FormTextWidget.dart';
import 'MultiSelectChipWidget.dart';

bool isSurgical = false;
TreatmentPrices prices = TreatmentPrices();

class _getXController extends GetxController {
  static RxBool tickVisible = false.obs;
}

// TODO: Listen to models and higlight chips
class CIA_TeethTreatmentPlanWidget extends StatefulWidget {
  CIA_TeethTreatmentPlanWidget({Key? key, required this.patientID, this.surgical = false}) : super(key: key);

  int patientID;
  bool surgical;

  @override
  State<CIA_TeethTreatmentPlanWidget> createState() => _CIA_TeethTreatmentPlanWidgetState();
}

late List<TreatmentPlanSubModel> models;

class _CIA_TeethTreatmentPlanWidgetState extends State<CIA_TeethTreatmentPlanWidget> {
  List<int> selectedTeeth = [];
  List<String> selectedStatus = [];
  bool viewOnlyMode = false;

  _updateTeethStatus(List<int> teeth, String status) {
    for (int tooth in teeth) {
      var currentTooth = models.firstWhereOrNull((element) => element.tooth == tooth);
      if (currentTooth == null) {
        currentTooth = new TreatmentPlanSubModel(tooth: tooth, patientId: patientID);
        models.add(currentTooth);
      }
      switch (status) {
        case "Simple Implant":
          {
            if (currentTooth.simpleImplant == null) currentTooth.simpleImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.simpleImplant!.status = true;
              currentTooth.simpleImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.simpleImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.splittingWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }

        case "Immediate Implant":
          {
            if (currentTooth.immediateImplant == null) currentTooth.immediateImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.immediateImplant!.status = true;
              currentTooth.immediateImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.immediateImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.simpleImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.splittingWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }
        case "Guided Implant":
          {
            if (currentTooth.guidedImplant == null) currentTooth.guidedImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.guidedImplant!.status = true;
              currentTooth.guidedImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.guidedImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.simpleImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.splittingWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }
        case "Expansion With Implant":
          {
            if (currentTooth.expansionWithImplant == null) currentTooth.expansionWithImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.expansionWithImplant!.status = true;
              currentTooth.expansionWithImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.expansionWithImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.simpleImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.splittingWithImplant = null;
            break;
          }
        case "Splitting With Implant":
          {
            if (currentTooth.splittingWithImplant == null) currentTooth.splittingWithImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.splittingWithImplant!.status = true;
              currentTooth.splittingWithImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.splittingWithImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.simpleImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }
        case "GBR With Implant":
          {
            if (currentTooth.gbrWithImplant == null) currentTooth.gbrWithImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.gbrWithImplant!.status = true;
              currentTooth.gbrWithImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.gbrWithImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.simpleImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.splittingWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }
        case "Open Sinus With Implant":
          {
            if (currentTooth.openSinusWithImplant == null) currentTooth.openSinusWithImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.openSinusWithImplant!.status = true;
              currentTooth.openSinusWithImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.openSinusWithImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.simpleImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.closedSinusWithImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.splittingWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }
        case "Closed Sinus With Implant":
          {
            if (currentTooth.closedSinusWithImplant == null) currentTooth.closedSinusWithImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.closedSinusWithImplant!.status = true;
              currentTooth.closedSinusWithImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.closedSinusWithImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            currentTooth.immediateImplant = null;
            currentTooth.simpleImplant = null;
            currentTooth.guidedImplant = null;
            currentTooth.openSinusWithImplant = null;
            currentTooth.gbrWithImplant = null;
            currentTooth.splittingWithImplant = null;
            currentTooth.expansionWithImplant = null;
            break;
          }
        case "Expansion Without Implant":
          {
            if (currentTooth.expansionWithoutImplant == null) currentTooth.expansionWithoutImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.expansionWithoutImplant!.status = true;
              currentTooth.expansionWithoutImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.expansionWithoutImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Splitting Without Implant":
          {
            if (currentTooth.splittingWithoutImplant == null) currentTooth.splittingWithoutImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.splittingWithoutImplant!.status = true;
              currentTooth.splittingWithoutImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);

              currentTooth.splittingWithoutImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "GBR Without Implant":
          {
            if (currentTooth.gbrWithoutImplant == null) currentTooth.gbrWithoutImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.gbrWithoutImplant!.status = true;
              currentTooth.gbrWithoutImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.gbrWithoutImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Open Sinus Without Implant":
          {
            if (currentTooth.openSinusWithoutImplant == null) currentTooth.openSinusWithoutImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.openSinusWithoutImplant!.status = true;
              currentTooth.openSinusWithoutImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.openSinusWithoutImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Closed Sinus Without Implant":
          {
            if (currentTooth.closedSinusWithoutImplant == null) currentTooth.closedSinusWithoutImplant = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.closedSinusWithoutImplant!.status = true;
              currentTooth.closedSinusWithoutImplant!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.closedSinusWithoutImplant!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }

        case "Pontic":
          {
            if (currentTooth.pontic == null) currentTooth.pontic = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.pontic!.status = true;
              currentTooth.pontic!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.pontic!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Extraction":
          {
            if (currentTooth.extraction == null) currentTooth.extraction = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.extraction!.status = true;
              currentTooth.extraction!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.extraction!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Restoration":
          {
            if (currentTooth.restoration == null) currentTooth.restoration = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.restoration!.status = true;
              currentTooth.restoration!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.restoration!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Root Canal Treatment":
          {
            if (currentTooth.rootCanalTreatment == null) currentTooth.rootCanalTreatment = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.rootCanalTreatment!.status = true;
              currentTooth.rootCanalTreatment!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.rootCanalTreatment!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Scaling":
          {
            if (currentTooth.scaling == null) currentTooth.scaling = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.scaling!.status = true;
              currentTooth.scaling!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.scaling!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
        case "Crown":
          {
            if (currentTooth.crown == null) currentTooth.crown = TreatmentPlanFieldsModel();
            if (isSurgical) {
              currentTooth.crown!.status = true;
              currentTooth.crown!.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
              currentTooth.crown!.doneByAssistantID = siteController.getUser().idInt;
            }
            break;
          }
      }
    }
  }

  _updateTeethMultiStatus(List<int> teeth, List<String> status) {
    for (String s in status) {
      _updateTeethStatus(teeth, s);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedTeeth.isEmpty) {
      selectedStatus.clear();
      _getXController.tickVisible.value = false;
      setState(() {});
    }
    return CIA_FutureBuilder(
      loadFunction: loadFunction,
      onSuccess: (data) {
        if (isSurgical)
          surgicalTreatmentModel = data as SurgicalTreatmentModel;
        else
          treatmentPlanModel = data as TreatmentPlanModel;

        models = isSurgical ? surgicalTreatmentModel.surgicalTreatment ?? [] : treatmentPlanModel.treatmentPlan ?? [];
        return FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CIA_TeethChart(
                      onChange: (selectedTeethList) {
                        selectedTeeth = selectedTeethList;
                        _getXController.tickVisible.value = true;
                      },
                    ),
                  ),
                  CIA_MultiSelectChipWidget(
                    onChange: (item, isSelected) async {
                      if (item == "View Only Mode") {
                        viewOnlyMode = isSelected;
                        setState(() {});
                      }
                      if (item == "Post Surgery") {
                        await CIA_ShowPopUp(
                          width: 1000,
                          height: 600,
                          context: context,
                          child: _PostSurgeryWidget(),
                        );
                      }
                    },
                    labels: isSurgical
                        ? [
                            CIA_MultiSelectChipWidgeModel(label: "Post Surgery", borderColor: Colors.black, round: false, isSelected: false, isButton: true),
                          ]
                        : [
                            CIA_MultiSelectChipWidgeModel(label: "View Only Mode", borderColor: Colors.black, round: false),
                          ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              CIA_MultiSelectChipWidget(
                  key: GlobalKey(),
                  onChangeList: (selectedItems) {
                    if (selectedTeeth.isEmpty) {
                      setState(() {});
                    } else
                      selectedStatus = selectedItems;
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
                  ]),
              Obx(() => Visibility(
                    visible: _getXController.tickVisible.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _updateTeethMultiStatus(selectedTeeth, selectedStatus);
                            _getXController.tickVisible.value = false;
                            selectedStatus.clear();
                            selectedTeeth.clear();
                            setState(() {});
                          },
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _getXController.tickVisible.value = false;
                            selectedTeeth.clear();
                            selectedStatus.clear();
                            setState(() {});
                          },
                          child: Icon(
                            Icons.highlight_remove,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 5),
              Expanded(
                child: ListView(
                  children: _buildTeethWidgets(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _buildTeethWidgets() {
    List<Widget> returnValue = [];
    for (var model in models) {
      returnValue.add(new _ToothWidget(
        viewOnlyMode: viewOnlyMode,
        key: GlobalKey(),
        toothID: model!.tooth!,
        onChange: () => setState(() {}),
      ));
      returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
    }
    if (viewOnlyMode) {
      returnValue.add(Expanded(child: SizedBox(height: 100)));
      returnValue.add(Expanded(
        child: Row(
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
                () {
                  int p = 0;
                  treatmentPlanModel.treatmentPlan!.forEach((element) {
                    if (element.scaling != null) p += element.scaling!.planPrice ?? 0;
                    if (element.crown != null) p += element.crown!.planPrice ?? 0;
                    if (element.restoration != null) p += element.restoration!.planPrice ?? 0;
                    if (element.rootCanalTreatment != null) p += element.rootCanalTreatment!.planPrice ?? 0;
                    if (element.extraction != null) p += element.extraction!.planPrice ?? 0;
                  });
                  return p.toString() + " EGP";
                }(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ));
    }

    return returnValue;
  }

  TreatmentPrices pricess = TreatmentPrices();

  Future<API_Response> myloadFunction() async {
    if (!isSurgical) {
      var res = await SettingsAPI.GetTreatmentPrices();
      if (res.statusCode == 200) pricess = res.result as TreatmentPrices;
      prices = pricess;
    }
    return isSurgical ? MedicalAPI.GetPatientSurgicalTreatment(widget.patientID) : MedicalAPI.GetPatientTreatmentPlan(widget.patientID);
  }

  late Future<API_Response> loadFunction;

  @override
  void initState() {
    isSurgical = widget.surgical;
    loadFunction = myloadFunction();
  }
}

class _ToothWidget extends StatelessWidget {
  _ToothWidget({Key? key, required this.toothID, required this.onChange, this.viewOnlyMode = false}) : super(key: key);
  bool viewOnlyMode;
  int toothID;
  Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildWidgets());
  }

  List<Widget> _buildWidgets() {
    List<Widget> returnValue = <Widget>[];

    var currentTooth = models.firstWhereOrNull((element) => element.tooth == toothID);
    if (currentTooth != null) {
      if (currentTooth!.simpleImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.simpleImplant!,
          title: "Simple Implant",
          onDelete: () {
            currentTooth!.simpleImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.immediateImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.immediateImplant!,
          title: "Immediate Implant",
          onDelete: () {
            currentTooth!.immediateImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.guidedImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.guidedImplant!,
          title: "Guided Implant",
          onDelete: () {
            currentTooth!.guidedImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.expansionWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.expansionWithImplant!,
          title: "Expansion With Implant",
          onDelete: () {
            currentTooth!.expansionWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.splittingWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.splittingWithImplant!,
          title: "Splitting With Implant",
          onDelete: () {
            currentTooth!.splittingWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.gbrWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.gbrWithImplant!,
          title: "GBR With Implant",
          onDelete: () {
            currentTooth!.gbrWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.openSinusWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.openSinusWithImplant!,
          title: "Open Sinus Wit Implant",
          onDelete: () {
            currentTooth!.openSinusWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.closedSinusWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.closedSinusWithImplant!,
          title: "Closed Sinus With Implant",
          onDelete: () {
            currentTooth!.closedSinusWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.expansionWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.expansionWithoutImplant!,
          title: "Expansion Without Implant",
          onDelete: () {
            currentTooth!.expansionWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.splittingWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.splittingWithoutImplant!,
          title: "Splitting Without Implant",
          onDelete: () {
            currentTooth!.splittingWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.gbrWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.gbrWithoutImplant!,
          title: "GBR Without Implant",
          onDelete: () {
            currentTooth!.gbrWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.openSinusWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.openSinusWithoutImplant!,
          title: "Open Sinus Without Implant",
          onDelete: () {
            currentTooth!.openSinusWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.closedSinusWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.closedSinusWithoutImplant!,
          title: "Closed Sinus Without Implant",
          onDelete: () {
            currentTooth!.closedSinusWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.extraction != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.extraction!,
          title: "Extraction",
          settingsPrice: prices.extraction,
          assignButton: true,
          price: true,
          onDelete: () {
            currentTooth!.extraction = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.restoration != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.restoration!,
          title: "Restoration",
          settingsPrice: prices.restoration,
          assignButton: true,
          price: true,
          onDelete: () {
            currentTooth!.restoration = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.rootCanalTreatment != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.rootCanalTreatment!,
          title: "Root Canal Treatment",
          assignButton: true,
          settingsPrice: prices.rootCanalTreatment,
          price: true,
          onDelete: () {
            currentTooth!.rootCanalTreatment = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.scaling != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.scaling!,
          title: "Scaling",
          price: true,
          settingsPrice: prices.scaling,
          onDelete: () {
            currentTooth!.scaling = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.crown != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          price: true,
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.crown!,
          title: "Crown",
          settingsPrice: prices.crown,
          onDelete: () {
            currentTooth!.crown = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.pontic != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 2));
        returnValue.add(_StatusWidget(
          viewOnlyMode: viewOnlyMode,
          fieldModel: currentTooth!.pontic!,
          title: "Pontic",
          onDelete: () {
            currentTooth!.pontic = null;
            onChange();
          },
        ));
      }
    }
    var title = <Widget>[
      Row(
        children: [
          Text(
            "Tooth",
            style: TextStyle(fontFamily: Inter_Bold, fontSize: viewOnlyMode ? 12 : 25),
          ),
          SizedBox(width: 30),
          FormTextValueWidget(text: toothID.toString()),
        ],
      ),
      SizedBox(height: viewOnlyMode ? 1 : 2),
    ];
    if (returnValue.isNotEmpty) {
      title.addAll(returnValue);
      returnValue = title;
    }

    return returnValue;
  }
}

class _StatusWidget extends StatefulWidget {
  _StatusWidget(
      {Key? key,
      required this.fieldModel,
      this.price = false,
      required this.title,
      this.onDelete,
      this.assignButton = false,
      this.isImplant = false,
      this.settingsPrice,
      this.viewOnlyMode = false})
      : super(key: key);
  TreatmentPlanFieldsModel fieldModel;
  String title;
  bool isImplant;
  bool assignButton;
  Function? onDelete;
  bool viewOnlyMode;
  bool price;
  int? settingsPrice;

  @override
  State<_StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<_StatusWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.viewOnlyMode) {
      return Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    if (widget.onDelete != null) widget.onDelete!();
                  },
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                )),
                Expanded(
                  child: isSurgical
                      ? RoundCheckBox(
                          isChecked: widget.fieldModel.status,
                          onTap: siteController.getRole() == "secretary"
                              ? null
                              : (selected) {
                                  widget.fieldModel.status = selected;
                                  if (selected!) {
                                    widget.fieldModel.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
                                    widget.fieldModel.doneByAssistantID = siteController.getUser().idInt;
                                    widget.fieldModel.date = DateTime.now().toUtc().toString();
                                  } else {
                                    widget.fieldModel.doneByAssistant = DropDownDTO();
                                    widget.fieldModel.doneByAssistantID = null;
                                  }
                                  setState(() {});
                                },
                          border: null,
                          borderColor: Colors.transparent,
                          uncheckedWidget: Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                          size: 30,
                        )
                      : widget.fieldModel.status!
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 18,
            child: Row(
              children: [
                Expanded(
                    flex: isSurgical ? 7 : 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(
                                text: widget.title,
                              ),
                              FormTextValueWidget(
                                text: ": ${widget.fieldModel.value ?? ""}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        widget.assignButton
                            ? Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Assigned to: ",
                                    ),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.assignedTo != null ? widget.fieldModel.assignedTo!.name ?? "" : "",
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    )),
                SizedBox(width: 10),
                isSurgical
                    ? Expanded(
                        flex: 9,
                        child: ElevatedButton(
                          onPressed: () {
                            List<DropDownDTO> companies = [];
                            int? companyID;
                            List<DropDownDTO> lines = [];
                            int? lineID;
                            List<DropDownDTO> implants = [];

                            CIA_ShowPopUp(
                                context: context,
                                title: "${widget.title} Data",
                                onSave: () => setState(() {}),
                                width: 900,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Implant Company",
                                                selectedItem: companies.firstWhereOrNull((element) => element.id == companyID),
                                                asyncItems: () async {
                                                  var res = await LoadinAPI.LoadImplantCompanies();
                                                  if (res.statusCode == 200) companies = res.result as List<DropDownDTO>;
                                                  return res;
                                                },
                                                onSelect: (value) {
                                                  companyID = value!.id!;

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Implant Lines",
                                                selectedItem: lines.firstWhereOrNull((element) => element.id == lineID),
                                                asyncItems: companyID == null
                                                    ? null
                                                    : () async {
                                                        var res = await LoadinAPI.LoadImplantLines(companyID!);
                                                        if (res.statusCode == 200) lines = res.result as List<DropDownDTO>;
                                                        return res;
                                                      },
                                                onSelect: (value) {
                                                  lineID = value!.id!;

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                selectedItem: widget.fieldModel.implant,
                                                label: "Size",
                                                asyncItems: lineID == null
                                                    ? null
                                                    : () async {
                                                        var res = await LoadinAPI.LoadImplants(lineID!);
                                                        if (res.statusCode == 200) implants = res.result as List<DropDownDTO>;
                                                        return res;
                                                      },
                                                onSelect: (value) {
                                                  widget.fieldModel.implant!.name = value.name;
                                                  widget.fieldModel.implantID = value.id;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        CIA_DropDownSearch(
                                          selectedItem: widget.fieldModel.doneBySupervisor,
                                          label: "Supervisor",
                                          asyncItems: LoadinAPI.LoadSupervisors,
                                          onSelect: (value) {
                                            widget.fieldModel.doneBySupervisor = value;
                                            widget.fieldModel.doneBySupervisorID = value.id;
                                          },
                                        ),
                                        CIA_DropDownSearch(
                                          selectedItem: widget.fieldModel.doneByCandidateBatch,
                                          label: "Candidate Batch",
                                          asyncItems: LoadinAPI.LoadCandidatesBatches,
                                          onSelect: (value) {
                                            widget.fieldModel.doneByCandidateBatch = value;
                                            widget.fieldModel.doneByCandidateBatchID = value.id;
                                            setState(() {});
                                          },
                                        ),
                                        CIA_DropDownSearch(
                                          selectedItem: widget.fieldModel.doneByCandidate,
                                          label: "Candidate",
                                          asyncItems: widget.fieldModel.doneByCandidateBatchID == null
                                              ? null
                                              : () async {
                                                  return await LoadinAPI.LoadCandidatesByBatchID(widget.fieldModel.doneByCandidateBatchID!);
                                                },
                                          onSelect: (value) {
                                            widget.fieldModel.doneByCandidate = value;
                                            widget.fieldModel.doneByCandidateID = value.id;
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        FormTextKeyWidget(
                                          text: "Candidate",
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                        FormTextValueWidget(
                                          text: widget.fieldModel.doneByCandidate!.name,
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        FormTextKeyWidget(
                                          text: "Batch",
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                        FormTextValueWidget(
                                          text: widget.fieldModel.doneByCandidateBatch!.name,
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        FormTextKeyWidget(
                                          text: "Assistant",
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                        FormTextValueWidget(
                                          text: widget.fieldModel.doneByAssistant!.name,
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        FormTextKeyWidget(
                                          text: "Supervisor",
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                        FormTextValueWidget(
                                          text: widget.fieldModel.doneBySupervisor!.name,
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        FormTextKeyWidget(
                                          text: "Implant",
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                        FormTextValueWidget(
                                          text: widget.fieldModel.implant == null ? "" : widget.fieldModel.implant!.name,
                                          smallFont: true,
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                    : widget.assignButton && !widget.viewOnlyMode
                        ? Expanded(
                            child: Row(
                            children: [
                              Expanded(
                                child: CIA_DropDownSearch(
                                  label: "Assign to assistant",
                                  onSelect: (value) {
                                    widget.fieldModel.assignedTo = value;
                                    widget.fieldModel.assignedToID = value.id;
                                  },
                                  selectedItem: widget.fieldModel.assignedTo,
                                  asyncItems: LoadinAPI.LoadAssistants,
                                ),
                              ),
                              SizedBox(width: 10)
                            ],
                          ))
                        : SizedBox(width: 10),
                Expanded(
                    child: Row(
                  children: [
                    FormTextKeyWidget(text: "Price: "),
                    FormTextKeyWidget(
                        text: (widget.fieldModel.planPrice != 0 && widget.fieldModel.planPrice != null
                                ? widget.fieldModel.planPrice ?? widget.settingsPrice
                                : widget.settingsPrice)
                            .toString()),
                  ],
                ))
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: IconButton(
                onPressed: () {
                  if (widget.onDelete != null) widget.onDelete!();
                },
                icon: Icon(Icons.delete_forever),
                color: Colors.red,
              )),
              Expanded(
                child: isSurgical
                    ? RoundCheckBox(
                        isChecked: widget.fieldModel.status,
                        onTap: siteController.getRole() == "secretary"
                            ? null
                            : (selected) {
                                widget.fieldModel.status = selected;
                                if (selected!) {
                                  widget.fieldModel.doneByAssistant = DropDownDTO(name: siteController.getUser().name, id: siteController.getUser().idInt);
                                  widget.fieldModel.doneByAssistantID = siteController.getUser().idInt;
                                  widget.fieldModel.date = DateTime.now().toUtc().toString();
                                } else {
                                  widget.fieldModel.doneByAssistant = DropDownDTO();
                                  widget.fieldModel.doneByAssistantID = null;
                                }
                                setState(() {});
                              },
                        border: null,
                        borderColor: Colors.transparent,
                        uncheckedWidget: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        size: 30,
                      )
                    : widget.fieldModel.status!
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 18,
          child: Row(
            children: [
              Expanded(
                flex: isSurgical
                    ? 7
                    : widget.price
                        ? 2
                        : 3,
                child: CIA_TextFormField(
                  onChange: (value) {
                    widget.fieldModel.value = value;
                  },
                  label: widget.title,
                  controller: TextEditingController(
                    text: (widget.fieldModel.value),
                  ),
                ),
              ),
              SizedBox(width: 10),
              widget.price
                  ? Expanded(
                      child: CIA_TextFormField(
                      suffix: "EGP",
                      label: 'Price',
                      isNumber: true,
                      onChange: (v) => widget.fieldModel.planPrice = int.parse(v),
                      controller: TextEditingController(text: () {
                        if (widget.fieldModel.planPrice != null && widget.fieldModel.planPrice != 0)
                          return widget.fieldModel.planPrice.toString();
                        else
                          return widget.settingsPrice.toString();
                      }()),
                    ))
                  : SizedBox(),
              SizedBox(width: 10),
              isSurgical
                  ? Expanded(
                      flex: 9,
                      child: ElevatedButton(
                        onPressed: () {
                          List<DropDownDTO> companies = [];
                          int? companyID;
                          List<DropDownDTO> lines = [];
                          int? lineID;
                          List<DropDownDTO> implants = [];

                          CIA_ShowPopUp(
                              context: context,
                              title: "${widget.title} Data",
                              onSave: () => setState(() {}),
                              width: 900,
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              label: "Implant Company",
                                              selectedItem: companies.firstWhereOrNull((element) => element.id == companyID),
                                              asyncItems: () async {
                                                var res = await LoadinAPI.LoadImplantCompanies();
                                                if (res.statusCode == 200) companies = res.result as List<DropDownDTO>;
                                                return res;
                                              },
                                              onSelect: (value) {
                                                companyID = value!.id!;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              label: "Implant Lines",
                                              selectedItem: lines.firstWhereOrNull((element) => element.id == lineID),
                                              asyncItems: companyID == null
                                                  ? null
                                                  : () async {
                                                      var res = await LoadinAPI.LoadImplantLines(companyID!);
                                                      if (res.statusCode == 200) lines = res.result as List<DropDownDTO>;
                                                      return res;
                                                    },
                                              onSelect: (value) {
                                                lineID = value!.id!;

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: CIA_DropDownSearch(
                                              selectedItem: widget.fieldModel.implant,
                                              label: "Size",
                                              asyncItems: lineID == null
                                                  ? null
                                                  : () async {
                                                      var res = await LoadinAPI.LoadImplants(lineID!);
                                                      if (res.statusCode == 200) implants = res.result as List<DropDownDTO>;
                                                      return res;
                                                    },
                                              onSelect: (value) async{
                                                widget.fieldModel.implant!.name = value.name;
                                                widget.fieldModel.implantID = value.id;
                                                await CIA_ShowPopUpYesNo(context: context,
                                                    title: "Consume Implant ${widget.fieldModel.implant!.name}?",
                                                    onSave: ()async{
                                                  var res =await  MedicalAPI.ConsumeImplant(widget.fieldModel.implantID!);
                                                  ShowSnackBar(isSuccess: res.statusCode==200,message: res.errorMessage??"");
                                                });
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      CIA_DropDownSearch(
                                        selectedItem: widget.fieldModel.doneBySupervisor,
                                        label: "Supervisor",
                                        asyncItems: LoadinAPI.LoadSupervisors,
                                        onSelect: (value) {
                                          widget.fieldModel.doneBySupervisor = value;
                                          widget.fieldModel.doneBySupervisorID = value.id;
                                        },
                                      ),
                                      CIA_DropDownSearch(
                                        selectedItem: widget.fieldModel.doneByCandidateBatch,
                                        label: "Candidate Batch",
                                        asyncItems: LoadinAPI.LoadCandidatesBatches,
                                        onSelect: (value) {
                                          widget.fieldModel.doneByCandidateBatch = value;
                                          widget.fieldModel.doneByCandidateBatchID = value.id;
                                          setState(() {});
                                        },
                                      ),
                                      CIA_DropDownSearch(
                                        selectedItem: widget.fieldModel.doneByCandidate,
                                        label: "Candidate",
                                        asyncItems: widget.fieldModel.doneByCandidateBatchID == null
                                            ? null
                                            : () async {
                                                return await LoadinAPI.LoadCandidatesByBatchID(widget.fieldModel.doneByCandidateBatchID!);
                                              },
                                        onSelect: (value) {
                                          widget.fieldModel.doneByCandidate = value;
                                          widget.fieldModel.doneByCandidateID = value.id;
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(
                                        text: "Candidate",
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                      FormTextValueWidget(
                                        text: widget.fieldModel.doneByCandidate!.name,
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(
                                        text: "Batch",
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                      FormTextValueWidget(
                                        text: widget.fieldModel.doneByCandidateBatch!.name,
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(
                                        text: "Assistant",
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                      FormTextValueWidget(
                                        text: widget.fieldModel.doneByAssistant!.name,
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(
                                        text: "Supervisor",
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                      FormTextValueWidget(
                                        text: widget.fieldModel.doneBySupervisor!.name,
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      FormTextKeyWidget(
                                        text: "Implant",
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                      FormTextValueWidget(
                                        text: widget.fieldModel.implant == null ? "" : widget.fieldModel.implant!.name,
                                        smallFont: true,
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  : widget.assignButton
                      ? Expanded(
                          child: Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Assign to assistant",
                                onSelect: (value) {
                                  widget.fieldModel.assignedTo = value;
                                  widget.fieldModel.assignedToID = value.id;
                                },
                                selectedItem: widget.fieldModel.assignedTo,
                                asyncItems: LoadinAPI.LoadAssistants,
                              ),
                            ),
                            SizedBox(width: 10)
                          ],
                        ))
                      : SizedBox(),
              //SizedBox(width: 10)
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    if (widget.price && widget.fieldModel.planPrice == null || widget.fieldModel.planPrice == 0) widget.fieldModel.planPrice = widget.fieldModel.price;
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
                  Column(
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
                                    label: "Implant Subcrestal", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal!),
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
                                CIA_MultiSelectChipWidgeModel(label: "Crown", isSelected: surgicalTreatmentModel.sutureAndTemporizationAndXRayTemporaryCrown!),
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
                  Column(
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
                                      CIA_MultiSelectChipWidgeModel(label: "Ramus", isSelected: surgicalTreatmentModel.guidedBoneRegenerationBlockGraftRamus!),
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
                                surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber = value;
                              },
                              controller: TextEditingController(
                                text: surgicalTreatmentModel.guidedBoneRegenerationCutByScrewsNumber ?? "",
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CIA_MultiSelectChipWidget(
                                    onChange: (item, isSelected) {
                                      switch (item) {
                                        case "100% Autogenous":
                                          surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous = isSelected;
                                          break;
                                        case "100% Xenograft":
                                          surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Xenograft = isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "100% Autogenous", isSelected: surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Autogenous!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "100% Xenograft", isSelected: surgicalTreatmentModel.guidedBoneRegenerationBoneParticle100Xenograft!),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Auto Xeno %",
                                    suffix: "%",
                                    onChange: (value) {
                                      surgicalTreatmentModel.guidedBoneRegenerationBoneParticleXenograftPercent = value;
                                    },
                                    controller: TextEditingController(
                                      text: surgicalTreatmentModel.guidedBoneRegenerationBoneParticleXenograftPercent ?? "",
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
                  Column(
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
                                              : companies.firstWhereOrNull((element) => element.id == surgicalTreatmentModel.openSinusLift_Membrane_CompanyID),
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
                                                  name: surgicalTreatmentModel.openSinusLift_Membrane!.size,
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
                              int availableNumber = 0;
                              List<TacCompanyModel> tacs = [];
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
                                            surgicalTreatmentModel.openSinusLift_TacsCompanyID = value.id;
                                            surgicalTreatmentModel.openSinusLift_TacsCompany = tacs.firstWhere((element) => element.id == value.id);
                                            availableNumber = surgicalTreatmentModel.openSinusLift_TacsCompany!.count ?? 0;
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
                                      Expanded(child: FormTextValueWidget(text: "Available number: $availableNumber"))
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
                  Column(
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
                                                  label: "Free Gingival Graft", isSelected: surgicalTreatmentModel.softTissueGraftSurgeryTypeFreeGinivalGraft!),
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
                ],
              ),
            ),
          ],
        ));
  }
}
