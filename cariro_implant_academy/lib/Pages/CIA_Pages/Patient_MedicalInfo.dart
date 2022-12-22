import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Controllers.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/FormTextWidget.dart';
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
                    flex: 15,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TitleWidget(
                                title: "Patient Information",
                                showBackButton: true,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: [
                                      Flexible(
                                        child: Row(
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
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Flexible(
                                        child: Row(
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
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Flexible(
                                        child: Row(
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
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Flexible(
                                        child: Row(
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
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Flexible(
                                        child: Row(
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
                                        ),
                                      )
                                    ],
                                  ),
                                  CIA_SecondaryButton(
                                      label: "View more info", onTab: () {})
                                ],
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
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Image(
                      image: AssetImage("ProfileImage.png"),
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
  @override
  Widget build(BuildContext context) {
    return Container();
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
