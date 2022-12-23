import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Controllers.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_IncrementalTextField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import '../../Widgets/SlidingTab.dart';

class PatientMedicalInfoPage extends StatefulWidget {
  PatientMedicalInfoPage({Key? key}) : super(key: key);

  @override
  State<PatientMedicalInfoPage> createState() => _PatientMedicalInfoPageState();
}

class _PatientMedicalInfoPageState extends State<PatientMedicalInfoPage> {
  PatientInfoModel? patient;

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
    if (internalPagesController.passedObject is PatientInfoModel)
      patient = internalPagesController.passedObject as PatientInfoModel;
    else
      patient = PatientInfoModel(0, "Name", "Phone", "MaritalStatus");

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
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TitleWidget(
                                  title: "Patient Information",
                                  showBackButton: true,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(text: "ID"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FormTextValueWidget(
                                              text:
                                                  patient?.ID.toString() == null
                                                      ? ""
                                                      : patient?.ID.toString(),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(text: "Name"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FormTextValueWidget(
                                                text: patient?.Name == null
                                                    ? ""
                                                    : patient?.Name)
                                          ],
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(
                                                text: "Phone Number"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FormTextValueWidget(
                                                text: patient?.Phone == null
                                                    ? ""
                                                    : patient?.Phone)
                                          ],
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(text: "Gender"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FormTextValueWidget(
                                                text: patient?.Gender == null
                                                    ? ""
                                                    : patient?.Gender)
                                          ],
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          children: [
                                            FormTextKeyWidget(
                                                text: "Marital Status"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            FormTextValueWidget(
                                                text: patient?.MaritalStatus ==
                                                        null
                                                    ? ""
                                                    : patient?.MaritalStatus)
                                          ],
                                        )
                                      ],
                                    ),
                                    CIA_SecondaryButton(
                                        label: "View more info", onTab: () {})
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TitleWidget(
                            title: tabs[index],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
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
                                image: AssetImage("ProfileImage.png"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FormTextKeyWidget(
                                        text: "Operator Name:",
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
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
    return FutureBuilder(
      future: _buildItems(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Center(
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [Color_AccentGreen],
            ),
          );
        }
      },
    );
  }

  _buildItems() async {
    await Future.delayed(Duration(milliseconds: 500));
    return ListView(
      shrinkWrap: false,
      children: [
        FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              CIA_TextFormField(
                  label: "General Health", controller: TextEditingController()),
              SizedBox(height: 10),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      child: HorizontalRadioButtons(
                          names: ["Pregnant", "Lactating"])),
                ],
              ),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Are you treated for anything now?",
                  controller: TextEditingController()),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Recent Surgery", controller: TextEditingController()),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Comment", controller: TextEditingController()),
              SizedBox(height: 10),
              FormTextKeyWidget(text: "Did you have ever?"),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Other ", controller: TextEditingController()),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Comments ", controller: TextEditingController()),
              SizedBox(height: 10),
              SizedBox(height: 10),
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
                          label: "Last Reading ",
                          controller: TextEditingController()),
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CIA_TextFormField(
                          label: "Glucose Level",
                          controller: TextEditingController()),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          label: "Last Reading ",
                          controller: TextEditingController()),
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              FormTextKeyWidget(text: "Are you allergic to?"),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                        labels: ["Pencillin", "Sulfa", "Other"]),
                  ),
                  Expanded(
                    flex: 2,
                    child: CIA_TextFormField(
                        label: "Other Diseases",
                        controller: TextEditingController()),
                  )
                ],
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label:
                      "Are you Subjected to prolonged bleeding or taking aspirin?",
                  controller: TextEditingController()),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Do you have chronic problem with digestion?",
                  controller: TextEditingController()),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child:
                        CIA_MultiSelectChipWidget(labels: ["Illegal Drugs?"]),
                  ),
                  Expanded(
                    flex: 4,
                    child: CIA_TextFormField(
                        label: "Drugs", controller: TextEditingController()),
                  )
                ],
              ),
              SizedBox(height: 10),
              CIA_TextFormField(
                  label: "Operator Comments",
                  controller: TextEditingController()),
              SizedBox(height: 10),
              FormTextKeyWidget(text: "Drugs Taken by patinet"),
              SizedBox(height: 10),
              CIA_IncrementalTextField(
                label: "Drug Name",
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}

class _PatientDentalExamination extends StatefulWidget {
  const _PatientDentalExamination({Key? key}) : super(key: key);

  @override
  State<_PatientDentalExamination> createState() =>
      _PatientDentalExaminationState();
}

class _PatientDentalExaminationState extends State<_PatientDentalExamination> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
    return Container();
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _PatientTreatmentPlan extends StatefulWidget {
  const _PatientTreatmentPlan({Key? key}) : super(key: key);

  @override
  State<_PatientTreatmentPlan> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<_PatientTreatmentPlan> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
