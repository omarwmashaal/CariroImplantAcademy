import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/Fonts.dart';
import '../Controllers/PatientMedicalController.dart';
import '../Models/API_Response.dart';
import '../Models/TreatmentPlanModel.dart';
import 'CIA_TextFormField.dart';
import 'FormTextWidget.dart';
import 'MultiSelectChipWidget.dart';

// TODO: Listen to models and higlight chips
class CIA_TeethTreatmentPlanWidget extends StatefulWidget {
  CIA_TeethTreatmentPlanWidget({Key? key, required this.patientID})
      : super(key: key);

  int patientID;

  @override
  State<CIA_TeethTreatmentPlanWidget> createState() =>
      _CIA_TeethTreatmentPlanWidgetState();
}

late List<TreatmentPlanSubModel> models;

class _CIA_TeethTreatmentPlanWidgetState
    extends State<CIA_TeethTreatmentPlanWidget> {
  List<String> selectedTeeth = [];
  List<String> selectedStatus = [];
  bool tickVisible = false;

  _updateTeethStatus(List<int> teeth, String status) {
    for (int tooth in teeth) {
      var currentTooth =
          models.firstWhereOrNull((element) => element.tooth == tooth);
      if (currentTooth == null) {
        currentTooth =
            new TreatmentPlanSubModel(tooth: tooth, patientId: patientID);
        models.add(currentTooth);
      }
      switch (status) {
        case "Simple Implant":
          {
            if (currentTooth.simpleImplant == null)
              currentTooth.simpleImplant = TreatmentPlanFieldsModel();
            break;
          }

        case "Immediate Implant":
          {
            if (currentTooth.immediateImplant == null)
              currentTooth.immediateImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Expansion With Implant":
          {
            if (currentTooth.expansionWithImplant == null)
              currentTooth.expansionWithImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Splitting With Implant":
          {
            if (currentTooth.splittingWithImplant == null)
              currentTooth.splittingWithImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "GBR With Implant":
          {
            if (currentTooth.gbrWithImplant == null)
              currentTooth.gbrWithImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Open Sinus With Implant":
          {
            if (currentTooth.openSinusWithImplant == null)
              currentTooth.openSinusWithImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Closed Sinus With Implant":
          {
            if (currentTooth.closedSinusWithImplant == null)
              currentTooth.closedSinusWithImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Expansion Without Implant":
          {
            if (currentTooth.expansionWithoutImplant == null)
              currentTooth.expansionWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Splitting Without Implant":
          {
            if (currentTooth.splittingWithoutImplant == null)
              currentTooth.splittingWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "GBR Without Implant":
          {
            if (currentTooth.gbrWithoutImplant == null)
              currentTooth.gbrWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Open Sinus Without Implant":
          {
            if (currentTooth.openSinusWithoutImplant == null)
              currentTooth.openSinusWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Closed Sinus Without Implant":
          {
            if (currentTooth.closedSinusWithoutImplant == null)
              currentTooth.closedSinusWithoutImplant =
                  TreatmentPlanFieldsModel();
            break;
          }
        case "Guided Implant":
          {
            if (currentTooth.guidedImplant == null)
              currentTooth.guidedImplant = TreatmentPlanFieldsModel();
            break;
          }

        case "Pontic":
          {
            if (currentTooth.pontic == null)
              currentTooth.pontic = TreatmentPlanFieldsModel();
            break;
          }
        case "Extraction":
          {
            if (currentTooth.extraction == null)
              currentTooth.extraction = TreatmentPlanFieldsModel();
            break;
          }
        case "Restoration":
          {
            if (currentTooth.restoration == null)
              currentTooth.restoration = TreatmentPlanFieldsModel();
            break;
          }
        case "Root Canal Treatment":
          {
            if (currentTooth.rootCanalTreatment == null)
              currentTooth.rootCanalTreatment = TreatmentPlanFieldsModel();
            break;
          }
      }
    }
  }

  _updateTeethMultiStatus(List<String> teeth, List<String> status) {
    for (String s in status) {
      _updateTeethStatus(teeth.map((e) => int.parse(e)).toList(), s);
    }
  }

  _removeTeethStatus(List<int> teeth, String status) {
    for (int tooth in teeth) {
      var currentTooth =
          models.firstWhereOrNull((element) => element.tooth == tooth);
      if (currentTooth == null) {
        currentTooth = new TreatmentPlanSubModel();
        models.add(currentTooth);
      }
      switch (status) {
        case "Extraction":
          {
            if (currentTooth.extraction == null)
              currentTooth.extraction = TreatmentPlanFieldsModel();
            break;
          }

        case "SimpleImplant":
          {
            if (currentTooth.simpleImplant == null)
              currentTooth.simpleImplant = TreatmentPlanFieldsModel();
            break;

            break;
          }
        case "Immediate Implant":
          {
            if (currentTooth.immediateImplant == null)
              currentTooth.immediateImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Expansion":
          {
            if (currentTooth.expansionWithoutImplant == null)
              currentTooth.expansionWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Splitting":
          {
            if (currentTooth.splittingWithoutImplant == null)
              currentTooth.splittingWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "GBR":
          {
            if (currentTooth.gbrWithoutImplant == null)
              currentTooth.gbrWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Open Sinus":
          {
            if (currentTooth.openSinusWithoutImplant == null)
              currentTooth.openSinusWithoutImplant = TreatmentPlanFieldsModel();
            break;
          }
        case "Closed Sinus":
          {
            if (currentTooth.closedSinusWithoutImplant == null)
              currentTooth.closedSinusWithoutImplant =
                  TreatmentPlanFieldsModel();
            break;
          }
        case "Guided Implant":
          {
            if (currentTooth.guidedImplant == null)
              currentTooth.guidedImplant = TreatmentPlanFieldsModel();
            break;
          }

        case "Pontic":
          {
            if (currentTooth.pontic == null)
              currentTooth.pontic = TreatmentPlanFieldsModel();
            break;
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedTeeth.isEmpty) {
      selectedStatus.clear();
      tickVisible = false;
      setState(() {});
    }
    return CIA_FutureBuilder(
      loadFunction: loadFucntion,
      onSuccess: (data) {
        treatmentPlanModel = data as TreatmentPlanModel;
        models = treatmentPlanModel.treatmentPlan ?? [];
        return FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth = selectedItems;
                        setState(() {
                          tickVisible = true;
                        });
                        setState(() {});
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                            label: "11",
                            isSelected: selectedTeeth.contains("11")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "12",
                            isSelected: selectedTeeth.contains("12")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "13",
                            isSelected: selectedTeeth.contains("13")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "14",
                            isSelected: selectedTeeth.contains("14")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "15",
                            isSelected: selectedTeeth.contains("15")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "16",
                            isSelected: selectedTeeth.contains("16")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "17",
                            isSelected: selectedTeeth.contains("17")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "18",
                            isSelected: selectedTeeth.contains("18")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "19",
                            isSelected: selectedTeeth.contains("19"))
                      ],
                    ),
                  ),
                  SizedBox(),
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth = selectedItems;
                        setState(() {
                          tickVisible = true;
                        });
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                            label: "21",
                            isSelected: selectedTeeth.contains("21")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "22",
                            isSelected: selectedTeeth.contains("22")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "23",
                            isSelected: selectedTeeth.contains("23")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "24",
                            isSelected: selectedTeeth.contains("24")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "25",
                            isSelected: selectedTeeth.contains("25")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "26",
                            isSelected: selectedTeeth.contains("26")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "27",
                            isSelected: selectedTeeth.contains("27")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "28",
                            isSelected: selectedTeeth.contains("28")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "29",
                            isSelected: selectedTeeth.contains("29"))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth = selectedItems;
                        setState(() {
                          tickVisible = true;
                        });
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                            label: "31",
                            isSelected: selectedTeeth.contains("31")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "32",
                            isSelected: selectedTeeth.contains("32")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "33",
                            isSelected: selectedTeeth.contains("33")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "34",
                            isSelected: selectedTeeth.contains("34")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "35",
                            isSelected: selectedTeeth.contains("35")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "36",
                            isSelected: selectedTeeth.contains("36")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "37",
                            isSelected: selectedTeeth.contains("37")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "38",
                            isSelected: selectedTeeth.contains("38")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "39",
                            isSelected: selectedTeeth.contains("39"))
                      ],
                    ),
                  ),
                  SizedBox(),
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth = selectedItems;
                        setState(() {
                          tickVisible = true;
                        });
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                            label: "41",
                            isSelected: selectedTeeth.contains("41")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "42",
                            isSelected: selectedTeeth.contains("42")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "43",
                            isSelected: selectedTeeth.contains("43")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "44",
                            isSelected: selectedTeeth.contains("44")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "45",
                            isSelected: selectedTeeth.contains("45")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "46",
                            isSelected: selectedTeeth.contains("46")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "47",
                            isSelected: selectedTeeth.contains("47")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "48",
                            isSelected: selectedTeeth.contains("48")),
                        CIA_MultiSelectChipWidgeModel(
                            label: "49",
                            isSelected: selectedTeeth.contains("49"))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CIA_MultiSelectChipWidget(
                  key: GlobalKey(),
                  onChangeList: (selectedItems) {
                    if (selectedTeeth.isEmpty) {
                      setState(() {});
                    } else
                      selectedStatus = selectedItems;
                  },
                  /*onChange: (item, isSelected) {
                    if (!isSelected) {
                      _removeTeethStatus(
                          selectedTeeth.map((e) => int.parse(e)).toList(),
                          item);
                      setState(() {});
                    }
                  },*/
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
                  ]),
              Visibility(
                visible: tickVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _updateTeethMultiStatus(selectedTeeth, selectedStatus);
                        tickVisible = false;
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
                        tickVisible = false;
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
              ),
              SizedBox(height: 10),
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
    List<Widget> returnValue = <Widget>[];
    for (var model in models) {
      returnValue.add(new _ToothWidget(
        key: GlobalKey(),
        toothID: model!.tooth!,
        onChange: () => setState(() {}),
      ));
      returnValue.add(SizedBox(height: 20));
    }
    return returnValue;
  }

  late Future<API_Response> loadFucntion;

  @override
  void initState() {
    loadFucntion = MedicalAPI.GetPatientTreatmentPlan(widget.patientID);
  }
}

class _ToothWidget extends StatelessWidget {
  _ToothWidget({Key? key, required this.toothID, required this.onChange})
      : super(key: key);

  int toothID;
  Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildWidgets());
  }

  List<Widget> _buildWidgets() {
    List<Widget> returnValue = <Widget>[];

    var currentTooth =
        models.firstWhereOrNull((element) => element.tooth == toothID);
    if (currentTooth != null) {
      if (currentTooth!.simpleImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.simpleImplant!,
          title: "Simple Implant",
          onDelete: () {
            currentTooth!.simpleImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.immediateImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.immediateImplant!,
          title: "Immediate Implant",
          onDelete: () {
            currentTooth!.immediateImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.guidedImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.guidedImplant!,
          title: "Guided Implant",
          onDelete: () {
            currentTooth!.guidedImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.expansionWithImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.expansionWithImplant!,
          title: "Expansion With Implant",
          onDelete: () {
            currentTooth!.expansionWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.splittingWithImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.splittingWithImplant!,
          title: "Splitting Without Implant",
          onDelete: () {
            currentTooth!.splittingWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.gbrWithImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.gbrWithImplant!,
          title: "GBR Without Implant",
          onDelete: () {
            currentTooth!.gbrWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.openSinusWithImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.openSinusWithImplant!,
          title: "Open Sinus Without Implant",
          onDelete: () {
            currentTooth!.openSinusWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.closedSinusWithImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.closedSinusWithImplant!,
          title: "Closed Sinus Without Implant",
          onDelete: () {
            currentTooth!.closedSinusWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.expansionWithoutImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.expansionWithoutImplant!,
          title: "Expansion Without Implant",
          onDelete: () {
            currentTooth!.expansionWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.splittingWithoutImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.splittingWithoutImplant!,
          title: "Splitting Without Implant",
          onDelete: () {
            currentTooth!.splittingWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.gbrWithoutImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.gbrWithoutImplant!,
          title: "GBR Without Implant",
          onDelete: () {
            currentTooth!.gbrWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.openSinusWithoutImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.openSinusWithoutImplant!,
          title: "Open Sinus Without Implant",
          onDelete: () {
            currentTooth!.openSinusWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.closedSinusWithoutImplant != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.closedSinusWithoutImplant!,
          title: "Closed Sinus Without Implant",
          onDelete: () {
            currentTooth!.closedSinusWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.extraction != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.extraction!,
          title: "Extraction",
          assignButton: true,
          onDelete: () {
            currentTooth!.extraction = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.restoration != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.restoration!,
          title: "Restoration",
          assignButton: true,
          onDelete: () {
            currentTooth!.restoration = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.rootCanalTreatment != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
          fieldModel: currentTooth!.rootCanalTreatment!,
          title: "Root Canal Treatment",
          assignButton: true,
          onDelete: () {
            currentTooth!.rootCanalTreatment = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.pontic != null) {
        returnValue.add(SizedBox(height: 10));
        returnValue.add(_StatusWidget(
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
            style: TextStyle(fontFamily: Inter_Bold, fontSize: 25),
          ),
          SizedBox(width: 30),
          FormTextValueWidget(text: toothID.toString()),
        ],
      ),
      SizedBox(height: 10),
    ];
    if (returnValue.isNotEmpty) {
      title.addAll(returnValue);
      returnValue = title;
    }

    return returnValue;
  }
}

class _StatusWidget extends StatelessWidget {
  _StatusWidget(
      {Key? key,
      required this.fieldModel,
      required this.title,
      this.onDelete,
      this.assignButton = false,
      this.isImplant = false})
      : super(key: key);
  TreatmentPlanFieldsModel fieldModel;
  String title;
  bool isImplant;
  bool assignButton;
  Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: IconButton(
                    onPressed: () {
                      if (onDelete != null) onDelete!();
                    },
                    icon: Icon(Icons.delete_forever),
                    color: Colors.red,
                  )),
              Expanded(
                  flex: 5,
                  child: fieldModel.status!
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.remove,
                          color: Colors.red,
                        )),
            ],
          ),
        ),
        Expanded(
          flex:19,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CIA_TextFormField(
                  onChange: (value) {
                    fieldModel.value = value;
                  },
                  label: title,
                  controller: TextEditingController(
                    text: (fieldModel.value),
                  ),
                ),
              ),
              assignButton?Expanded(
                  child: Row(
                    children: [
                      SizedBox(width:10),
                      Expanded(
                        child: CIA_DropDown(
                          label: "Assign to",
                          values: ["Name", "Name"],
                        ),
                      ),
                    ],
                  )):SizedBox(),
              SizedBox(width:10)
            ],
          ),
        ),
      ],
    );
  }
}
