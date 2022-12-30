import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Controllers.dart';
import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_IncrementalTextField.dart';
import '../../Widgets/CIA_MedicalPageWidget.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/CIA_TagsInputWidget.dart';
import '../../Widgets/CIA_TeethTreatmentWidget.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import '../../Widgets/SlidingTab.dart';

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
    Container(),
    Container(),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    patient?.Gender = "Male";
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: SlidingTab(
                      onChange: ((value) {
                        tabsController.jumpToPage(value);
                        setState(() {
                          index = value;
                        });
                      }),
                      titles: tabs,
                      weight: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.04,
                      fontSize: MediaQuery.of(context).size.width * 0.01,
                      controller: tabsController,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: TitleWidget(
                            showBackButton: true,
                            title: tabs[index],
                          ),
                        ),
                        Expanded(
                          flex: 8,
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
                              Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "ID")),
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
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Name")),
                                  Expanded(
                                    child: FormTextValueWidget(
                                        text: patient?.Name == null
                                            ? ""
                                            : patient?.Name),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(text: "Gender")),
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
            ),

            // Obx(() =>widget.pages[tabsController.index.value] ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(children: [
      CIA_TextFormField(
          label: "General Health", controller: TextEditingController()),
      Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
              child: HorizontalRadioButtons(names: ["Pregnant", "Lactating"])),
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
        redFlags: true,
        labels: [
          "Kidney Disease",
          "Liver Disease",
          "Asthma",
          "Psychological",
          "Rhemuatic",
          "Anemia",
          "Epilepsy",
          "Heart problem",
          "Thyroid",
          "Hepatitis",
          "Venereal Disease",
          "Other"
        ],
      ),
      CIA_TextFormField(label: "Other ", controller: TextEditingController()),
      CIA_TextFormField(
          label: "Comments ", controller: TextEditingController()),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CIA_TextFormField(
                  label: "Blood pressure ",
                  controller: TextEditingController()),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CIA_TextFormField(
                  label: "Glucose Level", controller: TextEditingController()),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SizedBox(),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CIA_TextFormField(
                  label: "HBA1c", controller: TextEditingController()),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CIA_TextFormField(
                  label: "Date", controller: TextEditingController()),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(),
            ),
          ),
        ],
      ),
      FormTextKeyWidget(text: "Are you allergic to?"),
      Row(
        children: [
          Expanded(
            child: CIA_MultiSelectChipWidget(
                labels: ["Pencillin", "Sulfa", "Other"]),
          ),
          Expanded(
            flex: 2,
            child: CIA_TextFormField(
                label: "Other Diseases", controller: TextEditingController()),
          )
        ],
      ),
      CIA_TextFormField(
          label: "Are you Subjected to prolonged bleeding or taking aspirin?",
          controller: TextEditingController()),
      CIA_TextFormField(
          label: "Do you have chronic problem with digestion?",
          controller: TextEditingController()),
      Row(
        children: [
          Expanded(
            child: CIA_MultiSelectChipWidget(labels: ["Illegal Drugs?"]),
          ),
          Expanded(
            flex: 4,
            child: CIA_TextFormField(
                label: "Drugs", controller: TextEditingController()),
          )
        ],
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
  @override
  Widget build(BuildContext context) {
    return CIA_MedicalPagesWidget(children: [
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Carious",
        initalValue: (MasterController.getDentalExamindation())["Carious"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Carious", value),
      ),
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Filled",
        initalValue: MasterController.getDentalExamindation()["Filled"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Filled", value),
      ),
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Missed",
        initalValue: MasterController.getDentalExamindation()["Missed"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Missed", value),
      ),
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Not Sure",
        initalValue: MasterController.getDentalExamindation()["Not Sure"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Not Sure", value),
      ),
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Mobility",
        initalValue: MasterController.getDentalExamindation()["Mobility"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Mobility", value),
      ),
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Hopeless teeth",
        initalValue: MasterController.getDentalExamindation()["Hopeless teeth"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Hopeless teeth", value),
      ),
      Row(
        children: [
          Expanded(
              child: CIA_TagsInputWidget(
            patientController: MasterController,
            label: "Inter arch space RT",
            initalValue:
                MasterController.getDentalExamindation()["Inter arch space RT"],
            onChange: (value) => MasterController.updateDentalExamination(
                "Inter arch space RT", value),
          )),
          SizedBox(width: 10),
          Expanded(
              child: CIA_TagsInputWidget(
            patientController: MasterController,
            label: "Inter arch space LT",
            initalValue:
                MasterController.getDentalExamindation()["Inter arch space LT"],
            onChange: (value) => MasterController.updateDentalExamination(
                "Inter arch space LT", value),
          )),
        ],
      ),
      CIA_TagsInputWidget(
        patientController: MasterController,
        label: "Implant Placed",
        initalValue: MasterController.getDentalExamindation()["Implant Placed"],
        onChange: (value) =>
            MasterController.updateDentalExamination("Implant Placed", value),
      ),
      CIA_TagsInputWidget(
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
                child: CIA_MultiSelectChipWidget(
                    labels: ["Hot or cold", "sweets", "Biting or cheweing"]))
          ],
        ),
        CIA_TextFormField(
            label: "Do you clench or grind your teeth while awake or sleep?",
            controller: TextEditingController()),
        Row(
          children: [
            Expanded(
                child: CIA_MultiSelectChipWidget(labels: ["Smoke tobacco?"])),
            Expanded(
                child: CIA_TextFormField(
                    label: "per day", controller: TextEditingController())),
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
    Map<String, bool> myMap = {
      "Carious": false,
      "Filled": false,
      "Missed": false,
      "Not Sure": false,
      "Mobility": false,
      "Hopeless teeth": false,
      "Inter arch space RT": false,
      "Inter arch space LT": false,
      "Implant Placed": false,
      "Implant Failed": false,
    };

    for (String tooth in containedTeeth) {
      Map<String, bool> tempMap = Map();
      tempMap.addEntries(myMap.entries);

      String status = MasterController.getToothStatus(tooth);
      for (String key in tempMap.keys) {
        if (key == status) {
          tempMap[key] = true;
          break;
        }
      }

      uu.add(FormTextKeyWidget(text: "Do you want to update tooth $tooth?"));
      uu.add(CIA_MultiSelectChipWidget(
        key: LabeledGlobalKey(tooth),
        singleSelect: true,
        labels: tempMap,
        onChangeSpecificTooth: (selected, isSelected, key) {
          String selectedTooth = (key.toString())
              .substring((key.toString()).indexOf(" ") + 1)
              .replaceAll("]", "");
          if (isSelected)
            MasterController.updateToothStatus(selectedTooth, selected);
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
    return CIA_TeethTreatmentWidget(
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
    return Container();
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
    return Container();
  }
}
