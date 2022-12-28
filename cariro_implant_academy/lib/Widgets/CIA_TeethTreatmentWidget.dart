import 'package:flutter/cupertino.dart';

import '../Constants/Fonts.dart';
import '../Models/TreatmentPlanModel.dart';
import 'CIA_TextFormField.dart';
import 'FormTextWidget.dart';
import 'MultiSelectChipWidget.dart';

class CIA_TeethTreatmentWidget extends StatefulWidget {
  const CIA_TeethTreatmentWidget({Key? key}) : super(key: key);

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
                    "11",
                    "12",
                    "13",
                    "14",
                    "15",
                    "16",
                    "17",
                    "18",
                    "19"
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
                    "21",
                    "22",
                    "23",
                    "24",
                    "25",
                    "26",
                    "27",
                    "28",
                    "29"
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
                    "31",
                    "32",
                    "33",
                    "34",
                    "35",
                    "36",
                    "37",
                    "38",
                    "39"
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
                    "41",
                    "42",
                    "43",
                    "44",
                    "45",
                    "46",
                    "47",
                    "48",
                    "49"
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
      returnValue.add(_ToothWidget(toothID: tooth));
      returnValue.add(SizedBox(height: 20));
    }
    return returnValue;
  }
}

class _ToothWidget extends StatefulWidget {
  _ToothWidget({Key? key, required this.toothID}) : super(key: key);

  String toothID;

  @override
  State<_ToothWidget> createState() => _ToothWidgetState();
}

class _ToothWidgetState extends State<_ToothWidget> {
  Map<String, dynamic> myModel = Map<String, dynamic>();
  @override
  Widget build(BuildContext context) {
    myModel = (models[widget.toothID] as TreatmentPlanModel).toJson();
    return Column(children: _buildWidgets());
  }

  List<Widget> _buildWidgets() {
    List<Widget> returnValue = <Widget>[];
    returnValue.addAll([
      Row(
        children: [
          Text(
            "Tooth",
            style: TextStyle(fontFamily: Inter_Bold, fontSize: 25),
          ),
          SizedBox(width: 30),
          FormTextValueWidget(text: widget.toothID),
        ],
      ),
      SizedBox(height: 10),
      CIA_MultiSelectChipWidget(
          onChange: (value, isSelected) {
            myModel = (models[widget.toothID] as TreatmentPlanModel).toJson();
            if (isSelected) {
              myModel[value] = "";
            } else {
              myModel[value] = null;
            }

            var temp = models[widget.toothID];
            temp?.fromJson(myModel);
            models[widget.toothID] = temp!;
            setState(() {});
          },
          labels: const <String, String>{
            "Extraction": "extraction",
            "Flap": "flap",
            "Simple Implant": "simpleImplant",
            "Immediate Implant": "immediateImplant",
            "Expansion": "expansion",
            "Splitting": "splitting",
            "GBR": "gbr",
            "Open Sinus": "openSinus",
            "Closed Sinus": "closedSinus",
            "Guided Implant": "guidedImplant",
            "Implant Diameter": "implantDiameter",
            "Implant Type": "implantType"
          })
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
                    models[widget.toothID]?.extraction = value;
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
                    models[widget.toothID]?.flap = value;
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
                    models[widget.toothID]?.simpleImplant = value;
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
                    models[widget.toothID]?.immediateImplant = value;
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
                    models[widget.toothID]?.expansion = value;
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
                    models[widget.toothID]?.splitting = value;
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
                    models[widget.toothID]?.gbr = value;
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
                    models[widget.toothID]?.openSinus = value;
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
                    models[widget.toothID]?.closedSinus = value;
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
                    models[widget.toothID]?.guidedImplant = value;
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
                    models[widget.toothID]?.implantDiameter = value;
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
                    models[widget.toothID]?.implantType = value;
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
