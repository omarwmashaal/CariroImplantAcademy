import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_StepTimelineWidget.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Constants/Controllers.dart';
import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_IncrementalHBA1CTextField.dart';
import '../../Widgets/CIA_IncrementalTextField.dart';
import '../../Widgets/CIA_MedicalPageWidget.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/CIA_TagsInputWidget.dart';
import '../../Widgets/CIA_TeethSurgicalTreatmentWidget.dart';
import '../../Widgets/CIA_TeethTreatmentWidget.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/MultiSelectChipWidget.dart';

late PatientMedicalController MasterController;

class PatientMedicalInfoPage extends StatefulWidget {
  PatientMedicalInfoPage({Key? key, required this.patientMedicalController})
      : super(key: key);
  PatientMedicalController patientMedicalController;

  @override
  State<PatientMedicalInfoPage> createState() => _PatientMedicalInfoPageState();
}

class _PatientMedicalInfoPageState extends State<PatientMedicalInfoPage> {
  late PatientInfoModel patient;

  @override
  void initState() {
    MasterController = widget.patientMedicalController;
    patient = widget.patientMedicalController.patient;
  }

  List<String> tabs = [
    "Medical Exmination",
    "Dental History",
    "Dental Examination",
    "Non Surgical Treatment",
    "Treatment Plan",
    "Surgical Treatment",
    "Prosthetic Treatment",
    "Photos and CBCTs"
  ];
  List<Widget> pages = [
    _PatientMedicalHistory(),
    _PatientDentalHistory(),
    _PatientDentalExamination(),
    _PatientNonSurgicalTreatment(),
    _PatientTreatmentPlan(),
    _PatientSurgicalTreatment(),
    _PatientProstheticTreatment(),
    _Patient_CBCTandPhotos(),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    siteController.setAppBarWidget(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.width * 0.04,
      fontSize: MediaQuery.of(context).size.width * 0.01,
      tabs: [
        "Medical Examination",
        "Dental History",
        "Dental Examination",
        "Non Surgical Treatment",
        "Treatment Plan",
        "Surgical Treatment",
        "Prosthetic Treatment",
        "Photos and CBCTs"
      ],
    );
    patient?.Gender = "Male";
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() => TitleWidget(
                        showBackButton: true,
                        title: siteController.title.value,
                      )),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: PageView(
                      controller: tabsController,
                      children: pages,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image(
                        image: AssetImage("assets/ProfileImage.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CIA_SecondaryButton(
                          label: "View more info",
                          onTab: () {
                            internalPagesController.jumpToPage(2);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      CIA_SecondaryButton(
                          label: "LAB Request",
                          icon: Icon(Icons.document_scanner_outlined),
                          onTab: () {}),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: FormTextKeyWidget(text: "ID")),
                          Expanded(
                            child: FormTextValueWidget(
                              text: patient?.ID.toString() == null
                                  ? ""
                                  : patient?.ID.toString(),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: FormTextKeyWidget(text: "Name")),
                          Expanded(
                            child: FormTextValueWidget(
                                text:
                                    patient?.Name == null ? "" : patient?.Name),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: FormTextKeyWidget(text: "Gender")),
                          Expanded(
                            child: FormTextValueWidget(
                                text: patient?.Gender == null
                                    ? ""
                                    : patient?.Gender),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormTextKeyWidget(
                              text: "Operator",
                              secondaryInfo: true,
                            ),
                          ),
                          Expanded(
                            child: FormTextValueWidget(
                              text: "Omar Wael",
                              secondaryInfo: true,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormTextKeyWidget(
                              text: "Date:",
                              secondaryInfo: true,
                            ),
                          ),
                          Expanded(
                            child: FormTextValueWidget(
                              text: "12/1/2022",
                              secondaryInfo: true,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CIA_SecondaryButton(
                        label: "Cancel",
                        onTab: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CIA_PrimaryButton(
                        label: "Save",
                        onTab: () {},
                        isLong: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientMedicalHistory extends StatefulWidget {
  const _PatientMedicalHistory({Key? key}) : super(key: key);

  @override
  State<_PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<_PatientMedicalHistory> {
  bool otherField = false;
  bool diseases = false;
  Color illegalDrugs = Color_TextFieldBorder;

  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(children: [
      FormTextKeyWidget(text: "General Health"),
      CIA_MultiSelectChipWidget(
        labels: [
          CIA_MultiSelectChipWidgeModel(
              label: "Excellent", selectedColor: Colors.green),
          CIA_MultiSelectChipWidgeModel(
              label: "Very good", selectedColor: Colors.green),
          CIA_MultiSelectChipWidgeModel(
              label: "Good", selectedColor: Colors.orange),
          CIA_MultiSelectChipWidgeModel(
              label: "Fair", selectedColor: Colors.orange),
          CIA_MultiSelectChipWidgeModel(
              label: "Fail", selectedColor: Colors.red),
        ],
        singleSelect: true,
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
              child: HorizontalRadioButtons(
            names: ["Pregnant", "Lactating"],
            selectionColor: Colors.red,
          )),
        ],
      ),
      CIA_TextFormField(
          label: "Are you treated for anything now?",
          controller: TextEditingController()),
      CIA_TextFormField(
          label: "Recent Surgery", controller: TextEditingController()),
      CIA_TextFormField(label: "Comment", controller: TextEditingController()),
      FormTextKeyWidget(text: "Did you have ever?"),
      CIA_MultiSelectChipWidget(
        onChange: (value, isSelected) {
          if (value == "Other") {
            setState(() {
              diseases = isSelected as bool;
            });
          }
        },
        redFlags: true,
        labels: [
          CIA_MultiSelectChipWidgeModel(
              label: "Kidney Disease", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Liver Disease", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Asthma", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Psychological", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Rhemuatic", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Anemia", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Epilepsy", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Heart problem", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Thyroid", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Hepatitis", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Venereal Disease", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(
              label: "Other", selectedColor: Colors.red)
        ],
      ),
      Visibility(
          visible: diseases,
          child: CIA_TextFormField(
              label: "Other ", controller: TextEditingController())),
      FormTextKeyWidget(text: "Blood Pressure"),
      CIA_MultiSelectChipWidget(
        singleSelect: true,
        labels: [
          CIA_MultiSelectChipWidgeModel(label: "Normal"),
          CIA_MultiSelectChipWidgeModel(label: "Hypertensive controller"),
          CIA_MultiSelectChipWidgeModel(
              label: "Hypertensive uncontroller", selectedColor: Colors.red),
          CIA_MultiSelectChipWidgeModel(label: "Hypotensive controller"),
          CIA_MultiSelectChipWidgeModel(
              label: "Hypotensive uncontroller", selectedColor: Colors.red),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "Last Reading ", controller: TextEditingController()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "When? ", controller: TextEditingController()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "Drug ", controller: TextEditingController()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CIA_TextFormField(
                  label: "Reading in clinic ",
                  controller: TextEditingController()),
            ),
          ),
        ],
      ),
      FormTextKeyWidget(text: "Glucose Status"),
      CIA_MultiSelectChipWidget(
        singleSelect: true,
        labels: [
          CIA_MultiSelectChipWidgeModel(label: "Non diabetic"),
          CIA_MultiSelectChipWidgeModel(label: "Diabetic controller"),
          CIA_MultiSelectChipWidgeModel(
              label: "Diabetic uncontroller", selectedColor: Colors.red),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CIA_DropDown(label: 'Type', values: ["Random", "Fasting"]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "Last Reading ", controller: TextEditingController()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "When? ", controller: TextEditingController()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "Random in clinic ",
                  controller: TextEditingController()),
            ),
          ),
        ],
      ),
      FormTextKeyWidget(text: "HBA1c"),
      CIA_IncrementalHBA1CTextField(),
      FormTextKeyWidget(text: "Are you allergic to?"),
      Row(
        children: [
          Expanded(
            child: CIA_MultiSelectChipWidget(labels: [
              CIA_MultiSelectChipWidgeModel(
                  label: "Penicillin", selectedColor: Colors.red),
              CIA_MultiSelectChipWidgeModel(label: "Sulfa"),
              CIA_MultiSelectChipWidgeModel(label: "Other"),
            ]),
          ),
          Expanded(
            flex: 2,
            child: CIA_TextFormField(
                label: "Other Diseases", controller: TextEditingController()),
          )
        ],
      ),
      Row(
        children: [
          FormTextKeyWidget(
              text:
                  "Are you Subjected to prolonged bleeding or taking aspirin?"),
          SizedBox(
            width: 10,
          ),
          CIA_MultiSelectChipWidget(singleSelect: true, labels: [
            CIA_MultiSelectChipWidgeModel(label: "Yes"),
            CIA_MultiSelectChipWidgeModel(label: "No"),
          ]),
        ],
      ),
      Row(
        children: [
          FormTextKeyWidget(
              text: "Do you have chronic problem with digestion?"),
          SizedBox(
            width: 10,
          ),
          CIA_MultiSelectChipWidget(singleSelect: true, labels: [
            CIA_MultiSelectChipWidgeModel(label: "Yes"),
            CIA_MultiSelectChipWidgeModel(label: "No"),
          ]),
        ],
      ),
      CIA_TextFormField(
        borderColor: illegalDrugs,
        label: "Illegal Drugs",
        controller: TextEditingController(),
        onChange: (value) {
          if (value != null && value != "") {
            setState(() {
              illegalDrugs = Colors.red;
            });
          } else {
            setState(() {
              illegalDrugs = Color_TextFieldBorder;
            });
          }
        },
      ),
      CIA_TextFormField(
          label: "Operator Comments", controller: TextEditingController()),
      FormTextKeyWidget(text: "Drugs Taken by patinet"),
      CIA_IncrementalTextField(
        label: "Drug Name",
      ),
    ]);
  }
}

class _PatientDentalExamination extends StatefulWidget {
  const _PatientDentalExamination({Key? key}) : super(key: key);

  @override
  State<_PatientDentalExamination> createState() =>
      _PatientDentalExaminationState();
}

class AppProfile {
  final String name;
  final String email;
  final String imageUrl;

  const AppProfile(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

class _PatientDentalExaminationState extends State<_PatientDentalExamination> {
  Map<String, bool> _teeth = Map<String, bool>();
  Map<String, bool> _status = Map<String, bool>();
  String selectedTooth = "";
  List<String> selectedTeeth = [];
  String selectedStatus = "";
  bool mobilityDegrees = false;

  @override
  void initState() {
    _status["Carious"] = false;
    _status["Filled"] = false;
    _status["Missed"] = false;
    _status["Not Sure"] = false;
    _status["Mobility"] = false;
    _status["Hopeless teeth"] = false;
    _status["Implant Placed"] = false;
    _status["Implant Failed"] = false;
    _teeth["11"] = false;
    _teeth["12"] = false;
    _teeth["13"] = false;
    _teeth["14"] = false;
    _teeth["15"] = false;
    _teeth["16"] = false;
    _teeth["17"] = false;
    _teeth["18"] = false;
    _teeth["19"] = false;
    _teeth["20"] = false;
    _teeth["21"] = false;
    _teeth["22"] = false;
    _teeth["23"] = false;
    _teeth["24"] = false;
    _teeth["25"] = false;
    _teeth["26"] = false;
    _teeth["27"] = false;
    _teeth["28"] = false;
    _teeth["29"] = false;
    _teeth["30"] = false;
    _teeth["31"] = false;
    _teeth["32"] = false;
    _teeth["33"] = false;
    _teeth["34"] = false;
    _teeth["35"] = false;
    _teeth["36"] = false;
    _teeth["37"] = false;
    _teeth["38"] = false;
    _teeth["39"] = false;
    _teeth["40"] = false;
    _teeth["41"] = false;
    _teeth["42"] = false;
    _teeth["43"] = false;
    _teeth["44"] = false;
    _teeth["45"] = false;
    _teeth["46"] = false;
    _teeth["47"] = false;
    _teeth["48"] = false;
    _teeth["49"] = false;
    for (String tooth in _teeth.keys) {
      _teeth[tooth] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(children: [
      Row(
        children: [
          Expanded(
            child: CIA_MultiSelectChipWidget(
              key: GlobalKey(),
              onChangeList: (selectedItems) {
                selectedTeeth = selectedItems;
                for (String tooth in selectedTeeth) {
                  _teeth[tooth] = true;
                }
              },
              labels: [
                CIA_MultiSelectChipWidgeModel(
                    label: "11", isSelected: _teeth["11"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "12", isSelected: _teeth["12"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "13", isSelected: _teeth["13"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "14", isSelected: _teeth["14"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "15", isSelected: _teeth["15"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "16", isSelected: _teeth["16"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "17", isSelected: _teeth["17"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "18", isSelected: _teeth["18"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "19", isSelected: _teeth["19"] as bool)
              ],
            ),
          ),
          SizedBox(),
          Expanded(
            child: CIA_MultiSelectChipWidget(
              key: GlobalKey(),
              onChangeList: (selectedItems) {
                selectedTeeth = selectedItems;
                for (String tooth in selectedTeeth) {
                  _teeth[tooth] = true;
                }
              },
              labels: [
                CIA_MultiSelectChipWidgeModel(
                    label: "21", isSelected: _teeth["21"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "22", isSelected: _teeth["22"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "23", isSelected: _teeth["23"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "24", isSelected: _teeth["24"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "25", isSelected: _teeth["25"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "26", isSelected: _teeth["26"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "27", isSelected: _teeth["27"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "28", isSelected: _teeth["28"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "29", isSelected: _teeth["29"] as bool)
              ],
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: CIA_MultiSelectChipWidget(
              key: GlobalKey(),
              onChangeList: (selectedItems) {
                selectedTeeth = selectedItems;
                for (String tooth in selectedTeeth) {
                  _teeth[tooth] = true;
                }
              },
              labels: [
                CIA_MultiSelectChipWidgeModel(
                    label: "31", isSelected: _teeth["31"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "32", isSelected: _teeth["32"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "33", isSelected: _teeth["33"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "34", isSelected: _teeth["34"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "35", isSelected: _teeth["35"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "36", isSelected: _teeth["36"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "37", isSelected: _teeth["37"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "38", isSelected: _teeth["38"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "39", isSelected: _teeth["39"] as bool)
              ],
            ),
          ),
          SizedBox(),
          Expanded(
            child: CIA_MultiSelectChipWidget(
              key: GlobalKey(),
              onChangeList: (selectedItems) {
                selectedTeeth = selectedItems;
                for (String tooth in selectedTeeth) {
                  _teeth[tooth] = true;
                }
              },
              labels: [
                CIA_MultiSelectChipWidgeModel(
                    label: "41", isSelected: _teeth["41"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "42", isSelected: _teeth["42"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "43", isSelected: _teeth["43"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "44", isSelected: _teeth["44"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "45", isSelected: _teeth["45"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "46", isSelected: _teeth["46"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "47", isSelected: _teeth["47"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "48", isSelected: _teeth["48"] as bool),
                CIA_MultiSelectChipWidgeModel(
                    label: "49", isSelected: _teeth["49"] as bool)
              ],
            ),
          ),
        ],
      ),
      CIA_MultiSelectChipWidget(
        key: GlobalKey(),
        onChange: (value, isSelected) {
          if (isSelected) {
            if (value == "Mobility") {
              setState(() {
                mobilityDegrees = true;
                _status["Mobility"] = true;
              });
            } else {
              if (isSelected)
                MasterController.updateTeethStatus(selectedTeeth, value);
              for (String ss in _status.keys) {
                _status[ss] = false;
              }
              for (String tooth in _teeth.keys) {
                _teeth[tooth] = false;
              }
              setState(() {});
            }
          }
        },
        singleSelect: true,
        labels: [
          CIA_MultiSelectChipWidgeModel(
              label: "Carious", isSelected: _status["Carious"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Filled", isSelected: _status["Filled"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Missed", isSelected: _status["Missed"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Not Sure", isSelected: _status["Not Sure"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Mobility", isSelected: _status["Mobility"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Hopeless teeth",
              isSelected: _status["Hopeless teeth"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Implant Placed",
              isSelected: _status["Implant Placed"] as bool),
          CIA_MultiSelectChipWidgeModel(
              label: "Implant Failed",
              isSelected: _status["Implant Failed"] as bool),
        ],
      ),
      Visibility(
        visible: mobilityDegrees,
        child: CIA_MultiSelectChipWidget(
          key: GlobalKey(),
          onChange: (value, isSelected) {
            if (isSelected) {
              MasterController.updateTeethStatus(
                  selectedTeeth, "Mobility " + value);
              for (String ss in _status.keys) {
                _status[ss] = false;
              }
              for (String tooth in _teeth.keys) {
                _teeth[tooth] = false;
              }
              setState(() {
                mobilityDegrees = false;
              });
            }
          },
          singleSelect: true,
          labels: [
            CIA_MultiSelectChipWidgeModel(label: "I", isSelected: false),
            CIA_MultiSelectChipWidgeModel(label: "II", isSelected: false),
            CIA_MultiSelectChipWidgeModel(label: "III", isSelected: false),
          ],
        ),
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Carious",
        initalValue: (MasterController.getDentalExamindation())["Carious"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Carious", value),
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Filled",
        initalValue: MasterController.getDentalExamindation()["Filled"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Filled", value),
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Missed",
        initalValue: MasterController.getDentalExamindation()["Missed"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Missed", value),
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Not Sure",
        initalValue: MasterController.getDentalExamindation()["Not Sure"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Not Sure", value),
      ),
      Row(
        children: [
          Expanded(
            key: GlobalKey(),
            child: CIA_TagsInputWidget(
              key: GlobalKey(),
              patientController: MasterController,
              label: "Mobility I",
              initalValue:
                  MasterController.getDentalExamindation()["Mobility I"],
              onChange: (value) =>
                  MasterController.updateDentalExamination("Mobility I", value),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            key: GlobalKey(),
            child: CIA_TagsInputWidget(
              key: GlobalKey(),
              patientController: MasterController,
              label: "Mobility II",
              initalValue:
                  MasterController.getDentalExamindation()["Mobility II"],
              onChange: (value) => MasterController.updateDentalExamination(
                  "Mobility II", value),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            key: GlobalKey(),
            child: CIA_TagsInputWidget(
              key: GlobalKey(),
              patientController: MasterController,
              label: "Mobility III",
              initalValue:
                  MasterController.getDentalExamindation()["Mobility III"],
              onChange: (value) => MasterController.updateDentalExamination(
                  "Mobility III", value),
            ),
          ),
        ],
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Hopeless teeth",
        initalValue: MasterController.getDentalExamindation()["Hopeless teeth"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Hopeless teeth", value),
      ),
      Row(
        children: [
          Expanded(
            key: GlobalKey(),
            child: CIA_TextFormField(
                suffix: "mm",
                isNumber: true,
                label: "Inter arch space RT",
                controller: TextEditingController()),
          ),
          SizedBox(width: 10),
          Expanded(
            key: GlobalKey(),
            child: CIA_TextFormField(
                suffix: "mm",
                isNumber: true,
                label: "Inter arch space LT",
                controller: TextEditingController()),
          ),
        ],
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Implant Placed",
        initalValue: MasterController.getDentalExamindation()["Implant Placed"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Implant Placed", value),
      ),
      CIA_TagsInputWidget(
        key: GlobalKey(),
        patientController: MasterController,
        label: "Implant Failed",
        initalValue: MasterController.getDentalExamindation()["Implant Failed"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Implant Failed", value),
      ),
      CIA_TextFormField(
          label: "Operator Implant Notes", controller: TextEditingController())
    ]);
  }
}

class _PatientDentalHistory extends StatefulWidget {
  const _PatientDentalHistory({Key? key}) : super(key: key);

  @override
  State<_PatientDentalHistory> createState() => _PatientDentalHistoryState();
}

class _PatientDentalHistoryState extends State<_PatientDentalHistory> {
  Color clench = Color_TextFieldBorder;
  String tobacco = "0";

  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(
      children: [
        Row(
          children: [
            Expanded(
                child:
                    FormTextKeyWidget(text: "Are your teeth sensitive to ?")),
            Expanded(
                flex: 2,
                child: CIA_MultiSelectChipWidget(labels: [
                  CIA_MultiSelectChipWidgeModel(label: "Hot or cold"),
                  CIA_MultiSelectChipWidgeModel(label: "sweets"),
                  CIA_MultiSelectChipWidgeModel(label: "Biting or cheweing"),
                ]))
          ],
        ),
        CIA_TextFormField(
            borderColor: clench,
            onChange: (value) {
              if (value != null && value != "") {
                setState(() {
                  clench = Colors.orange;
                });
              } else {
                setState(() {
                  clench = Color_TextFieldBorder;
                });
              }
            },
            label: "Do you clench or grind your teeth while awake or sleep?",
            controller: TextEditingController()),
        Row(
          children: [
            Expanded(
                child: FormTextKeyWidget(
              text: "Smoke Tobacco?",
            )),
            Expanded(
                child: CIA_TextFormField(
                    onChange: (value) {
                      setState(() {
                        tobacco = value;
                      });
                    },
                    label: "Cigarette per day",
                    controller: TextEditingController(text: tobacco))),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormTextValueWidget(
                text: int.parse(tobacco) == 0
                    ? "Non Smoker"
                    : (int.parse(tobacco) < 10
                        ? "Light Smoker"
                        : (int.parse(tobacco) < 20
                            ? "Medium Smoker"
                            : "Heavy Smoker")),
              ),
            ),
            Expanded(flex: 3, child: SizedBox())
          ],
        ),
        CIA_TextFormField(
            label: "A serious injury to the mouth?",
            controller: TextEditingController()),
        CIA_TextFormField(
            label: "Are you satisfied with your teeth's appearance?",
            controller: TextEditingController()),
        Row(
          children: [
            Expanded(
                child: FormTextKeyWidget(text: "Patient Cooperation Score")),
            Expanded(
                child: CIA_TextFormField(
                    label: "", controller: TextEditingController())),
            Expanded(child: FormTextKeyWidget(text: "/10")),
            Expanded(child: SizedBox())
          ],
        ),
        Row(
          children: [
            Expanded(
                child: FormTextKeyWidget(
                    text: "Patient willing for implant score")),
            Expanded(
                child: CIA_TextFormField(
                    label: "", controller: TextEditingController())),
            Expanded(child: FormTextKeyWidget(text: "/10")),
            Expanded(child: SizedBox())
          ],
        ),
      ],
    );
  }
}

class _PatientNonSurgicalTreatment extends StatefulWidget {
  const _PatientNonSurgicalTreatment({Key? key}) : super(key: key);

  @override
  State<_PatientNonSurgicalTreatment> createState() =>
      _PatientNonSurgicalTreatmentState();
}

class _PatientNonSurgicalTreatmentState
    extends State<_PatientNonSurgicalTreatment> {
  String date = "";
  List<String> containedTeeth = <String>[];

  @override
  void initState() {
    for (String tooth in MasterController.getTeeth()) {
      if ((MasterController.nonSurgicalTreatment as String).contains(tooth)) {
        containedTeeth.add(tooth);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(children: [
      CIA_TextFormField(
        onChange: (value) async {
          containedTeeth.clear();
          MasterController.nonSurgicalTreatment = value;
          for (String tooth in MasterController.getTeeth()) {
            if ((value as String).contains(tooth)) {
              containedTeeth.add(tooth);
            }
          }
          setState(() {});
          print(containedTeeth);
        },
        label: "Treatment",
        controller:
            TextEditingController(text: MasterController.nonSurgicalTreatment),
        maxLines: 5,
      ),
      Row(
        children: [
          Expanded(
            child: CIA_DropDown(label: "Supervisor", values: [
              "Name1",
              "Name2",
              "Name3",
              "Name4",
              "Name5",
              "Name6",
              "Name7",
              "Name8",
              "Name9",
              "Name10",
            ]),
          ),
          SizedBox(
            width: 10,
          ),
          CIA_SecondaryButton(
              label: "View History",
              onTab: () {
                CIA_PopupDialog_Table(
                    context, "View History Treatments", (value) {});
              }),
          SizedBox(
            width: 10,
          ),
          CIA_SecondaryButton(
              label: "Schedule Next Visit",
              width: 200,
              onTab: () {
                CIA_PopupDialog_DateTimePicker(
                    context, "Schedule Next Visit", (value) {});
              }),
        ],
      ),
      containedTeeth.isEmpty ? SizedBox() : _buildTeethSuggestion()
    ]);
  }

  _buildTeethSuggestion() {
    List<Widget> uu = <Widget>[];

    for (String tooth in containedTeeth) {
      List<CIA_MultiSelectChipWidgeModel> tempModel = [
        CIA_MultiSelectChipWidgeModel(label: "Carious", isSelected: false),
        CIA_MultiSelectChipWidgeModel(label: "Filled", isSelected: false),
        CIA_MultiSelectChipWidgeModel(label: "Missed", isSelected: false),
        CIA_MultiSelectChipWidgeModel(label: "Not Sure", isSelected: false),
        CIA_MultiSelectChipWidgeModel(label: "Mobility I", isSelected: false),
        CIA_MultiSelectChipWidgeModel(label: "Mobility II", isSelected: false),
        CIA_MultiSelectChipWidgeModel(label: "Mobility III", isSelected: false),
        CIA_MultiSelectChipWidgeModel(
            label: "Hopeless teeth", isSelected: false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Placed", isSelected: false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Failed", isSelected: false),
      ];

      String status = MasterController.getToothStatus(tooth);
      for (CIA_MultiSelectChipWidgeModel temp in tempModel) {
        if (temp.label == status) {
          temp.isSelected = true;
          break;
        }
      }

      uu.add(FormTextKeyWidget(text: "Do you want to update tooth $tooth?"));
      uu.add(CIA_MultiSelectChipWidget(
        key: LabeledGlobalKey(tooth),
        singleSelect: true,
        labels: tempModel,
        onChangeSpecificTooth: (selected, isSelected, key) {
          String selectedTooth = (key.toString())
              .substring((key.toString()).indexOf(" ") + 1)
              .replaceAll("]", "");
          if (isSelected)
            MasterController.updateToothTreatmentStatus(
                selectedTooth, selected);
        },
      ));
      uu.add(SizedBox(height: 10));
    }
    Widget ss = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: uu,
    );
    return ss;
  }
}

class _PatientTreatmentPlan extends StatefulWidget {
  _PatientTreatmentPlan({Key? key}) : super(key: key);

  @override
  State<_PatientTreatmentPlan> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<_PatientTreatmentPlan> {
  @override
  Widget build(BuildContext context) {
    return CIA_TeethTreatmentPlanWidget(
      controller: MasterController,
    );
  }
}

class _PatientSurgicalTreatment extends StatefulWidget {
  const _PatientSurgicalTreatment({Key? key}) : super(key: key);

  @override
  State<_PatientSurgicalTreatment> createState() =>
      _PatientSurgicalTreatmentState();
}

class _PatientSurgicalTreatmentState extends State<_PatientSurgicalTreatment> {
  @override
  Widget build(BuildContext context) {
    return CIA_TeethSurgicalTreatmentWidget(
      controller: MasterController,
    );
  }
}

class _PatientProstheticTreatment extends StatefulWidget {
  const _PatientProstheticTreatment({Key? key}) : super(key: key);

  @override
  State<_PatientProstheticTreatment> createState() =>
      _PatientProstheticTreatmentState();
}

class _PatientProstheticTreatmentState
    extends State<_PatientProstheticTreatment> {
  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(
      children: [
        Column(
          children: _buildWidgets(),
        )
      ],
    );
  }

  _buildWidgets() {
    List<Widget> r = [];
    List<String> teeth = [];
    for (String key in MasterController.TreatmentPlan.keys) {
      if (MasterController.TreatmentPlan[key] != null) {
        if ((MasterController.TreatmentPlan[key]?.guidedImplant != null &&
            MasterController.TreatmentPlan[key]?.guidedImplant?.status
                as bool)) {
          teeth.add(key);
        } else if (MasterController.TreatmentPlan[key]?.immediateImplant !=
                null &&
            MasterController.TreatmentPlan[key]?.immediateImplant?.status
                as bool) {
          teeth.add(key);
        } else if (MasterController.TreatmentPlan[key]?.simpleImplant != null &&
            MasterController.TreatmentPlan[key]?.simpleImplant?.status
                as bool) {
          teeth.add(key);
        }
      }
    }
    for (String tooth in teeth) {
      r.add(_ProstheticWidget(
        tooth: tooth,
      ));
    }
    return r;
  }
}

class _ProstheticWidget extends StatefulWidget {
  _ProstheticWidget({Key? key, required this.tooth}) : super(key: key);
  String tooth;
  @override
  State<_ProstheticWidget> createState() => _ProstheticWidgetState();
}

class _ProstheticWidgetState extends State<_ProstheticWidget> {
  int? myActiveIndex = null;
  List<StepModel> stepModels = [
    StepModel(name: "Exposure", stepStatus: StepStatus_.Done),
    StepModel(name: "Impression", stepStatus: StepStatus_.InProgress),
    StepModel(name: "Follow Up", stepStatus: StepStatus_.NotYet),
    StepModel(name: "Try In", stepStatus: StepStatus_.NotYet),
    StepModel(name: "Verification Jig", stepStatus: StepStatus_.NotYet),
    StepModel(name: "Delivery", stepStatus: StepStatus_.NotYet),
  ];
  bool leftEnabled = true;
  bool rightEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Tooth: " + widget.tooth,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  try {
                    if (myActiveIndex! != 0)
                      myActiveIndex = (myActiveIndex as int) - 1;
                    setState(() {});
                  } catch (e) {}
                },
                child: Icon(Icons.keyboard_arrow_left)),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  try {
                    if (myActiveIndex! !=
                        stepModels.indexWhere((element) =>
                            element.stepStatus == StepStatus_.InProgress))
                      myActiveIndex = (myActiveIndex as int) + 1;

                    setState(() {});
                  } catch (e) {}
                },
                child: Icon(Icons.keyboard_arrow_right)),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        myActiveIndex != null
            ? Text(stepModels[myActiveIndex!].name)
            : Text(""),
        CIA_StepTimelineWidget(activeIndex_: myActiveIndex, steps: stepModels),
      ],
    );
  }

  @override
  void initState() {
    myActiveIndex = stepModels
        .indexWhere((element) => element.stepStatus == StepStatus_.InProgress);
  }
}

class _Patient_CBCTandPhotos extends StatefulWidget {
  const _Patient_CBCTandPhotos({Key? key}) : super(key: key);

  @override
  State<_Patient_CBCTandPhotos> createState() => _Patient_CBCTandPhotosState();
}

class _Patient_CBCTandPhotosState extends State<_Patient_CBCTandPhotos> {
  bool? done;
  String reason = "";

  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(
      children: [
        Row(
          children: [
            FormTextKeyWidget(text: "Status"),
            SizedBox(width: 10),
            CIA_MultiSelectChipWidget(
                singleSelect: true,
                onChange: (item, isSelected) {
                  if (item == "done") {
                    done = true;
                  } else if (item == "notDone") {
                    done = false;
                  }
                  setState(() {});
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(label: "Done", value: "done"),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Not Done", value: "notDone"),
                ]),
            SizedBox(width: 10),
            Visibility(
              visible: done != null && !done!,
              child: Expanded(
                child: CIA_DropDown(
                  selectedValue: reason,
                  onSelect: (value) {
                    reason = value;
                    setState(() {});
                  },
                  label: "Reason",
                  values: [
                    "Patient's Desire",
                    "Waiting for scan applicance",
                    "Work required before CBCT",
                    "Other"
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            done != null && !done! && reason == "Other"
                ? Expanded(
                    child: CIA_TextFormField(
                        label: "Other", controller: TextEditingController()),
                  )
                : Expanded(child: SizedBox())
          ],
        ),
        Wrap(
          children: [
            Visibility(
                visible: done != null && done!,
                child: Container(
                  width: 300,
                  child: CIA_TextFormField(
                      label: "Date", controller: TextEditingController()),
                )),
          ],
        ),
        Wrap(
          children: [
            Container(
                width: 150,
                child: CIA_SecondaryButton(
                    label: "Request new CBCT", onTab: () {})),
          ],
        )
      ],
    );
  }
}
