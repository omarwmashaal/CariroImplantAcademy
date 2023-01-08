import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Fonts.dart';
import '../Controllers/PatientMedicalController.dart';
import '../Models/TreatmentPlanModel.dart';
import 'CIA_TextFormField.dart';
import 'FormTextWidget.dart';

// TODO: Listen to models and higlight chips
class CIA_TeethSurgicalTreatmentWidget extends StatefulWidget {
  CIA_TeethSurgicalTreatmentWidget({Key? key, required this.controller})
      : super(key: key);

  PatientMedicalController controller;

  @override
  State<CIA_TeethSurgicalTreatmentWidget> createState() =>
      _CIA_TeethSurgicalTreatmentWidgetState();
}

Map<String, TreatmentPlanModel> models = Map<String, TreatmentPlanModel>();

class _CIA_TeethSurgicalTreatmentWidgetState
    extends State<CIA_TeethSurgicalTreatmentWidget> {
  List<String> selectedTeeth = [];
  List<String> selectedStatus = [];
  bool tickVisible = false;
  @override
  void initState() {
    models = widget.controller.TreatmentPlan;
  }

  /*_updateTeethStatus(List<String> teeth, String status) {
    for (String tooth in teeth) {
      if (models[tooth] == null) models[tooth] = new TreatmentPlanModel();
      switch (status) {
        case "extraction":
          {
            models[tooth]?.extraction = models[tooth]?.extraction == null
                ? ""
                : models[tooth]?.extraction;
            break;
          }

        case "simpleImplant":
          {
            models[tooth]?.simpleImplant = models[tooth]?.simpleImplant == null
                ? ""
                : models[tooth]?.simpleImplant;

            break;
          }
        case "immediateImplant":
          {
            models[tooth]?.immediateImplant =
                models[tooth]?.immediateImplant == null
                    ? ""
                    : models[tooth]?.immediateImplant;
            break;
          }
        case "expansion":
          {
            models[tooth]?.expansion = models[tooth]?.expansion == null
                ? ""
                : models[tooth]?.expansion;
            break;
          }
        case "splitting":
          {
            models[tooth]?.splitting = models[tooth]?.splitting == null
                ? ""
                : models[tooth]?.splitting;
            break;
          }
        case "gbr":
          {
            models[tooth]?.gbr =
                models[tooth]?.gbr == null ? "" : models[tooth]?.gbr;
            break;
          }
        case "openSinus":
          {
            models[tooth]?.openSinus = models[tooth]?.openSinus == null
                ? ""
                : models[tooth]?.openSinus;
            break;
          }
        case "closedSinus":
          {
            models[tooth]?.closedSinus = models[tooth]?.closedSinus == null
                ? ""
                : models[tooth]?.closedSinus;
            break;
          }
        case "guidedImplant":
          {
            models[tooth]?.guidedImplant = models[tooth]?.guidedImplant == null
                ? ""
                : models[tooth]?.guidedImplant;
            break;
          }

        case "bontic":
          {
            models[tooth]?.bontic =
                models[tooth]?.bontic == null ? "" : models[tooth]?.bontic;
            break;
          }
      }
    }
  }

  _updateTeethMultiStatus(List<String> teeth, List<String> status) {
    for (String s in status) {
      _updateTeethStatus(teeth, s);
    }
  }

  _removeTeethStatus(List<String> teeth, String status) {
    for (String tooth in teeth) {
      if (models[tooth] != null) {
        switch (status) {
          case "extraction":
            {
              models[tooth]?.extraction = null;
              break;
            }

          case "simpleImplant":
            {
              models[tooth]?.simpleImplant = null;

              break;
            }
          case "immediateImplant":
            {
              models[tooth]?.immediateImplant = null;
              break;
            }
          case "expansion":
            {
              models[tooth]?.expansion = null;
              break;
            }
          case "splitting":
            {
              models[tooth]?.splitting = null;
              break;
            }
          case "gbr":
            {
              models[tooth]?.extraction = null;
              break;
            }
          case "openSinus":
            {
              models[tooth]?.openSinus = null;
              break;
            }
          case "closedSinus":
            {
              models[tooth]?.closedSinus = null;
              break;
            }
          case "guidedImplant":
            {
              models[tooth]?.guidedImplant = null;
              break;
            }
          case "bontic":
            {
              models[tooth]?.bontic = null;
              break;
            }
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
                        label: "11", isSelected: selectedTeeth.contains("11")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "12", isSelected: selectedTeeth.contains("12")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "13", isSelected: selectedTeeth.contains("13")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "14", isSelected: selectedTeeth.contains("14")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "15", isSelected: selectedTeeth.contains("15")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "16", isSelected: selectedTeeth.contains("16")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "17", isSelected: selectedTeeth.contains("17")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "18", isSelected: selectedTeeth.contains("18")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "19", isSelected: selectedTeeth.contains("19"))
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
                        label: "21", isSelected: selectedTeeth.contains("21")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "22", isSelected: selectedTeeth.contains("22")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "23", isSelected: selectedTeeth.contains("23")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "24", isSelected: selectedTeeth.contains("24")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "25", isSelected: selectedTeeth.contains("25")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "26", isSelected: selectedTeeth.contains("26")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "27", isSelected: selectedTeeth.contains("27")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "28", isSelected: selectedTeeth.contains("28")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "29", isSelected: selectedTeeth.contains("29"))
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
                        label: "31", isSelected: selectedTeeth.contains("31")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "32", isSelected: selectedTeeth.contains("32")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "33", isSelected: selectedTeeth.contains("33")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "34", isSelected: selectedTeeth.contains("34")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "35", isSelected: selectedTeeth.contains("35")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "36", isSelected: selectedTeeth.contains("36")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "37", isSelected: selectedTeeth.contains("37")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "38", isSelected: selectedTeeth.contains("38")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "39", isSelected: selectedTeeth.contains("39"))
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
                        label: "41", isSelected: selectedTeeth.contains("41")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "42", isSelected: selectedTeeth.contains("42")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "43", isSelected: selectedTeeth.contains("43")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "44", isSelected: selectedTeeth.contains("44")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "45", isSelected: selectedTeeth.contains("45")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "46", isSelected: selectedTeeth.contains("46")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "47", isSelected: selectedTeeth.contains("47")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "48", isSelected: selectedTeeth.contains("48")),
                    CIA_MultiSelectChipWidgeModel(
                        label: "49", isSelected: selectedTeeth.contains("49"))
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
              onChange: (item, isSelected) {
                if (!isSelected) {
                  _removeTeethStatus(selectedTeeth, item);
                  setState(() {});
                }
              },
              labels: [
                CIA_MultiSelectChipWidgeModel(
                    label: "Extraction",
                    value: "extraction",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.extraction != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Simple Implant",
                    value: "simpleImplant",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.simpleImplant != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Immediate Implant",
                    value: "immediateImplant",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.immediateImplant != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Guided Implant",
                    value: "guidedImplant",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.guidedImplant != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Expansion",
                    value: "expansion",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.expansion != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Splitting",
                    value: "splitting",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.splitting != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "GBR",
                    value: "gbr",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.gbr != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Open Sinus",
                    value: "openSinus",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.openSinus != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Closed Sinus",
                    value: "closedSinus",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.closedSinus != null
                        : false),
                CIA_MultiSelectChipWidgeModel(
                    label: "Bontic",
                    value: "bontic",
                    isSelected: models.isNotEmpty &&
                            selectedTeeth.length == 1 &&
                            selectedTeeth.isNotEmpty &&
                            models.containsKey(selectedTeeth[0])
                        ? models[selectedTeeth[0]]?.bontic != null
                        : false),
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  /*_buildTeethWidgets() {
    List<Widget> returnValue = <Widget>[];
    for (String tooth in models.keys) {
      returnValue.add(new _ToothWidget(
        key: GlobalKey(),
        toothID: tooth,
        onChange: () => setState(() {}),
      ));
      returnValue.add(SizedBox(height: 20));
    }
    return returnValue;
  }*/
}

class _ToothWidget extends StatelessWidget {
  _ToothWidget({Key? key, required this.toothID, required this.onChange})
      : super(key: key);

  String toothID;
  Function onChange;
  Map<String, dynamic> myModel = Map<String, dynamic>();

  @override
  Widget build(BuildContext context) {
    myModel = (models[toothID] as TreatmentPlanModel).toJson();
    return Column(children: _buildWidgets(myModel));
  }

  List<Widget> _buildWidgets(Map<String, dynamic> myModel) {
    List<Widget> returnValue = <Widget>[];
    returnValue.addAll([
      Row(
        children: [
          Text(
            "Tooth",
            style: TextStyle(fontFamily: Inter_Bold, fontSize: 25),
          ),
          SizedBox(width: 30),
          FormTextValueWidget(text: toothID),
        ],
      ),
      SizedBox(height: 10),
    ]);
    for (String stat in myModel.keys) {
      if (myModel[stat] != null) {
        returnValue.add(SizedBox(height: 10));
        switch (stat) {
          case "extraction":
            {
              returnValue.add(
                Row(
                  children: [
                    Expanded(
                      flex: 62,
                      child: CIA_TextFormField(
                        onChange: (value) {
                          models[toothID]?.extraction = value;
                        },
                        label: 'Extraction',
                        controller: TextEditingController(
                          text: myModel[stat],
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child: CIA_DropDown(
                          label: "Assign to",
                          values: ["Name", "Name"],
                        )),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child:
                            CIA_SecondaryButton(label: "Assign", onTab: () {}))
                  ],
                ),
              );
              break;
            }

          case "simpleImplant":
            {
              returnValue.add(
                Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: CIA_TextFormField(
                        onChange: (value) {
                          models[toothID]?.simpleImplant = value;
                        },
                        label: 'Simple Implant',
                        controller: TextEditingController(
                          text: myModel[stat],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 20,
                      child: CIA_DropDown(label: "Implant Size", values: [
                        "values",
                        "values",
                      ]),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 20,
                      child: CIA_DropDown(label: "Implant Type", values: [
                        "values",
                        "values",
                      ]),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child: CIA_DropDown(
                          label: "Assign to",
                          values: ["Name", "Name"],
                        )),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child:
                            CIA_SecondaryButton(label: "Assign", onTab: () {}))
                  ],
                ),
              );
              break;
            }
          case "immediateImplant":
            {
              returnValue.add(
                Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: CIA_TextFormField(
                        onChange: (value) {
                          models[toothID]?.immediateImplant = value;
                        },
                        label: 'Immediate Implant',
                        controller: TextEditingController(
                          text: myModel[stat],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 20,
                      child: CIA_DropDown(label: "Implant Size", values: [
                        "values",
                        "values",
                      ]),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 20,
                      child: CIA_DropDown(label: "Implant Type", values: [
                        "values",
                        "values",
                      ]),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child: CIA_DropDown(
                          label: "Assign to",
                          values: ["Name", "Name"],
                        )),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child:
                            CIA_SecondaryButton(label: "Assign", onTab: () {}))
                  ],
                ),
              );
              break;
            }
          case "guidedImplant":
            {
              returnValue.add(
                Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: CIA_TextFormField(
                        onChange: (value) {
                          models[toothID]?.guidedImplant = value;
                        },
                        label: 'Guided Implant',
                        controller: TextEditingController(
                          text: myModel[stat],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 20,
                      child: CIA_DropDown(label: "Implant Size", values: [
                        "values",
                        "values",
                      ]),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 20,
                      child: CIA_DropDown(label: "Implant Type", values: [
                        "values",
                        "values",
                      ]),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child: CIA_DropDown(
                          label: "Assign to",
                          values: ["Name", "Name"],
                        )),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 20,
                        child:
                            CIA_SecondaryButton(label: "Assign", onTab: () {}))
                  ],
                ),
              );
              break;
            }
          case "expansion":
            {
              returnValue.add(Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: CIA_TextFormField(
                      onChange: (value) {
                        models[toothID]?.expansion = value;
                      },
                      label: 'Expansion',
                      controller: TextEditingController(
                        text: myModel[stat],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_DropDown(
                        label: "Assign to",
                        values: ["Name", "Name"],
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_SecondaryButton(label: "Assign", onTab: () {}))
                ],
              ));
              break;
            }
          case "splitting":
            {
              returnValue.add(Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: CIA_TextFormField(
                      onChange: (value) {
                        models[toothID]?.splitting = value;
                      },
                      label: 'Splitting',
                      controller: TextEditingController(
                        text: myModel[stat],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_DropDown(
                        label: "Assign to",
                        values: ["Name", "Name"],
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_SecondaryButton(label: "Assign", onTab: () {}))
                ],
              ));
              break;
            }
          case "gbr":
            {
              returnValue.add(Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: CIA_TextFormField(
                      onChange: (value) {
                        models[toothID]?.gbr = value;
                      },
                      label: 'GBR',
                      controller: TextEditingController(
                        text: myModel[stat],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_DropDown(
                        label: "Assign to",
                        values: ["Name", "Name"],
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_SecondaryButton(label: "Assign", onTab: () {}))
                ],
              ));
              break;
            }
          case "openSinus":
            {
              returnValue.add(Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: CIA_TextFormField(
                      onChange: (value) {
                        models[toothID]?.openSinus = value;
                      },
                      label: 'Open Sinus',
                      controller: TextEditingController(
                        text: myModel[stat],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_DropDown(
                        label: "Assign to",
                        values: ["Name", "Name"],
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_SecondaryButton(label: "Assign", onTab: () {}))
                ],
              ));
              break;
            }
          case "closedSinus":
            {
              returnValue.add(Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: CIA_TextFormField(
                      onChange: (value) {
                        models[toothID]?.closedSinus = value;
                      },
                      label: 'Closed Sinus',
                      controller: TextEditingController(
                        text: myModel[stat],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_DropDown(
                        label: "Assign to",
                        values: ["Name", "Name"],
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_SecondaryButton(label: "Assign", onTab: () {}))
                ],
              ));
              break;
            }

          case "bontic":
            {
              returnValue.add(Row(
                children: [
                  Expanded(
                    flex: 62,
                    child: CIA_TextFormField(
                      onChange: (value) {
                        models[toothID]?.bontic = value;
                      },
                      label: 'Bontic',
                      controller: TextEditingController(
                        text: myModel[stat],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_DropDown(
                        label: "Assign to",
                        values: ["Name", "Name"],
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 20,
                      child: CIA_SecondaryButton(label: "Assign", onTab: () {}))
                ],
              ));
              break;
            }
        }
      }
    }
    return returnValue;
  }
}
