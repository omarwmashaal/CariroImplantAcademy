import 'package:flutter/cupertino.dart';

import '../Constants/Fonts.dart';
import '../Controllers/PatientMedicalController.dart';
import '../Models/TreatmentPlanModel.dart';
import 'CIA_TextFormField.dart';
import 'FormTextWidget.dart';
import 'MultiSelectChipWidget.dart';

// TODO: Listen to models and higlight chips
class CIA_TeethTreatmentWidget extends StatefulWidget {
  CIA_TeethTreatmentWidget({Key? key, required this.controller})
      : super(key: key);

  PatientMedicalController controller;
  @override
  State<CIA_TeethTreatmentWidget> createState() =>
      _CIA_TeethTreatmentWidgetState();
}

Map<String, TreatmentPlanModel> models = Map<String, TreatmentPlanModel>();

class _CIA_TeethTreatmentWidgetState extends State<CIA_TeethTreatmentWidget> {
  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  onChange: (selectedValue, isSelected) {
                    isSelected
                        ? models[selectedValue] = TreatmentPlanModel()
                        : models.remove(selectedValue);
                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(
                        label: "11", isSelected: models["11"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "12", isSelected: models["12"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "13", isSelected: models["13"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "14", isSelected: models["14"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "15", isSelected: models["15"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "16", isSelected: models["16"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "17", isSelected: models["17"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "18", isSelected: models["18"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "19", isSelected: models["19"] != null)
                  ],
                ),
              ),
              SizedBox(),
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  onChange: (selectedValue, isSelected) {
                    isSelected
                        ? models[selectedValue] = TreatmentPlanModel()
                        : models.remove(selectedValue);
                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(
                        label: "21", isSelected: models["21"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "22", isSelected: models["22"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "23", isSelected: models["23"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "24", isSelected: models["24"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "25", isSelected: models["25"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "26", isSelected: models["26"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "27", isSelected: models["27"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "28", isSelected: models["28"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "29", isSelected: models["29"] != null)
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
                  onChange: (selectedValue, isSelected) {
                    isSelected
                        ? models[selectedValue] = TreatmentPlanModel()
                        : models.remove(selectedValue);
                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(
                        label: "31", isSelected: models["31"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "32", isSelected: models["32"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "33", isSelected: models["33"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "34", isSelected: models["34"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "35", isSelected: models["35"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "36", isSelected: models["36"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "37", isSelected: models["37"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "38", isSelected: models["38"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "39", isSelected: models["39"] != null)
                  ],
                ),
              ),
              SizedBox(),
              Expanded(
                child: CIA_MultiSelectChipWidget(
                  onChange: (selectedValue, isSelected) {
                    isSelected
                        ? models[selectedValue] = TreatmentPlanModel()
                        : models.remove(selectedValue);
                    setState(() {});
                  },
                  labels: [
                    CIA_MultiSelectChipWidgeModel(
                        label: "41", isSelected: models["41"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "42", isSelected: models["42"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "43", isSelected: models["43"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "44", isSelected: models["44"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "45", isSelected: models["45"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "46", isSelected: models["46"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "47", isSelected: models["47"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "48", isSelected: models["48"] != null),
                    CIA_MultiSelectChipWidgeModel(
                        label: "49", isSelected: models["49"] != null)
                  ],
                ),
              ),
            ],
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
  }

  _buildTeethWidgets() {
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
  }

  @override
  void initState() {
    models = widget.controller.TreatmentPlan;
  }
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
      CIA_MultiSelectChipWidget(
          onChange: (value, isSelected) {
            myModel = (models[toothID] as TreatmentPlanModel).toJson();
            if (isSelected) {
              myModel[value] = "";
            } else {
              myModel[value] = null;
            }

            var temp = models[toothID];
            temp?.fromJson(myModel);
            models[toothID] = temp!;
            onChange();
          },
          labels: [
            CIA_MultiSelectChipWidgeModel(
                label: "Extraction",
                value: "extraction",
                isSelected: myModel["extraction"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Flap",
                value: "flap",
                isSelected: myModel["flap"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Simple Implant",
                value: "simpleImplant",
                isSelected: myModel["simpleImplant"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Immediate Implant",
                value: "immediateImplant",
                isSelected: myModel["immediateImplant"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Expansion",
                value: "expansion",
                isSelected: myModel["expansion"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Splitting",
                value: "splitting",
                isSelected: myModel["splitting"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "GBR", value: "gbr", isSelected: myModel["gbr"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Open Sinus",
                value: "openSinus",
                isSelected: myModel["openSinus"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Closed Sinus",
                value: "closedSinus",
                isSelected: myModel["closedSinus"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Guided Implant",
                value: "guidedImplant",
                isSelected: myModel["guidedImplant"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Implant Diameter",
                value: "implantDiameter",
                isSelected: myModel["implantDiameter"] != null),
            CIA_MultiSelectChipWidgeModel(
                label: "Implant Type",
                value: "implantType",
                isSelected: myModel["implantType"] != null),
          ])
    ]);
    for (String key in myModel.keys) {
      if (myModel[key] != null) {
        returnValue.add(SizedBox(height: 10));
        switch (key) {
          case "extraction":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.extraction = value;
                  },
                  label: 'Extraction',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "flap":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.flap = value;
                  },
                  label: 'Flap',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "simpleImplant":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.simpleImplant = value;
                  },
                  label: 'Simple Implant',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "immediateImplant":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.immediateImplant = value;
                  },
                  label: 'Immediate Implant',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "expansion":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.expansion = value;
                  },
                  label: 'Expansion',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "splitting":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.splitting = value;
                  },
                  label: 'Splitting',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "gbr":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.gbr = value;
                  },
                  label: 'GBR',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "openSinus":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.openSinus = value;
                  },
                  label: 'Open Sinus',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "closedSinus":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.closedSinus = value;
                  },
                  label: 'Closed Sinus',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "guidedImplant":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.guidedImplant = value;
                  },
                  label: 'Guided Implant',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "implantDiameter":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.implantDiameter = value;
                  },
                  label: 'Implant Diameter',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
          case "implantType":
            {
              returnValue.add(
                CIA_TextFormField(
                  onChange: (value) {
                    models[toothID]?.implantType = value;
                  },
                  label: 'Implant Type',
                  controller: TextEditingController(
                    text: myModel[key],
                  ),
                ),
              );
              break;
            }
        }
      }
    }
    return returnValue;
  }
}
