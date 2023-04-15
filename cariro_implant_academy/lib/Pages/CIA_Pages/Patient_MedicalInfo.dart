import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/MedicalExaminationModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_StepTimelineWidget.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../API/TempPatientAPI.dart';
import '../../Constants/Controllers.dart';
import '../../Controllers/PatientMedicalController.dart';
import '../../Models/API_Response.dart';
import '../../Models/Enum.dart';
import '../../Models/MedicalModels/DentalHistory.dart';
import '../../Models/MedicalModels/NonSurgicalTreatment.dart';
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
import 'package:collection/collection.dart';

late PatientMedicalController MasterController;
late int patientID;
late MedicalExaminationModel medicalExaminationModel;
late DentalHistoryModel dentalHistoryModel;
late DentalExaminationModel dentalExaminationModel;
late NonSurgicalTreatmentModel nonSurgicalTreatment;

class PatientMedicalInfoPage extends StatefulWidget {
  PatientMedicalInfoPage(
      {Key? key,
        required this.patientMedicalController,
        required this.patientID})
      : super(key: key);
  PatientMedicalController patientMedicalController;
  int patientID;

  @override
  State<PatientMedicalInfoPage> createState() => _PatientMedicalInfoPageState();
}

class _PatientMedicalInfoPageState extends State<PatientMedicalInfoPage> {
  late PatientInfoModel patient;

  @override
  void initState() {
    MasterController = widget.patientMedicalController;
    patient = widget.patientMedicalController.patient;
    patientID = widget.patientID;
  }

  List<String> tabs = [
    "Medical Examination",
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
    //_PatientTreatmentPlan(),
    // _PatientSurgicalTreatment(),
    // _PatientProstheticTreatment(),
    //_Patient_CBCTandPhotos(),
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
    patient?.gender = "Male";
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
                              text: patient?.id.toString() == null
                                  ? ""
                                  : patient?.id.toString(),
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
                                patient?.name == null ? "" : patient?.name),
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
                                text: patient?.gender == null
                                    ? ""
                                    : patient?.gender),
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
  void dispose() {
    TempPatientAPI.UpdateMedicalExamination(patientID, medicalExaminationModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MedicalAPI.GetPatientMedicalExamination(patientID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var resp = snapshot.data as API_Response;
            if (resp.statusCode == 200)
              medicalExaminationModel = resp.result as MedicalExaminationModel;
            return CIA_MedicalPagesWidget(children: [
              FormTextKeyWidget(text: "General Health"),
              CIA_MultiSelectChipWidget(
                singleSelect: true,
                onChange: (value, isSelected) {
                  switch (value) {
                    case "Excellent":
                      medicalExaminationModel.generalHealth =
                          GeneralHealthEnum.Excellent;
                      break;
                    case "Very good":
                      medicalExaminationModel.generalHealth =
                          GeneralHealthEnum.VeryGood;
                      break;
                    case "Good":
                      medicalExaminationModel.generalHealth =
                          GeneralHealthEnum.Good;
                      break;
                    case "Fair":
                      medicalExaminationModel.generalHealth =
                          GeneralHealthEnum.Fair;
                      break;
                    case "Fail":
                      medicalExaminationModel.generalHealth =
                          GeneralHealthEnum.Fail;
                      break;
                  }
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Excellent",
                      selectedColor: Colors.green,
                      isSelected: medicalExaminationModel.generalHealth ==
                          GeneralHealthEnum.Excellent),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Very good",
                      selectedColor: Colors.green,
                      isSelected: medicalExaminationModel.generalHealth ==
                          GeneralHealthEnum.VeryGood),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Good",
                      selectedColor: Colors.orange,
                      isSelected: medicalExaminationModel.generalHealth ==
                          GeneralHealthEnum.Good),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Fair",
                      selectedColor: Colors.orange,
                      isSelected: medicalExaminationModel.generalHealth ==
                          GeneralHealthEnum.Fair),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Fail",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.generalHealth ==
                          GeneralHealthEnum.Fail),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      child: HorizontalRadioButtons(
                        names: ["None", "Pregnant", "Lactating"],
                        selectionColor: Colors.red,
                        notColoredWord: "None",
                        onChange: (value) {
                          if (value.toString().toLowerCase() == "pregnant") {
                            medicalExaminationModel.pregnancyStatus =
                                PregnancyEnum.Pregnant;
                          } else if (value.toString().toLowerCase() ==
                              "lactating") {
                            medicalExaminationModel.pregnancyStatus =
                                PregnancyEnum.Lactating;
                          } else if (value.toString().toLowerCase() == "none") {
                            medicalExaminationModel.pregnancyStatus =
                                PregnancyEnum.None;
                          }
                        },
                        groupValue: medicalExaminationModel.pregnancyStatus ==
                            PregnancyEnum.Pregnant
                            ? "Pregnant"
                            : medicalExaminationModel.pregnancyStatus ==
                            PregnancyEnum.Lactating
                            ? "Lactating"
                            : "None",
                      )),
                ],
              ),
              CIA_TextFormField(
                  label: "Are you treated for anything now?",
                  onChange: (value) =>
                  medicalExaminationModel.areYouTreatedFromAnyThing = value,
                  controller: TextEditingController(
                      text: medicalExaminationModel.areYouTreatedFromAnyThing)),
              CIA_TextFormField(
                  onChange: (value) =>
                  medicalExaminationModel.recentSurgery = value,
                  label: "Recent Surgery",
                  controller: TextEditingController(
                      text: medicalExaminationModel.recentSurgery)),
              CIA_TextFormField(
                  onChange: (value) => medicalExaminationModel.comment = value,
                  label: "Comment",
                  controller: TextEditingController(
                      text: medicalExaminationModel.comment)),
              FormTextKeyWidget(text: "Did you have ever?"),
              CIA_MultiSelectChipWidget(
                onChange: (value, isSelected) {
                  if (value == "Other") {
                    setState(() {
                      diseases = isSelected as bool;
                    });
                  }
                  DiseasesEnum? disease;
                  switch (value) {
                    case "Kidney Disease":
                      disease = DiseasesEnum.KidneyDisease;
                      break;
                    case "Liver Disease":
                      disease = DiseasesEnum.LiverDisease;
                      break;
                    case "Asthma":
                      disease = DiseasesEnum.Asthma;
                      break;
                    case "Psychological":
                      disease = DiseasesEnum.Psychological;
                      break;
                    case "Rhemuatic":
                      disease = DiseasesEnum.Rhemuatic;
                      break;
                    case "Anemia":
                      disease = DiseasesEnum.Anemia;
                      break;
                    case "Epilepsy":
                      disease = DiseasesEnum.Epilepsy;
                      break;
                    case "Heart problem":
                      disease = DiseasesEnum.HeartProblem;
                      break;
                    case "Thyroid":
                      disease = DiseasesEnum.Thyroid;
                      break;
                    case "Hepatitis":
                      disease = DiseasesEnum.Hepatitis;
                      break;
                    case "Venereal Disease":
                      disease = DiseasesEnum.VenerealDisease;
                      break;
                    case "Other":
                      disease = DiseasesEnum.Other;
                      break;
                  }
                  if (isSelected) {
                    if (medicalExaminationModel.diseases == null) {
                      medicalExaminationModel.diseases = [];
                    }
                    medicalExaminationModel.diseases?.add(disease!);
                  } else {
                    if (medicalExaminationModel.diseases == null) {
                      medicalExaminationModel.diseases = [];
                    } else {
                      medicalExaminationModel.diseases?.remove(disease);
                    }
                  }
                },
                redFlags: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Kidney Disease",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.KidneyDisease)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Liver Disease",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.LiverDisease)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Asthma",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Asthma)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Psychological",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Psychological)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Rhemuatic",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Rhemuatic)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Anemia",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Anemia)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Epilepsy",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Epilepsy)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Heart problem",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.HeartProblem)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Thyroid",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Thyroid)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hepatitis",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Hepatitis)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Venereal Disease",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.VenerealDisease)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Other",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null &&
                          medicalExaminationModel.diseases!
                              .contains(DiseasesEnum.Other))
                ],
              ),
              Visibility(
                  visible: diseases,
                  child: CIA_TextFormField(
                      onChange: (value) =>
                      medicalExaminationModel.otherDiseases = value,
                      label: "Other ",
                      controller: TextEditingController(
                          text: medicalExaminationModel.otherDiseases))),
              FormTextKeyWidget(text: "Blood Pressure"),
              CIA_MultiSelectChipWidget(
                onChange: (value, isSelected) {
                  BloodPressureEnum? bloodPressure;

                  switch (value) {
                    case "Normal":
                      bloodPressure = BloodPressureEnum.Normal;
                      break;
                    case "Hypertensive controller":
                      bloodPressure = BloodPressureEnum.HypertensiveControlled;
                      break;
                    case "Hypertensive uncontroller":
                      bloodPressure =
                          BloodPressureEnum.HypertensiveUncontrolled;
                      break;
                    case "Hypotensive controller":
                      bloodPressure = BloodPressureEnum.HypotensiveControlled;
                      break;
                    case "Hypotensive uncontroller":
                      bloodPressure = BloodPressureEnum.HypotensiveUncontrolled;
                      break;
                  }
                  if (isSelected) {
                    if (medicalExaminationModel.bloodPressure == null)
                      medicalExaminationModel.bloodPressure = BloodPressure();
                    medicalExaminationModel.bloodPressure?.status =
                        bloodPressure;
                  }
                },
                singleSelect: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Normal",
                      isSelected:
                      medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status ==
                              BloodPressureEnum.Normal),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypertensive controller",
                      isSelected:
                      medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status ==
                              BloodPressureEnum.HypertensiveControlled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypertensive uncontroller",
                      selectedColor: Colors.red,
                      isSelected:
                      medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status ==
                              BloodPressureEnum.HypertensiveUncontrolled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypotensive controller",
                      isSelected:
                      medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status ==
                              BloodPressureEnum.HypotensiveControlled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypotensive uncontroller",
                      selectedColor: Colors.red,
                      isSelected:
                      medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status ==
                              BloodPressureEnum.HypotensiveUncontrolled),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure =
                                  BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.lastReading =
                                value;
                          },
                          label: "Last Reading ",
                          controller: TextEditingController(
                              text: medicalExaminationModel
                                  .bloodPressure?.lastReading)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure =
                                  BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.when = value;
                          },
                          label: "When? ",
                          controller: TextEditingController(
                              text:
                              medicalExaminationModel.bloodPressure?.when)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure =
                                  BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.drug = value;
                          },
                          label: "Drug ",
                          controller: TextEditingController(
                              text:
                              medicalExaminationModel.bloodPressure?.drug)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure =
                                  BloodPressure();
                            }
                            medicalExaminationModel
                                .bloodPressure?.readingInClinic = value;
                          },
                          label: "Reading in clinic ",
                          controller: TextEditingController(
                              text: medicalExaminationModel
                                  .bloodPressure?.readingInClinic)),
                    ),
                  ),
                ],
              ),
              FormTextKeyWidget(text: "Glucose Status"),
              CIA_MultiSelectChipWidget(
                onChange: (value, isSelected) {
                  DiabetesEnum? diabetese;
                  switch (value) {
                    case "Non diabetic":
                      diabetese = DiabetesEnum.Normal;
                      break;
                    case "Diabetic controller":
                      diabetese = DiabetesEnum.DiabeticControlled;
                      break;
                    case "Diabetic uncontroller":
                      diabetese = DiabetesEnum.DiabeticUncontrolled;
                      break;
                  }
                  if (isSelected) {
                    if (medicalExaminationModel.diabetic == null)
                      medicalExaminationModel.diabetic = new Diabetic();
                    medicalExaminationModel.diabetic?.status = diabetese;
                  }
                },
                singleSelect: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Non diabetic",
                      isSelected: medicalExaminationModel.diabetic != null &&
                          medicalExaminationModel.diabetic?.status ==
                              DiabetesEnum.Normal),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Diabetic controller",
                      isSelected: medicalExaminationModel.diabetic != null &&
                          medicalExaminationModel.diabetic?.status ==
                              DiabetesEnum.DiabeticControlled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Diabetic uncontroller",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diabetic != null &&
                          medicalExaminationModel.diabetic?.status ==
                              DiabetesEnum.DiabeticUncontrolled),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CIA_DropDown(
                        onSelect: (value) {
                          if (medicalExaminationModel.diabetic == null)
                            medicalExaminationModel.diabetic = Diabetic();
                          if (value.toString().toLowerCase() == "random")
                            medicalExaminationModel.diabetic?.type =
                                DiabetesMeasureType.Random;
                          else if (value.toString().toLowerCase() == "fasting")
                            medicalExaminationModel.diabetic?.type =
                                DiabetesMeasureType.Fasting;
                        },
                        label: 'Type',
                        values: ["Random", "Fasting"],
                        selectedValue: medicalExaminationModel.diabetic != null
                            ? medicalExaminationModel.diabetic?.type.toString()
                            : "",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.diabetic == null) {
                              medicalExaminationModel.diabetic = Diabetic();
                            }
                            medicalExaminationModel.diabetic?.lastReading =
                                value;
                          },
                          label: "Last Reading ",
                          controller: TextEditingController(
                              text: medicalExaminationModel
                                  .diabetic?.lastReading)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.diabetic == null) {
                              medicalExaminationModel.diabetic = Diabetic();
                            }
                            medicalExaminationModel.diabetic?.when = value;
                          },
                          label: "When? ",
                          controller: TextEditingController(
                              text: medicalExaminationModel.diabetic?.when)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.diabetic == null) {
                              medicalExaminationModel.diabetic = Diabetic();
                            }
                            medicalExaminationModel.diabetic?.randomInClinic =
                                value;
                          },
                          label: "Random in clinic ",
                          controller: TextEditingController(
                              text: medicalExaminationModel
                                  .diabetic?.randomInClinic)),
                    ),
                  ),
                ],
              ),
              FormTextKeyWidget(text: "HBA1c"),
              CIA_IncrementalHBA1CTextField(
                  onChange: (value) {
                    medicalExaminationModel.hbA1c = value;
                  },
                  model: medicalExaminationModel.hbA1c != null
                      ? medicalExaminationModel.hbA1c as List<HbA1c>
                      : []),
              FormTextKeyWidget(text: "Are you allergic to?"),
              Row(
                children: [
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                        onChange: (value, isSelected) {
                          if (value == "Penicillin")
                            medicalExaminationModel.penicillin = isSelected;
                          else if (value == "Sulfa")
                            medicalExaminationModel.sulfa = isSelected;
                          else if (value == "Other")
                            medicalExaminationModel.otherAllergy = isSelected;
                        },
                        labels: [
                          CIA_MultiSelectChipWidgeModel(
                              label: "Penicillin",
                              selectedColor: Colors.red,
                              isSelected: medicalExaminationModel.penicillin !=
                                  null
                                  ? medicalExaminationModel.penicillin as bool
                                  : false),
                          CIA_MultiSelectChipWidgeModel(
                              label: "Sulfa",
                              isSelected: medicalExaminationModel.sulfa != null
                                  ? medicalExaminationModel.sulfa as bool
                                  : false),
                          CIA_MultiSelectChipWidgeModel(
                              label: "Other",
                              isSelected:
                              medicalExaminationModel.otherAllergy != null
                                  ? medicalExaminationModel.otherAllergy
                              as bool
                                  : false),
                        ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: CIA_TextFormField(
                        label: "Other Diseases",
                        controller: TextEditingController()),
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
                  CIA_MultiSelectChipWidget(
                      onChange: (value, isSelected) {
                        if (value == "Yes")
                          medicalExaminationModel.prolongedBleedingOrAspirin =
                              isSelected;
                        else if (value == "No")
                          medicalExaminationModel.prolongedBleedingOrAspirin =
                          !isSelected;
                      },
                      singleSelect: true,
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                            label: "Yes",
                            isSelected: medicalExaminationModel
                                .prolongedBleedingOrAspirin as bool),
                        CIA_MultiSelectChipWidgeModel(
                            label: "No",
                            isSelected: !(medicalExaminationModel
                                .prolongedBleedingOrAspirin as bool)),
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
                  CIA_MultiSelectChipWidget(
                      onChange: (value, isSelected) {
                        if (value == "Yes")
                          medicalExaminationModel.chronicDigestion = isSelected;
                        else if (value == "No")
                          medicalExaminationModel.chronicDigestion =
                          !isSelected;
                      },
                      singleSelect: true,
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                            label: "Yes",
                            isSelected: medicalExaminationModel.chronicDigestion
                            as bool),
                        CIA_MultiSelectChipWidgeModel(
                            label: "No",
                            isSelected: !(medicalExaminationModel
                                .chronicDigestion as bool)),
                      ]),
                ],
              ),
              CIA_TextFormField(
                changeColorIfFilled: true,
                borderColorOnChange: Colors.red,
                borderColor: illegalDrugs,
                label: "Illegal Drugs",
                controller: TextEditingController(
                    text: medicalExaminationModel.illegalDrugs),
                onChange: (value) {
                  medicalExaminationModel.illegalDrugs = value;
                },
              ),
              CIA_TextFormField(
                  onChange: (value) =>
                  medicalExaminationModel.operatorComments = value,
                  label: "Operator Comments",
                  controller: TextEditingController(
                      text: medicalExaminationModel.operatorComments)),
              FormTextKeyWidget(text: "Drugs Taken by patinet"),
              CIA_IncrementalTextField(
                label: "Drug Name",
              ),
            ]);
          } else {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color_Accent],
              ),
            );
          }
        });
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
  List<int> selectedTeeth = [];
  String selectedTooth = "";
  String selectedStatus = "";
  bool mobilityDegrees = false;
  late Future load;


  @override
  void initState() {
    load = MedicalAPI.GetPatientDentalExamination(patientID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var res = snapshot.data as API_Response;
            if (res.statusCode == 200)
              dentalExaminationModel = res.result as DentalExaminationModel;
            return CIA_MedicalPagesWidget(children: [
              Row(
                children: [
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth =
                            selectedItems.map((e) => int.parse(e)).toList();
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                          label: "11",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "12",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "13",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "14",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "15",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "16",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "17",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "18",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "19",
                        )
                      ],
                    ),
                  ),
                  SizedBox(),
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth =
                            selectedItems.map((e) => int.parse(e)).toList();
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                          label: "21",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "22",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "23",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "24",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "25",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "26",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "27",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "28",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "29",
                        )
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
                        selectedTeeth =
                            selectedItems.map((e) => int.parse(e)).toList();
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                          label: "31",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "32",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "33",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "34",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "35",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "36",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "37",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "38",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "39",
                        )
                      ],
                    ),
                  ),
                  SizedBox(),
                  Expanded(
                    child: CIA_MultiSelectChipWidget(
                      key: GlobalKey(),
                      onChangeList: (selectedItems) {
                        selectedTeeth =
                            selectedItems.map((e) => int.parse(e)).toList();
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(
                          label: "41",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "42",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "43",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "44",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "45",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "46",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "47",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "48",
                        ),
                        CIA_MultiSelectChipWidgeModel(
                          label: "49",
                        )
                      ],
                    ),
                  ),
                ],
              ),
              CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (value, isSelected) {
                  for (var tooth in selectedTeeth) {
                    var t = dentalExaminationModel.dentalExaminations
                        .firstWhereOrNull(
                            (element) => element.tooth.toString() == tooth);
                    if (t == null) {
                      dentalExaminationModel.dentalExaminations
                          .add(DentalExaminations(tooth: tooth));
                    }
                  }
                  if (isSelected) {
                    if (value == "Mobility") {
                      setState(() {
                        mobilityDegrees = true;
                      });
                    } else {
                      selectedTeeth.forEach((element) {
                        dentalExaminationModel.dentalExaminations
                            .firstWhere((x) => x.tooth == element)
                            .updateToothStatus(value);
                      });
                      selectedTeeth.clear();
                      setState(() {});
                    }
                  }
                },
                singleSelect: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                    label: "Carious",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Filled",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Missed",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Not Sure",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Mobility",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Hopeless teeth",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Implant Placed",
                  ),
                  CIA_MultiSelectChipWidgeModel(
                    label: "Implant Failed",
                  ),
                ],
              ),
              Visibility(
                visible: mobilityDegrees,
                child: CIA_MultiSelectChipWidget(
                  key: GlobalKey(),
                  onChange: (value, isSelected) {
                    if (isSelected) {
                      if (value == "I")
                        selectedTeeth.forEach((element) {
                          dentalExaminationModel.dentalExaminations
                              .firstWhere((x) => x.tooth == element)
                              .updateToothStatus("Mobility I");
                        });
                      else if (value == "II")
                        selectedTeeth.forEach((element) {
                          dentalExaminationModel.dentalExaminations
                              .firstWhere((x) => x.tooth == element)
                              .updateToothStatus("Mobility II");
                        });
                      else if (value == "III")
                        selectedTeeth.forEach((element) {
                          dentalExaminationModel.dentalExaminations
                              .firstWhere((x) => x.tooth == element)
                              .updateToothStatus("Mobility III");
                        });

                      setState(() {
                        mobilityDegrees = false;
                      });
                    }
                  },
                  singleSelect: true,
                  labels: [
                    CIA_MultiSelectChipWidgeModel(
                        label: "I", isSelected: false),
                    CIA_MultiSelectChipWidgeModel(
                        label: "II", isSelected: false),
                    CIA_MultiSelectChipWidgeModel(
                        label: "III", isSelected: false),
                  ],
                ),
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Carious",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.carious == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) => element.previousState! == "carious") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) => element.previousState! == "carious")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) {
                  MasterController.updateDentalExamination("Carious", value);
                },
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .carious = false;
                },
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Filled",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.filled == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) => element.previousState! == "filled") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) => element.previousState! == "filled")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) =>
                    MasterController.updateDentalExamination("Filled", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .filled = false;
                },
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Missed",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.missed == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) => element.previousState! == "missed") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) => element.previousState! == "missed")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) =>
                    MasterController.updateDentalExamination("Missed", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .missed = false;
                },
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Not Sure",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.notSure == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) => element.previousState! == "notSure") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) => element.previousState! == "notSure")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) =>
                    MasterController.updateDentalExamination("Not Sure", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .notSure = false;
                },
              ),
              Row(
                children: [
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TagsInputWidget(
                      key: GlobalKey(),
                      patientController: MasterController,
                      label: "Mobility I",
                      initialValue: dentalExaminationModel.dentalExaminations
                          .where((element) => element.mobilityI == true)
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList(),
                      strikeValues: dentalExaminationModel.dentalExaminations
                          .where((element) =>
                      element.previousState! == "mobilityI") !=
                          null
                          ? dentalExaminationModel.dentalExaminations
                          .where((element) =>
                      element.previousState! == "mobilityI")
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList()
                          : null,
                      onChange: (value) =>
                          MasterController.updateDentalExamination(
                              "Mobility I", value),
                      onDelete: (value) {
                        dentalExaminationModel.dentalExaminations
                            .firstWhere(
                                (element) => element.tooth.toString() == value)
                            .mobilityI = false;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TagsInputWidget(
                      key: GlobalKey(),
                      patientController: MasterController,
                      label: "Mobility II",
                      initialValue: dentalExaminationModel.dentalExaminations
                          .where((element) => element.mobilityII == true)
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList(),
                      strikeValues: dentalExaminationModel.dentalExaminations
                          .where((element) =>
                      element.previousState! == "mobilityII") !=
                          null
                          ? dentalExaminationModel.dentalExaminations
                          .where((element) =>
                      element.previousState! == "mobilityII")
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList()
                          : null,
                      onChange: (value) =>
                          MasterController.updateDentalExamination(
                              "Mobility II", value),
                      onDelete: (value) {
                        dentalExaminationModel.dentalExaminations
                            .firstWhere(
                                (element) => element.tooth.toString() == value)
                            .mobilityII = false;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TagsInputWidget(
                      key: GlobalKey(),
                      patientController: MasterController,
                      label: "Mobility III",
                      initialValue: dentalExaminationModel.dentalExaminations
                          .where((element) => element.mobilityIII == true)
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList(),
                      strikeValues: dentalExaminationModel.dentalExaminations
                          .where((element) =>
                      element.previousState! ==
                          "mobilityIII") !=
                          null
                          ? dentalExaminationModel.dentalExaminations
                          .where((element) =>
                      element.previousState! == "mobilityIII")
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList()
                          : null,
                      onChange: (value) =>
                          MasterController.updateDentalExamination(
                              "Mobility III", value),
                      onDelete: (value) {
                        dentalExaminationModel.dentalExaminations
                            .firstWhere(
                                (element) => element.tooth.toString() == value)
                            .mobilityIII = false;
                      },
                    ),
                  ),
                ],
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Hopeless teeth",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.hopelessteeth == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) =>
                    element.previousState! == "hopelessteeth") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) =>
                element.previousState! == "hopelessteeth")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) => MasterController.updateDentalExamination(
                    "Hopeless teeth", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .hopelessteeth = false;
                },
              ),
              Row(
                children: [
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TextFormField(
                      suffix: "mm",
                      isNumber: true,
                      label: "Inter arch space RT",
                      onChange: (value) {
                        dentalExaminationModel.interarchspaceRT =
                            int.parse(value);
                      },
                      controller: TextEditingController(
                        text: (dentalExaminationModel.interarchspaceRT ?? 0)
                            .toString(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TextFormField(
                        suffix: "mm",
                        isNumber: true,
                        label: "Inter arch space LT",
                        onChange: (value) {
                          dentalExaminationModel.interarchspaceLT =
                              int.parse(value);
                        },
                        controller: TextEditingController(
                          text: (dentalExaminationModel.interarchspaceLT ?? 0)
                              .toString(),
                        )),
                  ),
                ],
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Implant Placed",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.implantPlaced == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) =>
                    element.previousState! == "implantPlaced") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) =>
                element.previousState! == "implantPlaced")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) => MasterController.updateDentalExamination(
                    "Implant Placed", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .implantPlaced = false;
                },
              ),
              CIA_TagsInputWidget(
                key: GlobalKey(),
                patientController: MasterController,
                label: "Implant Failed",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.implantFailed == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where(
                        (element) =>
                    element.previousState! == "implantFailed") !=
                    null
                    ? dentalExaminationModel.dentalExaminations
                    .where((element) =>
                element.previousState! == "implantFailed")
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList()
                    : null,
                onChange: (value) => MasterController.updateDentalExamination(
                    "Implant Failed", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations
                      .firstWhere(
                          (element) => element.tooth.toString() == value)
                      .implantFailed = false;
                },
              ),
              CIA_TextFormField(
                  label: "Operator Implant Notes",
                  onChange: (value) {
                    dentalExaminationModel.operatorImplantNotes = value;

                  },
                  controller: TextEditingController(
                      text: dentalExaminationModel.operatorImplantNotes??""))
            ]);
          } else {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color_Accent],
              ),
            );
          }
        });
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
  late Future<API_Response> load;

  @override
  void initState() {
    load = TempPatientAPI.GetDentalHistory(patientID);
    super.initState();
  }

  @override
  void dispose() {
    TempPatientAPI.UpdateDentalHistory(patientID, dentalHistoryModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var res = snapshot.data as API_Response;
            if (res.statusCode == 200) {
              dentalHistoryModel = res.result as DentalHistoryModel;
              return CIA_MedicalPagesWidget(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: FormTextKeyWidget(
                              text: "Are your teeth sensitive to ?")),
                      Expanded(
                          flex: 2,
                          child: CIA_MultiSelectChipWidget(
                              onChange: (value, isSelected) {
                                if (value.toString() == "Hot or cold")
                                  dentalHistoryModel.senstiveHotCold =
                                      isSelected;
                                else if (value.toString() == "sweets")
                                  dentalHistoryModel.senstiveSweets =
                                      isSelected;
                                else if (value.toString() ==
                                    "Biting or chewing")
                                  dentalHistoryModel.bittingCheweing =
                                      isSelected;
                              },
                              labels: [
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Hot or cold",
                                    isSelected:
                                    dentalHistoryModel.senstiveHotCold ??
                                        false),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "sweets",
                                    isSelected:
                                    dentalHistoryModel.senstiveSweets ??
                                        false),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Biting or chewing",
                                    isSelected:
                                    dentalHistoryModel.bittingCheweing ??
                                        false),
                              ]))
                    ],
                  ),
                  CIA_TextFormField(
                      borderColor: clench,
                      borderColorOnChange: Colors.orange,
                      changeColorIfFilled: true,
                      onChange: (value) {
                        dentalHistoryModel.clench = value;
                      },
                      label:
                      "Do you clench or grind your teeth while awake or sleep?",
                      controller: TextEditingController(
                          text: dentalHistoryModel.clench)),
                  Row(
                    children: [
                      Expanded(
                          child: FormTextKeyWidget(
                            text: "Smoke Tobacco?",
                          )),
                      Expanded(
                          child: CIA_TextFormField(
                              onChange: (value) {
                                dentalHistoryModel.smoke = int.parse(value);
                                setState(() {
                                  tobacco = value;
                                });
                              },
                              label: "Cigarette per day",
                              controller: TextEditingController(
                                  text: dentalHistoryModel.smoke == null
                                      ? null
                                      : dentalHistoryModel.smoke.toString()))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: FormTextValueWidget(
                              text: dentalHistoryModel.smoke != null &&
                                  (dentalHistoryModel.smoke!) == 0
                                  ? "Non Smoker"
                                  : dentalHistoryModel.smoke != null &&
                                  (dentalHistoryModel.smoke!) < 10
                                  ? "Light Smoker"
                                  : dentalHistoryModel.smoke != null &&
                                  (dentalHistoryModel.smoke!) < 20
                                  ? "Medium Smoker"
                                  : "Heavy Smoker")),
                      Expanded(flex: 3, child: SizedBox())
                    ],
                  ),
                  CIA_TextFormField(
                      onChange: (value) =>
                      dentalHistoryModel.seriousInjury = value,
                      label: "A serious injury to the mouth?",
                      controller: TextEditingController(
                          text: dentalHistoryModel.seriousInjury)),
                  CIA_TextFormField(
                      onChange: (value) => dentalHistoryModel.satisfied = value,
                      label: "Are you satisfied with your teeth's appearance?",
                      controller: TextEditingController(
                          text: dentalHistoryModel.satisfied)),
                  Row(
                    children: [
                      Expanded(
                          child: FormTextKeyWidget(
                              text: "Patient Cooperation Score")),
                      Expanded(
                          child: CIA_TextFormField(
                              onChange: (value) => dentalHistoryModel
                                  .cooperationScore = int.parse(value),
                              label: "",
                              controller: TextEditingController(
                                  text: dentalHistoryModel.cooperationScore !=
                                      null
                                      ? dentalHistoryModel.cooperationScore
                                      .toString()
                                      : null))),
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
                              onChange: (value) => dentalHistoryModel
                                  .willingForImplantScore = int.parse(value),
                              label: "",
                              controller: TextEditingController(
                                  text: dentalHistoryModel
                                      .willingForImplantScore !=
                                      null
                                      ? dentalHistoryModel
                                      .willingForImplantScore
                                      .toString()
                                      : null))),
                      Expanded(child: FormTextKeyWidget(text: "/10")),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ],
              );
            }
            return Container();
          } else {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color_Accent],
              ),
            );
          }
        });
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
  late List<DentalExaminationModel> tempDentalExamination;
  late Future load;

  @override
  void dispose() {
    TempPatientAPI.UpdateDentalExamination(patientID, tempDentalExamination);
    TempPatientAPI.UpdatePatientNonSurgicalTreatment(
        patientID, nonSurgicalTreatment);
    super.dispose();
  }

  @override
  void initState() {
    load = loadFuntionc();
    for (String tooth in MasterController.getTeeth()) {
      if ((MasterController.nonSurgicalTreatment as String).contains(tooth)) {
        containedTeeth.add(tooth);
      }
    }
  }

  loadFuntionc() async {
    var r = await TempPatientAPI.GetPatientNonSurgicalTreatment(patientID);
    if (r.statusCode == 200) {
      nonSurgicalTreatment = r.result as NonSurgicalTreatmentModel;
    }
    await Future.delayed(Duration(milliseconds: 600));
    r = await TempPatientAPI.GetDentalExamination(patientID);
    if (r.statusCode == 200) {
      tempDentalExamination = r.result as List<DentalExaminationModel>;
    }
    textController.text = nonSurgicalTreatment.treatment ?? "";
    return Future.value(r);
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CIA_MedicalPagesWidget(children: [
              CIA_TextFormField(
                onInstantChange: (value) async {
                  nonSurgicalTreatment.treatment = value;
                  containedTeeth.clear();
                  MasterController.getTeeth().forEach((element) {
                    if ((value as String).contains(element)) {
                      containedTeeth.add(element);
                    }
                  });
                  setState(() {});
                },
                label: "Treatment",
                controller: textController,
                maxLines: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: CIA_DropDown(
                        onSelect: (value) {
                          nonSurgicalTreatment.supervisorName = value;
                        },
                        selectedValue: nonSurgicalTreatment.supervisorName,
                        label: "Supervisor",
                        values: [
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
                        CIA_PopupDialog_Table(patientID, context,
                            "View History Treatments", (value) {});
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
          } else {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color_Accent],
              ),
            );
          }
        });
  }

  _buildTeethSuggestion() {
    List<Widget> uu = <Widget>[];
    /*containedTeeth.forEach((tooth) {
      var m = tempDentalExamination
          .firstWhereOrNull((element) => element.tooth.toString() == tooth);
      if (m == null) m = DentalExaminationModel(tooth: int.parse(tooth));
      List<CIA_MultiSelectChipWidgeModel> tempModel = [
        CIA_MultiSelectChipWidgeModel(
            label: "Carious",
            isSelected: m != null ? (m.carious) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Filled",
            isSelected: m != null ? (m.filled) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Missed",
            isSelected: m != null ? (m.missed) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Not Sure",
            isSelected: m != null ? (m.notSure) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility I",
            isSelected: m != null ? (m.mobilityI) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility II",
            isSelected: m != null ? (m.mobilityII) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility III",
            isSelected: m != null ? (m.mobilityIII) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Hopeless teeth",
            isSelected: m != null ? (m.hopelessteeth) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Placed",
            isSelected: m != null ? (m.implantPlaced) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Failed",
            isSelected: m != null ? (m.implantFailed) as bool : false),
      ];

      uu.add(FormTextKeyWidget(text: "Do you want to update tooth $tooth?"));
      uu.add(CIA_MultiSelectChipWidget(
        key: LabeledGlobalKey(tooth),
        singleSelect: true,
        labels: tempModel,
        onChange: (value, isSelected) {
          var m = tempDentalExamination
              .firstWhereOrNull((element) => element.tooth.toString() == tooth);

          if (m!.carious!) {
            m!.previousState = "carious";
            m.carious = false;
          }
          if (m!.missed!) {
            m!.previousState = "missed";
            m.missed = false;
          }
          if (m!.filled!) {
            m!.previousState = "filled";
            m.filled = false;
          }
          if (m!.notSure!) {
            m!.previousState = "notSure";
            m.notSure = false;
          }
          if (m!.mobilityIII!) {
            m!.previousState = "mobilityIII";
            m.mobilityIII = false;
          }
          if (m!.mobilityII!) {
            m!.previousState = "mobilityII";
            m.mobilityII = false;
          }
          if (m!.mobilityI!) {
            m!.previousState = "mobilityI";
            m.mobilityI = false;
          }
          if (m!.hopelessteeth!) {
            m!.previousState = "hopelessteeth";
            m.hopelessteeth = false;
          }
          if (m!.implantFailed!) {
            m!.previousState = "implantFailed";
            m.implantFailed = false;
          }
          if (m!.implantPlaced!) {
            m!.previousState = "implantPlaced";
            m.implantPlaced = false;
          }
          if (isSelected) m.updateToothStatus(value);
        },
      ));
      uu.add(SizedBox(height: 10));
    });*/

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
        Row(
          children: [
            FormTextKeyWidget(text: "Current Selected State"),
            SizedBox(width: 10),
            myActiveIndex != null
                ? FormTextValueWidget(text: stepModels[myActiveIndex!].name)
                : Text(""),
          ],
        ),
        SizedBox(
          height: 20,
        ),
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
