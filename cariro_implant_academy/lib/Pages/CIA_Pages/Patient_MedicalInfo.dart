import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/MedicalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/ProstheticTreatmentModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/TreatmentPlanModel.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/PatientSharedPages.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Calendar.dart';
import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_StepTimelineWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../API/TempPatientAPI.dart';
import '../../Constants/Controllers.dart';
import '../../Controllers/PatientMedicalController.dart';
import '../../Models/API_Response.dart';
import '../../Models/Enum.dart';
import '../../Models/MedicalModels/DentalHistory.dart';
import '../../Models/MedicalModels/NonSurgicalTreatment.dart';
import '../../Models/MedicalModels/SurgicalTreatmentModel.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_IncrementalHBA1CTextField.dart';
import '../../Widgets/CIA_IncrementalTextField.dart';
import '../../Widgets/CIA_MedicalAbsrobPointerWidget.dart';
import '../../Widgets/CIA_MedicalPageWidget.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/CIA_TagsInputWidget.dart';
import '../../Widgets/CIA_TeethChart.dart';
import '../../Widgets/CIA_TeethTreatmentWidget.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/MedicalSlidingBar.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import 'package:collection/collection.dart';

import '../../Widgets/SnackBar.dart';
import '../LAB_Pages/LAB_ViewTask.dart';
import '../SharedPages/LapCreateNewRequestSharedPage.dart';

late MedicalExaminationModel medicalExaminationModel;
late DentalHistoryModel dentalHistoryModel;
late DentalExaminationModel dentalExaminationModel;
late DentalExaminationModel tempDentalExamination;
late NonSurgicalTreatmentModel nonSurgicalTreatment;
late TreatmentPlanModel treatmentPlanModel;
late SurgicalTreatmentModel surgicalTreatmentModel;

class _getxClass extends GetxController {
  static RxInt tobacco = 0.obs;
  static RxList<int> containedTeeth = <int>[].obs;
}

class PatientMedicalInfoPage extends StatefulWidget {
  PatientMedicalInfoPage({Key? key, required this.patientId, required this.child}) : super(key: key);
  int patientId;
  Widget child;

  @override
  State<PatientMedicalInfoPage> createState() => _PatientMedicalInfoPageState();
}

class _PatientMedicalInfoPageState extends State<PatientMedicalInfoPage> {
  late PatientInfoModel patient;

  @override
  void initState() {
    patient = PatientInfoModel();

    print("medical rebuilt");
  }

  int index = 0;

  Uint8List? personalImageBytes;

  @override
  Widget build(BuildContext context) {
    patient?.gender = "Male";
    return CIA_FutureBuilder(loadFunction: () async {
      var res = await PatientAPI.GetPatientData(widget.patientId);
      if (res.statusCode == 200) {
        var temp = res.result as PatientInfoModel;
        if (temp.profileImageId != null)
          await PatientAPI.DownloadImage(temp.profileImageId!).then(
            (value) {
              if (value.statusCode == 200) personalImageBytes = base64Decode(value.result as String);
            },
          );
      }
      return res;
    }(), onSuccess: (data) {
      patient = data as PatientInfoModel;
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Expanded(
                    child: TitleWidget(
                      showBackButton: true,
                      title: siteController.title,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: widget.child,
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
                        personalImageBytes == null
                            ? Image(
                                image: AssetImage("assets/ProfileImage.png"),
                                height: 100,
                                width: 100,
                              )
                            : Image(
                                image: MemoryImage(personalImageBytes!),
                                height: 100,
                                width: 100,
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_SecondaryButton(
                            label: "View more info",
                            onTab: () {
                              print("pressed more info");
                              context.goNamed(PatientInfo_SharedPage.viewPatientRouteName, pathParameters: {"id": widget.patientId.toString()});
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_SecondaryButton(
                            label: "Create LAB Request",
                            icon: Icon(Icons.document_scanner_outlined),
                            onTab: () {
                              CIA_ShowPopUp(
                                hideButton: true,
                                context: context,
                                width: 1100,
                                height: 650,
                                onSave: () {},
                                child: LabCreateNewRequestSharedPage(isDoctor: true, patient: patient),
                              );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_SecondaryButton(
                            label: "View LAB Request",
                            icon: Icon(Icons.document_scanner_outlined),
                            onTab: () {
                              LabRequestDataSource dataSource = LabRequestDataSource();
                              CIA_ShowPopUp(
                                hideButton: true,
                                context: context,
                                width: 1100,
                                height: 650,
                                onSave: () {},
                                child: CIA_Table(
                                  columnNames: dataSource.columns,
                                  dataSource: dataSource,
                                  loadFunction: ()async{
                                    return  dataSource.loadPatientRequests(patient!.id!);
                                  },
                                  onCellClick: (index) {
                                    CIA_ShowPopUp(width: 1100,
                                        height: 650,context: context,child: LAB_ViewTaskPage(id: dataSource.models[index-1].id!,));
                                  },
                                ),
                              );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => !siteController.disableMedicalEdit.value
                            ? CIA_SecondaryButton(label: "View mode", onTab: () => siteController.disableMedicalEdit.value = true)
                            : CIA_PrimaryButton(label: "Edit mode", onTab: () => siteController.disableMedicalEdit.value = false)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(child: FormTextKeyWidget(text: "ID")),
                            Expanded(
                              child: FormTextValueWidget(
                                text: patient?.id.toString() == null ? "" : patient?.id.toString(),
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
                              child: FormTextValueWidget(text: patient?.name == null ? "" : patient?.name),
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
                              child: FormTextValueWidget(text: patient?.gender == null ? "" : patient?.gender),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
    });
  }
}

class PatientMedicalHistory extends StatefulWidget {
  PatientMedicalHistory({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "MedicalHistory";
  static String routePath = "Patients/:id/MedicalHistory";
  int patientId;

  static String getPath(String id) {
    return "/CIA/Patients/$id/MedicalHistory";
  }

  @override
  State<PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory> {
  bool diseases = false;
  Color illegalDrugs = Color_TextFieldBorder;
  late Future load;

  @override
  void initState() {
    load = MedicalAPI.GetPatientMedicalExamination(widget.patientId);
  }

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value) MedicalAPI.UpdatePatientMedicalExamination(widget.patientId, medicalExaminationModel);
    siteController.disableMedicalEdit.value = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var resp = snapshot.data as API_Response;
            if (resp.statusCode == 200) medicalExaminationModel = resp.result as MedicalExaminationModel;
            return CIA_MedicalPagesWidget(children: [
              FormTextKeyWidget(text: "General Health"),
              CIA_MultiSelectChipWidget(
                singleSelect: true,
                onChange: (value, isSelected) {
                  switch (value) {
                    case "Excellent":
                      medicalExaminationModel.generalHealth = GeneralHealthEnum.Excellent;
                      break;
                    case "Very good":
                      medicalExaminationModel.generalHealth = GeneralHealthEnum.VeryGood;
                      break;
                    case "Good":
                      medicalExaminationModel.generalHealth = GeneralHealthEnum.Good;
                      break;
                    case "Fair":
                      medicalExaminationModel.generalHealth = GeneralHealthEnum.Fair;
                      break;
                    case "Fail":
                      medicalExaminationModel.generalHealth = GeneralHealthEnum.Fail;
                      break;
                  }
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Excellent", selectedColor: Colors.green, isSelected: medicalExaminationModel.generalHealth == GeneralHealthEnum.Excellent),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Very good", selectedColor: Colors.green, isSelected: medicalExaminationModel.generalHealth == GeneralHealthEnum.VeryGood),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Good", selectedColor: Colors.orange, isSelected: medicalExaminationModel.generalHealth == GeneralHealthEnum.Good),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Fair", selectedColor: Colors.orange, isSelected: medicalExaminationModel.generalHealth == GeneralHealthEnum.Fair),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Fail", selectedColor: Colors.red, isSelected: medicalExaminationModel.generalHealth == GeneralHealthEnum.Fail),
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
                        medicalExaminationModel.pregnancyStatus = PregnancyEnum.Pregnant;
                      } else if (value.toString().toLowerCase() == "lactating") {
                        medicalExaminationModel.pregnancyStatus = PregnancyEnum.Lactating;
                      } else if (value.toString().toLowerCase() == "none") {
                        medicalExaminationModel.pregnancyStatus = PregnancyEnum.None;
                      }
                    },
                    groupValue: medicalExaminationModel.pregnancyStatus == PregnancyEnum.Pregnant
                        ? "Pregnant"
                        : medicalExaminationModel.pregnancyStatus == PregnancyEnum.Lactating
                            ? "Lactating"
                            : "None",
                  )),
                ],
              ),
              CIA_TextFormField(
                  label: "Are you treated for anything now?",
                  onChange: (value) => medicalExaminationModel.areYouTreatedFromAnyThing = value,
                  controller: TextEditingController(text: medicalExaminationModel.areYouTreatedFromAnyThing)),
              CIA_TextFormField(
                  onChange: (value) => medicalExaminationModel.recentSurgery = value,
                  label: "Recent Surgery",
                  controller: TextEditingController(text: medicalExaminationModel.recentSurgery)),
              CIA_TextFormField(
                  onChange: (value) => medicalExaminationModel.comment = value,
                  label: "Comment",
                  controller: TextEditingController(text: medicalExaminationModel.comment)),
              FormTextKeyWidget(text: "Did you have ever?"),
              CIA_MultiSelectChipWidget(
                onChange: (value, isSelected) {
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
                  if (medicalExaminationModel.diseases == null) {
                    medicalExaminationModel.diseases = [];
                  }
                  if (isSelected) {
                    medicalExaminationModel.diseases?.add(disease!);
                    print(medicalExaminationModel.diseases.toString());
                  } else {
                    medicalExaminationModel.diseases?.remove(disease);
                    print(medicalExaminationModel.diseases.toString());
                  }
                },
                redFlags: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Kidney Disease",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.KidneyDisease)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Liver Disease",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.LiverDisease)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Asthma",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Asthma)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Psychological",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Psychological)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Rhemuatic",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Rhemuatic)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Anemia",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Anemia)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Epilepsy",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Epilepsy)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Heart problem",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.HeartProblem)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Thyroid",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Thyroid)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hepatitis",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Hepatitis)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Venereal Disease",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.VenerealDisease)),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Other",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diseases != null && medicalExaminationModel.diseases!.contains(DiseasesEnum.Other))
                ],
              ),
              FormTextKeyWidget(text: "Blood Pressure"),
              CIA_MultiSelectChipWidget(
                onChange: (value, isSelected) {
                  BloodPressureEnum? bloodPressure;

                  switch (value) {
                    case "Normal":
                      bloodPressure = BloodPressureEnum.Normal;
                      break;
                    case "Hypertensive controlled":
                      bloodPressure = BloodPressureEnum.HypertensiveControlled;
                      break;
                    case "Hypertensive uncontrolled":
                      bloodPressure = BloodPressureEnum.HypertensiveUncontrolled;
                      break;
                    case "Hypotensive controlled":
                      bloodPressure = BloodPressureEnum.HypotensiveControlled;
                      break;
                    case "Hypotensive uncontrolled":
                      bloodPressure = BloodPressureEnum.HypotensiveUncontrolled;
                      break;
                  }
                  if (isSelected) {
                    if (medicalExaminationModel.bloodPressure == null) medicalExaminationModel.bloodPressure = BloodPressure();
                    medicalExaminationModel.bloodPressure?.status = bloodPressure;
                  }
                },
                singleSelect: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Normal",
                      isSelected: medicalExaminationModel.bloodPressure != null && medicalExaminationModel.bloodPressure?.status == BloodPressureEnum.Normal),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypertensive controlled",
                      isSelected: medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status == BloodPressureEnum.HypertensiveControlled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypertensive uncontrolled",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status == BloodPressureEnum.HypertensiveUncontrolled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypotensive controlled",
                      isSelected: medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status == BloodPressureEnum.HypotensiveControlled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Hypotensive uncontrolled",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.bloodPressure != null &&
                          medicalExaminationModel.bloodPressure?.status == BloodPressureEnum.HypotensiveUncontrolled),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          validator: (value) {
                            if (value == "" || value == null) value = "0";
                            if (value.length > 1 && value[0] == "0") value = value.replaceFirst("0", "");
                            var regExp = RegExp("/");
                            Iterable<Match> match = regExp.allMatches(
                              value,
                            );
                            if (match.length > 1) value = value.replaceRange(value.lastIndexOf("/"), value.lastIndexOf("/") + 1, "");
                            if (!value.contains("/")) {
                              if (int.parse(value) > 200) {
                                int temp = int.parse(value.substring(0, 3));
                                if (temp > 200)
                                  value = value.substring(0, 2) + "/" + value.substring(2);
                                else {
                                  value = value.substring(0, 3) + "/" + value.substring(3);
                                }
                              }
                            } else if (int.parse(value.split("/").last) > 999) {
                              value = value.replaceRange(value.length - 1, value.length, "");
                            }
                            if (value.contains("/0")) value = value.replaceAll("/0", "/");

                            return value;
                          },
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                          ],
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure = BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.lastReading = value;
                          },
                          label: "Last Reading ",
                          controller: TextEditingController(text: medicalExaminationModel.bloodPressure?.lastReading)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_DateTimeTextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure = BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.when = value;
                          },
                          label: "When? ",
                          controller: TextEditingController(text: medicalExaminationModel.bloodPressure?.when)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure = BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.drug = value;
                          },
                          label: "Drug ",
                          controller: TextEditingController(text: medicalExaminationModel.bloodPressure?.drug)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CIA_TextFormField(
                          validator: (value) {
                            if (value == "" || value == null) value = "0";
                            if (value.length > 1 && value[0] == "0") value = value.replaceFirst("0", "");
                            var regExp = RegExp("/");
                            Iterable<Match> match = regExp.allMatches(
                              value,
                            );
                            if (match.length > 1) value = value.replaceRange(value.lastIndexOf("/"), value.lastIndexOf("/") + 1, "");
                            if (!value.contains("/")) {
                              if (int.parse(value) > 200) {
                                int temp = int.parse(value.substring(0, 3));
                                if (temp > 200)
                                  value = value.substring(0, 2) + "/" + value.substring(2);
                                else {
                                  value = value.substring(0, 3) + "/" + value.substring(3);
                                }
                              }
                            } else if (int.parse(value.split("/").last) > 999) {
                              value = value.replaceRange(value.length - 1, value.length, "");
                            }
                            if (value.contains("/0")) value = value.replaceAll("/0", "/");

                            return value;
                          },
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                          ],
                          onChange: (value) {
                            if (medicalExaminationModel.bloodPressure == null) {
                              medicalExaminationModel.bloodPressure = BloodPressure();
                            }
                            medicalExaminationModel.bloodPressure?.readingInClinic = value;
                          },
                          label: "Reading in clinic ",
                          controller: TextEditingController(text: medicalExaminationModel.bloodPressure?.readingInClinic)),
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
                    case "Diabetic controlled":
                      diabetese = DiabetesEnum.DiabeticControlled;
                      break;
                    case "Diabetic uncontrolled":
                      diabetese = DiabetesEnum.DiabeticUncontrolled;
                      break;
                  }
                  if (isSelected) {
                    if (medicalExaminationModel.diabetic == null) medicalExaminationModel.diabetic = new Diabetic();
                    medicalExaminationModel.diabetic?.status = diabetese;
                  }
                },
                singleSelect: true,
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Non diabetic",
                      isSelected: medicalExaminationModel.diabetic != null && medicalExaminationModel.diabetic?.status == DiabetesEnum.Normal),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Diabetic controlled",
                      isSelected: medicalExaminationModel.diabetic != null && medicalExaminationModel.diabetic?.status == DiabetesEnum.DiabeticControlled),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Diabetic uncontrolled",
                      selectedColor: Colors.red,
                      isSelected: medicalExaminationModel.diabetic != null && medicalExaminationModel.diabetic?.status == DiabetesEnum.DiabeticUncontrolled),
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
                          if (medicalExaminationModel.diabetic == null) medicalExaminationModel.diabetic = Diabetic();
                          if (value.toString().toLowerCase() == "random")
                            medicalExaminationModel.diabetic?.type = DiabetesMeasureType.Random;
                          else if (value.toString().toLowerCase() == "fasting") medicalExaminationModel.diabetic?.type = DiabetesMeasureType.Fasting;
                        },
                        label: 'Type',
                        values: ["Random", "Fasting"],
                        selectedValue: medicalExaminationModel.diabetic != null ? medicalExaminationModel.diabetic?.type!.name : "",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          isNumber: true,
                          onChange: (value) {
                            if (medicalExaminationModel.diabetic == null) {
                              medicalExaminationModel.diabetic = Diabetic();
                            }
                            medicalExaminationModel.diabetic?.lastReading = int.parse(value);
                          },
                          label: "Last Reading ",
                          controller: TextEditingController(text: medicalExaminationModel.diabetic?.lastReading.toString())),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_DateTimeTextFormField(
                          onChange: (value) {
                            if (medicalExaminationModel.diabetic == null) {
                              medicalExaminationModel.diabetic = Diabetic();
                            }
                            medicalExaminationModel.diabetic?.when = value;
                          },
                          label: "When? ",
                          controller: TextEditingController(text: medicalExaminationModel.diabetic?.when)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CIA_TextFormField(
                          isNumber: true,
                          onChange: (value) {
                            if (medicalExaminationModel.diabetic == null) {
                              medicalExaminationModel.diabetic = Diabetic();
                            }
                            medicalExaminationModel.diabetic?.randomInClinic = int.parse(value);
                          },
                          label: "Random in clinic ",
                          controller: TextEditingController(text: medicalExaminationModel.diabetic?.randomInClinic.toString())),
                    ),
                  ),
                ],
              ),
              FormTextKeyWidget(text: "HBA1c"),
              CIA_IncrementalHBA1CTextField(
                  onChange: (value) {
                    medicalExaminationModel.hbA1c = value;
                  },
                  model: medicalExaminationModel.hbA1c != null ? medicalExaminationModel.hbA1c as List<HbA1c> : []),
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
                          else if (value == "Other") medicalExaminationModel.otherAllergy = isSelected;
                        },
                        labels: [
                          CIA_MultiSelectChipWidgeModel(
                              label: "Penicillin",
                              selectedColor: Colors.red,
                              isSelected: medicalExaminationModel.penicillin != null ? medicalExaminationModel.penicillin as bool : false),
                          CIA_MultiSelectChipWidgeModel(
                              label: "Sulfa", isSelected: medicalExaminationModel.sulfa != null ? medicalExaminationModel.sulfa as bool : false),
                          CIA_MultiSelectChipWidgeModel(
                              label: "Other", isSelected: medicalExaminationModel.otherAllergy != null ? medicalExaminationModel.otherAllergy as bool : false),
                        ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: CIA_TextFormField(
                        label: "Other Allergy",
                        onChange: (value) => medicalExaminationModel.otherAllergyComment = value,
                        controller: TextEditingController(text: medicalExaminationModel.otherAllergyComment ?? "")),
                  )
                ],
              ),
              Row(
                children: [
                  FormTextKeyWidget(text: "Are you Subjected to prolonged bleeding or taking aspirin?"),
                  SizedBox(
                    width: 10,
                  ),
                  CIA_MultiSelectChipWidget(
                      onChange: (value, isSelected) {
                        if (value == "Yes")
                          medicalExaminationModel.prolongedBleedingOrAspirin = isSelected;
                        else if (value == "No") medicalExaminationModel.prolongedBleedingOrAspirin = !isSelected;
                      },
                      singleSelect: true,
                      labels: [
                        CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: medicalExaminationModel.prolongedBleedingOrAspirin as bool),
                        CIA_MultiSelectChipWidgeModel(label: "No", isSelected: !(medicalExaminationModel.prolongedBleedingOrAspirin as bool)),
                      ]),
                ],
              ),
              Row(
                children: [
                  FormTextKeyWidget(text: "Do you have chronic problem with digestion?"),
                  SizedBox(
                    width: 10,
                  ),
                  CIA_MultiSelectChipWidget(
                      onChange: (value, isSelected) {
                        if (value == "Yes")
                          medicalExaminationModel.chronicDigestion = isSelected;
                        else if (value == "No") medicalExaminationModel.chronicDigestion = !isSelected;
                      },
                      singleSelect: true,
                      labels: [
                        CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: medicalExaminationModel.chronicDigestion as bool),
                        CIA_MultiSelectChipWidgeModel(label: "No", isSelected: !(medicalExaminationModel.chronicDigestion as bool)),
                      ]),
                ],
              ),
              CIA_TextFormField(
                changeColorIfFilled: true,
                borderColorOnChange: Colors.red,
                borderColor: illegalDrugs,
                label: "Illegal Drugs",
                controller: TextEditingController(text: medicalExaminationModel.illegalDrugs),
                onChange: (value) {
                  medicalExaminationModel.illegalDrugs = value;
                },
              ),
              CIA_TextFormField(
                  onChange: (value) => medicalExaminationModel.operatorComments = value,
                  label: "Operator Comments",
                  controller: TextEditingController(text: medicalExaminationModel.operatorComments)),
              FormTextKeyWidget(text: "Drugs Taken by patient"),
              StatefulBuilder(
                builder: (context, setState) {
                  int index = 0;
                  if (medicalExaminationModel.drugsTaken!.isEmpty) medicalExaminationModel.drugsTaken!.add("");
                  return Column(
                    children: medicalExaminationModel.drugsTaken!
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(() {
                                  index += 1;
                                  return index.toString();
                                }()),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Drug",
                                    controller: TextEditingController(text: e),
                                    onChange: (v) {
                                      e = v;
                                      medicalExaminationModel.drugsTaken![index - 1] = v;
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() => medicalExaminationModel.drugsTaken!.add(""));
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() => medicalExaminationModel.drugsTaken!.remove(e));
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Expanded(child: SizedBox())
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
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

class PatientDentalHistory extends StatefulWidget {
  PatientDentalHistory({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "DentalHistory";
  static String routePath = "Patients/:id/DentalHistory";
  int patientId;

  @override
  State<PatientDentalHistory> createState() => _PatientDentalHistoryState();
}

class _PatientDentalHistoryState extends State<PatientDentalHistory> {
  Color clench = Color_TextFieldBorder;
  String tobacco = "0";
  late Future<API_Response> load;

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value) MedicalAPI.UpdatePatientDentalHistory(widget.patientId, dentalHistoryModel);
    siteController.disableMedicalEdit.value = true;
    super.dispose();
  }

  @override
  void initState() {
    load = MedicalAPI.GetPatientDentalHistory(widget.patientId);
    super.initState();
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
              _getxClass.tobacco.value = dentalHistoryModel.smoke ?? 0;
              return CIA_MedicalPagesWidget(
                children: [
                  Row(
                    children: [
                      Expanded(child: FormTextKeyWidget(text: "Are your teeth sensitive to ?")),
                      Expanded(
                          flex: 2,
                          child: CIA_MultiSelectChipWidget(
                              onChange: (value, isSelected) {
                                if (value.toString() == "Hot or cold")
                                  dentalHistoryModel.senstiveHotCold = isSelected;
                                else if (value.toString() == "sweets")
                                  dentalHistoryModel.senstiveSweets = isSelected;
                                else if (value.toString() == "Biting or chewing") dentalHistoryModel.bittingCheweing = isSelected;
                              },
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Hot or cold", isSelected: dentalHistoryModel.senstiveHotCold ?? false),
                                CIA_MultiSelectChipWidgeModel(label: "sweets", isSelected: dentalHistoryModel.senstiveSweets ?? false),
                                CIA_MultiSelectChipWidgeModel(label: "Biting or chewing", isSelected: dentalHistoryModel.bittingCheweing ?? false),
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
                      label: "Do you clench or grind your teeth while awake or sleep?",
                      controller: TextEditingController(text: dentalHistoryModel.clench)),
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
                                _getxClass.tobacco.value = int.parse(value);
                              },
                              errorFunction: (value) {
                                return int.parse(value) >= 20;
                              },
                              label: "Cigarette per day",
                              isNumber: true,
                              controller: TextEditingController(text: dentalHistoryModel.smoke == null ? null : dentalHistoryModel.smoke.toString()))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Obx(() => FormTextValueWidget(text: () {
                                var returnValue = "";

                                if (dentalHistoryModel.smokingStatus != null && _getxClass.tobacco.value != 2000) {
                                  return (dentalHistoryModel.smokingStatus)!.name;
                                } else if ((_getxClass.tobacco.value) == 0) {
                                  returnValue = "Non Smoker";
                                  dentalHistoryModel.smokingStatus = SmokingStatus.NoneSmoker;
                                } else if ((_getxClass.tobacco.value) < 10) {
                                  returnValue = "Light Smoker";
                                  dentalHistoryModel.smokingStatus = SmokingStatus.LightSmoker;
                                } else if ((_getxClass.tobacco.value) < 20) {
                                  returnValue = "Medium Smoker";
                                  dentalHistoryModel.smokingStatus = SmokingStatus.MediumSmoker;
                                } else {
                                  returnValue = "Heavy Smoker";
                                  dentalHistoryModel.smokingStatus = SmokingStatus.HeavySmoker;
                                }
                                return returnValue;
                              }()))),
                      Expanded(flex: 3, child: SizedBox())
                    ],
                  ),
                  CIA_TextFormField(
                      onChange: (value) => dentalHistoryModel.seriousInjury = value,
                      label: "A serious injury to the mouth?",
                      controller: TextEditingController(text: dentalHistoryModel.seriousInjury)),
                  CIA_TextFormField(
                      onChange: (value) => dentalHistoryModel.satisfied = value,
                      label: "Are you satisfied with your teeth's appearance?",
                      controller: TextEditingController(text: dentalHistoryModel.satisfied)),
                  Row(
                    children: [
                      Expanded(child: FormTextKeyWidget(text: "Patient Cooperation Score")),
                      Expanded(
                          child: CIA_TextFormField(
                              isNumber: true,
                              errorFunction: (v) => int.parse(v) <= 5,
                              validator: (value) {
                                if (int.parse(value) > 10) return "10";
                                return value;
                              },
                              onChange: (value) => dentalHistoryModel.cooperationScore = int.parse(value),
                              label: "",
                              controller: TextEditingController(
                                  text: dentalHistoryModel.cooperationScore != null ? dentalHistoryModel.cooperationScore.toString() : null))),
                      Expanded(child: FormTextKeyWidget(text: "/10")),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: FormTextKeyWidget(text: "Patient willing for implant score")),
                      Expanded(
                          child: CIA_TextFormField(
                              validator: (value) {
                                if (int.parse(value) > 10) return "10";
                                return value;
                              },
                              errorFunction: (v) => int.parse(v) <= 5,
                              onChange: (value) => dentalHistoryModel.willingForImplantScore = int.parse(value),
                              label: "",
                              isNumber: true,
                              controller: TextEditingController(
                                  text: dentalHistoryModel.willingForImplantScore != null ? dentalHistoryModel.willingForImplantScore.toString() : null))),
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

class PatientDentalExamination extends StatefulWidget {
  PatientDentalExamination({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "DentalExamination";
  static String routePath = "Patient/:id/DentalExamination";
  int patientId;

  @override
  State<PatientDentalExamination> createState() => _PatientDentalExaminationState();
}

class _PatientDentalExaminationState extends State<PatientDentalExamination> {
  List<int> selectedTeeth = [];
  String selectedTooth = "";
  String selectedStatus = "";
  bool mobilityDegrees = false;
  late Future load;

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value) MedicalAPI.UpdatePatientDentalExamination(widget.patientId, dentalExaminationModel);
    siteController.disableMedicalEdit.value = true;
    super.dispose();
  }

  @override
  void initState() {
    load = MedicalAPI.GetPatientDentalExamination(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: load,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var res = snapshot.data as API_Response;
            if (res.statusCode == 200) dentalExaminationModel = res.result as DentalExaminationModel;
            return CIA_MedicalPagesWidget(children: [
              CIA_TeethChart(
                onChange: (selectedTeethList) => selectedTeeth = selectedTeethList,
              ),
              CIA_MultiSelectChipWidget(
                key: GlobalKey(),
                onChange: (value, isSelected) {
                  for (var tooth in selectedTeeth) {
                    var t = dentalExaminationModel.dentalExaminations.firstWhereOrNull((element) => element.tooth.toString() == tooth);
                    if (t == null) {
                      dentalExaminationModel.dentalExaminations.add(DentalExaminations(tooth: tooth));
                    }
                  }
                  if (isSelected) {
                    if (value == "Mobility") {
                      setState(() {
                        mobilityDegrees = true;
                      });
                    } else {
                      selectedTeeth.forEach((element) {
                        dentalExaminationModel.dentalExaminations.firstWhere((x) => x.tooth == element).updateToothStatus(value);
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
                          dentalExaminationModel.dentalExaminations.firstWhere((x) => x.tooth == element).updateToothStatus("Mobility I");
                        });
                      else if (value == "II")
                        selectedTeeth.forEach((element) {
                          dentalExaminationModel.dentalExaminations.firstWhere((x) => x.tooth == element).updateToothStatus("Mobility II");
                        });
                      else if (value == "III")
                        selectedTeeth.forEach((element) {
                          dentalExaminationModel.dentalExaminations.firstWhere((x) => x.tooth == element).updateToothStatus("Mobility III");
                        });

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
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Carious",
                initialValue:
                    dentalExaminationModel.dentalExaminations.where((element) => element.carious == true).toList().map((e) => e.tooth.toString()).toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "carious") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "carious")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).carious = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Filled",
                initialValue:
                    dentalExaminationModel.dentalExaminations.where((element) => element.filled == true).toList().map((e) => e.tooth.toString()).toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "filled") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "filled")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).filled = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Missed",
                initialValue:
                    dentalExaminationModel.dentalExaminations.where((element) => element.missed == true).toList().map((e) => e.tooth.toString()).toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "missed") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "missed")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).missed = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Not Sure",
                initialValue:
                    dentalExaminationModel.dentalExaminations.where((element) => element.notSure == true).toList().map((e) => e.tooth.toString()).toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "notSure") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "notSure")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).notSure = false;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TagsInputWidget(
                      dynamicVisibility: true,
                      key: GlobalKey(),
                      label: "Mobility I",
                      initialValue: dentalExaminationModel.dentalExaminations
                          .where((element) => element.mobilityI == true)
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList(),
                      strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "mobilityI") != null
                          ? dentalExaminationModel.dentalExaminations
                              .where((element) => element.previousState! == "mobilityI")
                              .toList()
                              .map((e) => e.tooth.toString())
                              .toList()
                          : null,
                      onDelete: (value) {
                        dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).mobilityI = false;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TagsInputWidget(
                      dynamicVisibility: true,
                      key: GlobalKey(),
                      label: "Mobility II",
                      initialValue: dentalExaminationModel.dentalExaminations
                          .where((element) => element.mobilityII == true)
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList(),
                      strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "mobilityII") != null
                          ? dentalExaminationModel.dentalExaminations
                              .where((element) => element.previousState! == "mobilityII")
                              .toList()
                              .map((e) => e.tooth.toString())
                              .toList()
                          : null,
                      onDelete: (value) {
                        dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).mobilityII = false;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    key: GlobalKey(),
                    child: CIA_TagsInputWidget(
                      dynamicVisibility: true,
                      key: GlobalKey(),
                      label: "Mobility III",
                      initialValue: dentalExaminationModel.dentalExaminations
                          .where((element) => element.mobilityIII == true)
                          .toList()
                          .map((e) => e.tooth.toString())
                          .toList(),
                      strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "mobilityIII") != null
                          ? dentalExaminationModel.dentalExaminations
                              .where((element) => element.previousState! == "mobilityIII")
                              .toList()
                              .map((e) => e.tooth.toString())
                              .toList()
                          : null,
                      onDelete: (value) {
                        dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).mobilityIII = false;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Hopeless teeth",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.hopelessteeth == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "hopelessteeth") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "hopelessteeth")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).hopelessteeth = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Implant Placed",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.implantPlaced == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "implantPlaced") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "implantPlaced")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).implantPlaced = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                label: "Implant Failed",
                initialValue: dentalExaminationModel.dentalExaminations
                    .where((element) => element.implantFailed == true)
                    .toList()
                    .map((e) => e.tooth.toString())
                    .toList(),
                strikeValues: dentalExaminationModel.dentalExaminations.where((element) => element.previousState! == "implantFailed") != null
                    ? dentalExaminationModel.dentalExaminations
                        .where((element) => element.previousState! == "implantFailed")
                        .toList()
                        .map((e) => e.tooth.toString())
                        .toList()
                    : null,
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).implantFailed = false;
                  setState(() {});
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
                        dentalExaminationModel.interarchspaceRT = int.parse(value);
                      },
                      controller: TextEditingController(
                        text: (dentalExaminationModel.interarchspaceRT ?? 0).toString(),
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
                          dentalExaminationModel.interarchspaceLT = int.parse(value);
                        },
                        controller: TextEditingController(
                          text: (dentalExaminationModel.interarchspaceLT ?? 0).toString(),
                        )),
                  ),
                ],
              ),
              FormTextKeyWidget(text: "Oral Hygiene Rating"),
              CIA_MultiSelectChipWidget(
                singleSelect: true,
                onChange: (item, isSelected) {
                  if (item == "Bad")
                    dentalExaminationModel.oralHygieneRating = EnumOralHygieneRating.BadHygiene;
                  else if (item == "Fair")
                    dentalExaminationModel.oralHygieneRating = EnumOralHygieneRating.FairHygiene;
                  else if (item == "Good")
                    dentalExaminationModel.oralHygieneRating = EnumOralHygieneRating.GoodHygiene;
                  else if (item == "Excellent") dentalExaminationModel.oralHygieneRating = EnumOralHygieneRating.ExcellentHygiene;
                },
                labels: [
                  CIA_MultiSelectChipWidgeModel(
                      label: "Bad", selectedColor: Colors.red, isSelected: dentalExaminationModel.oralHygieneRating == EnumOralHygieneRating.BadHygiene),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Fair", selectedColor: Colors.orange, isSelected: dentalExaminationModel.oralHygieneRating == EnumOralHygieneRating.FairHygiene),
                  CIA_MultiSelectChipWidgeModel(label: "Good", isSelected: dentalExaminationModel.oralHygieneRating == EnumOralHygieneRating.GoodHygiene),
                  CIA_MultiSelectChipWidgeModel(
                      label: "Excellent", isSelected: dentalExaminationModel.oralHygieneRating == EnumOralHygieneRating.ExcellentHygiene),
                ],
              ),
              CIA_TextFormField(
                  label: "Operator Implant Notes",
                  onChange: (value) {
                    dentalExaminationModel.operatorImplantNotes = value;
                  },
                  controller: TextEditingController(text: dentalExaminationModel.operatorImplantNotes ?? "")),
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

class PatientNonSurgicalTreatment extends StatefulWidget {
  PatientNonSurgicalTreatment({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "NonSurgicalTreatment";
  static String routePath = "Patient/:id/NonSurgicalTreatment";
  int patientId;

  @override
  State<PatientNonSurgicalTreatment> createState() => _PatientNonSurgicalTreatmentState();
}

class _PatientNonSurgicalTreatmentState extends State<PatientNonSurgicalTreatment> {
  String date = "";

  late Future load;

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value) {
      print("updating all with ${siteController.disableMedicalEdit.value}");
      MedicalAPI.AddPatientNonSurgicalTreatment(widget.patientId, nonSurgicalTreatment);
      MedicalAPI.UpdatePatientDentalExamination(widget.patientId, tempDentalExamination);
    }
    siteController.disableMedicalEdit.value = true;
    super.dispose();
  }

  @override
  void initState() {
    load = loadFuntionc();
  }

  loadFuntionc() async {
    var r = await MedicalAPI.GetPatientNonSurgicalTreatment(widget.patientId);
    if (r.statusCode == 200) {
      nonSurgicalTreatment = r.result as NonSurgicalTreatmentModel;
    }
    await Future.delayed(Duration(milliseconds: 600));
    r = await MedicalAPI.GetPatientDentalExamination(widget.patientId);
    if (r.statusCode == 200) {
      tempDentalExamination = r.result as DentalExaminationModel;
    }
    MedicalAPI.CheckNonSurgicalTreatementTeethStatus(nonSurgicalTreatment.treatment ?? "").then((value) {
      if (value.statusCode == 200) {
        _getxClass.containedTeeth.value = value.result as List<int>;
      }
    });
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
            return ListView(
              children: [
                Column(children: [
                  CIA_MedicalAbsrobPointerWidget(
                    child: CIA_TextFormField(
                      onChange: (value) {
                        nonSurgicalTreatment.treatment = value;
                        MedicalAPI.CheckNonSurgicalTreatementTeethStatus(value).then((value) {
                          if (value.statusCode == 200) {
                            if (_getxClass.containedTeeth.value != value.result as List<int>) _getxClass.containedTeeth.value = value.result as List<int>;
                          }
                        });
                      },
                      label: "Treatment",
                      controller: textController,
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CIA_MedicalAbsrobPointerWidget(
                          child: CIA_DropDownSearch(
                            asyncItems: LoadinAPI.LoadSupervisors,
                            onSelect: (value) {
                              nonSurgicalTreatment.supervisorID = value.id;
                            },
                            selectedItem: DropDownDTO(name: nonSurgicalTreatment.supervisor!.name! ?? "", id: nonSurgicalTreatment.supervisorID ?? 0),
                            label: "Supervisor",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CIA_SecondaryButton(
                          label: "View History",
                          onTab: () {
                            CIA_PopupDialog_Table(widget.patientId, context, "View History Treatments", (value) {});
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      CIA_SecondaryButton(
                          label: "Schedule Next Visit",
                          width: 600,
                          onTab: () async {
                            VisitsCalendarDataSource dataSource = VisitsCalendarDataSource();
                            CIA_ShowPopUp(
                              context: context,
                              width: 900,
                              height: 600,
                              title: "Schedule Next Visit",
                              child: CIA_Calendar(
                                dataSource: dataSource,
                                getForDoctor: true,
                                patientID: widget.patientId,
                                onNewVisit: (newVisit) {
                                  nonSurgicalTreatment.nextVisit = newVisit.reservationTime;
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 20),
                  CIA_MedicalAbsrobPointerWidget(child: Obx(() => _buildTeethSuggestion())),
                  SizedBox(height: 20),
                ]),
              ],
            );
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
    _getxClass.containedTeeth.value.forEach((tooth) {
      var currentToothDentalExamination = tempDentalExamination.dentalExaminations.firstWhereOrNull((element) => element.tooth == tooth);
      if (currentToothDentalExamination == null) {
        currentToothDentalExamination = DentalExaminations(tooth: tooth);
        tempDentalExamination.dentalExaminations.add(currentToothDentalExamination);
      }
      List<CIA_MultiSelectChipWidgeModel> tempSelectionModel = [
        CIA_MultiSelectChipWidgeModel(
            label: "Carious", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.carious) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Filled", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.filled) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Missed", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.missed) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Not Sure", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.notSure) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility I", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.mobilityI) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility II", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.mobilityII) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Mobility III", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.mobilityIII) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Hopeless teeth", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.hopelessteeth) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Placed", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.implantPlaced) as bool : false),
        CIA_MultiSelectChipWidgeModel(
            label: "Implant Failed", isSelected: currentToothDentalExamination != null ? (currentToothDentalExamination.implantFailed) as bool : false),
      ];

      uu.add(FormTextKeyWidget(text: "Do you want to update tooth $tooth?"));
      uu.add(CIA_MultiSelectChipWidget(
        key: LabeledGlobalKey(tooth.toString()),
        singleSelect: true,
        labels: tempSelectionModel,
        onChange: (value, isSelected) async {
          if (currentToothDentalExamination!.carious!) {
            currentToothDentalExamination!.previousState = "carious";
            currentToothDentalExamination.carious = false;
          }
          if (currentToothDentalExamination!.missed!) {
            currentToothDentalExamination!.previousState = "missed";
            currentToothDentalExamination.missed = false;
          }
          if (currentToothDentalExamination!.filled!) {
            currentToothDentalExamination!.previousState = "filled";
            currentToothDentalExamination.filled = false;
          }
          if (currentToothDentalExamination!.notSure!) {
            currentToothDentalExamination!.previousState = "notSure";
            currentToothDentalExamination.notSure = false;
          }
          if (currentToothDentalExamination!.mobilityIII!) {
            currentToothDentalExamination!.previousState = "mobilityIII";
            currentToothDentalExamination.mobilityIII = false;
          }
          if (currentToothDentalExamination!.mobilityII!) {
            currentToothDentalExamination!.previousState = "mobilityII";
            currentToothDentalExamination.mobilityII = false;
          }
          if (currentToothDentalExamination!.mobilityI!) {
            currentToothDentalExamination!.previousState = "mobilityI";
            currentToothDentalExamination.mobilityI = false;
          }
          if (currentToothDentalExamination!.hopelessteeth!) {
            currentToothDentalExamination!.previousState = "hopelessteeth";
            currentToothDentalExamination.hopelessteeth = false;
          }
          if (currentToothDentalExamination!.implantFailed!) {
            currentToothDentalExamination!.previousState = "implantFailed";
            currentToothDentalExamination.implantFailed = false;
          }
          if (currentToothDentalExamination!.implantPlaced!) {
            currentToothDentalExamination!.previousState = "implantPlaced";
            currentToothDentalExamination.implantPlaced = false;
          }
          if (isSelected) {
            currentToothDentalExamination.updateToothStatus(value);
            if (value == "Missed") {
              var res = await MedicalAPI.GetPaidPlanItem(widget.patientId, currentToothDentalExamination.tooth!, value);
              if (res.statusCode == 200) {
                var model = res.result as Map<String, TreatmentPlanFieldsModel?>;
                if (model['extraction'] != null) {
                  await CIA_ShowPopUpYesNo(
                    context: context,
                    onSave: () async {
                      var res = await MedicalAPI.AddPatientReceipt(widget.patientId, currentToothDentalExamination!.tooth!, "extraction");
                      if (res.statusCode == 200)
                        ShowSnackBar(context, isSuccess: true, message: "Receipt updated!");
                      else
                        ShowSnackBar(context, isSuccess: false);
                    },
                    title: "Extraction done at price ${model['extraction']!.planPrice!.toString()}?",
                  );
                }
              }
            } else if (value == "Filled") {
              var res = await MedicalAPI.GetPaidPlanItem(widget.patientId, currentToothDentalExamination.tooth!, value);
              if (res.statusCode == 200) {
                var model = res.result as Map<String, TreatmentPlanFieldsModel?>;
                bool crown = false;
                bool rootCanalTreatment = false;
                bool restoration = false;

                await CIA_ShowPopUp(
                  context: context,
                  onSave: () async {
                    API_Response res = API_Response();
                    if (crown) res = await MedicalAPI.AddPatientReceipt(widget.patientId, currentToothDentalExamination!.tooth!, "crown");
                    if (rootCanalTreatment)
                      res = await MedicalAPI.AddPatientReceipt(widget.patientId, currentToothDentalExamination!.tooth!, "rootCanaltreatment");
                    if (restoration) res = await MedicalAPI.AddPatientReceipt(widget.patientId, currentToothDentalExamination!.tooth!, "restoration");

                    if (res.statusCode == 200)
                      ShowSnackBar(context, isSuccess: true, message: "Receipt updated!");
                    else
                      ShowSnackBar(context, isSuccess: false);
                  },
                  child: Column(
                    children: [
                      model['crown'] != null
                          ? Row(
                              children: [
                                FormTextKeyWidget(text: "Crown at price ${model['crown']!.planPrice!.toString()}"),
                                SizedBox(width: 10),
                                CIA_MultiSelectChipWidget(
                                  onChange: (item, isSelected) => crown = item == "Yes" && isSelected,
                                  singleSelect: true,
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(label: "Yes"),
                                    CIA_MultiSelectChipWidgeModel(label: "No", isSelected: true),
                                  ],
                                )
                              ],
                            )
                          : SizedBox(),
                      model['restoration'] != null
                          ? Row(
                              children: [
                                FormTextKeyWidget(text: "Restoration at price ${model['restoration']!.planPrice!.toString()}"),
                                SizedBox(width: 10),
                                CIA_MultiSelectChipWidget(
                                  singleSelect: true,
                                  onChange: (item, isSelected) => restoration = item == "Yes" && isSelected,
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(label: "Yes"),
                                    CIA_MultiSelectChipWidgeModel(label: "No", isSelected: true),
                                  ],
                                )
                              ],
                            )
                          : SizedBox(),
                      model['rootCanalTreatment'] != null
                          ? Row(
                              children: [
                                FormTextKeyWidget(text: "Root Canal Treatment at price ${model['rootCanalTreatment']!.planPrice!.toString()}"),
                                SizedBox(width: 10),
                                CIA_MultiSelectChipWidget(
                                  singleSelect: true,
                                  onChange: (item, isSelected) => rootCanalTreatment = item == "Yes" && isSelected,
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(label: "Yes"),
                                    CIA_MultiSelectChipWidgeModel(label: "No", isSelected: true),
                                  ],
                                )
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                );
              }
            }
          }
        },
      ));
      uu.add(SizedBox(height: 10));
    });

    Widget ss = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: uu,
    );
    return ss;
  }
}

class PatientTreatmentPlan extends StatefulWidget {
  PatientTreatmentPlan({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "TreatmentPlan";
  static String routePath = "Patient/:id/TreatmentPlan";
  int patientId;

  @override
  State<PatientTreatmentPlan> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<PatientTreatmentPlan> {
  @override
  Widget build(BuildContext context) {
    return CIA_TeethTreatmentPlanWidget(
      patientId: widget.patientId,
    );
  }

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value) MedicalAPI.UpdatePatientTreatmentPlan(widget.patientId, treatmentPlanModel!.treatmentPlan!);
    siteController.disableMedicalEdit.value = true;
    super.dispose();
  }
}

class PatientSurgicalTreatment extends StatefulWidget {
  PatientSurgicalTreatment({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "SurgicalTreatment";
  static String routePath = "Patient/:id/SurgicalTreatment";
  int patientId;

  @override
  State<PatientSurgicalTreatment> createState() => _PatientSurgicalTreatmentState();
}

class _PatientSurgicalTreatmentState extends State<PatientSurgicalTreatment> {
  @override
  Widget build(BuildContext context) {
    return CIA_TeethTreatmentPlanWidget(
      patientId: widget.patientId,
      surgical: true,
    );
  }

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value) MedicalAPI.UpdatePatientSurgicalTreatment(widget.patientId, surgicalTreatmentModel);
    siteController.disableMedicalEdit.value = true;
    super.dispose();
  }
}

class PatientProstheticTreatment extends StatefulWidget {
  PatientProstheticTreatment({Key? key, required this.patientId}) : super(key: key);
  int patientId;
  static String routeName = "ProstheticTreatment";
  static String routePath = "Patient/:id/ProstheticTreatment";

  @override
  State<PatientProstheticTreatment> createState() => _PatientProstheticTreatmentState();
}

class _PatientProstheticTreatmentState extends State<PatientProstheticTreatment> {
  ProstheticTreatmentModel? diagnosticModel;
  ProstheticTreatmentModel? singleBridgeModel;
  ProstheticTreatmentModel? fullArchModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "Diagnostic",
                ),
                Tab(
                  text: "Final Prothesis",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                CIA_FutureBuilder(
                  loadFunction: MedicalAPI.GetPatientProstheticTreatmentDiagnostic(widget.patientId),
                  onSuccess: (data) {
                    diagnosticModel = data as ProstheticTreatmentModel;
                    return StatefulBuilder(
                      builder: (context, _setState) {
                        return CIA_MedicalPagesWidget(children: () {
                          List<Widget> r = [];
                          if (diagnosticModel!.prostheticDiagnostic_DiagnosticImpression!.isEmpty) {
                            diagnosticModel!.prostheticDiagnostic_DiagnosticImpression!.add(DiagnosticImpressionModel());
                          }
                          if (diagnosticModel!.prostheticDiagnostic_Bite!.isEmpty) {
                            diagnosticModel!.prostheticDiagnostic_Bite!.add(BiteModel());
                          }
                          if (diagnosticModel!.prostheticDiagnostic_ScanAppliance!.isEmpty) {
                            diagnosticModel!.prostheticDiagnostic_ScanAppliance!.add(ScanApplianceModel());
                          }

                          r.add(Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: FormTextKeyWidget(text: "Diagnostic Impression"),
                          ));
                          r.addAll(diagnosticModel!.prostheticDiagnostic_DiagnosticImpression!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            label: "Diagnostic",
                                            selectedItem: () {
                                              if (e.diagnostic != null) {
                                                return DropDownDTO(name: e.diagnostic!.name.replaceAll("_", " "));
                                              }
                                              return null;
                                            }(),
                                            onSelect: (value) {
                                              e.diagnostic = EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[value.id!];
                                            },
                                            items: [
                                              DropDownDTO(name: "Physical", id: 0),
                                              DropDownDTO(name: "Digital", id: 1),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            label: "Next Step",
                                            selectedItem: () {
                                              if (e.nextStep != null) {
                                                return DropDownDTO(name: e.nextStep!.name.replaceAll("_", " "));
                                              }
                                              return null;
                                            }(),
                                            onSelect: (value) {
                                              e.nextStep = EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];
                                            },
                                            items: [
                                              DropDownDTO(name: "Ready for implant", id: 0),
                                              DropDownDTO(name: "Bite", id: 1),
                                              DropDownDTO(name: "Needs new impression", id: 2),
                                              DropDownDTO(name: "Needs scan PPT", id: 3),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        CIA_CheckBoxWidget(
                                          text: "Needs Remake",
                                          onChange: (v) => e.needsRemake = v,
                                          value: e.needsRemake ?? false,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                align: TextAlign.center,
                                                text: e.operator!.name ?? "",
                                                secondaryInfo: true,
                                              )),
                                              SizedBox(width: 10),
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                align: TextAlign.center,
                                                text: e.date ?? "",
                                                secondaryInfo: true,
                                              )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              _setState(() {
                                                diagnosticModel!.prostheticDiagnostic_DiagnosticImpression!.add(DiagnosticImpressionModel());
                                              });
                                            },
                                            icon: Icon(Icons.add))
                                      ],
                                    ),
                                  ))
                              .toList());

                          r.add(Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: FormTextKeyWidget(text: "Bite"),
                          ));
                          r.addAll(diagnosticModel!.prostheticDiagnostic_Bite!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            label: "Diagnostic",
                                            selectedItem: () {
                                              if (e.diagnostic != null) {
                                                return DropDownDTO(name: e.diagnostic!.name.replaceAll("_", " "));
                                              }
                                              return null;
                                            }(),
                                            onSelect: (value) {
                                              e.diagnostic = EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                                            },
                                            items: [
                                              DropDownDTO(name: "Done", id: 0),
                                              DropDownDTO(name: "Needs ReScan", id: 1),
                                              DropDownDTO(name: "Needs ReImpression", id: 2),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            label: "Next Step",
                                            selectedItem: () {
                                              if (e.nextStep != null) {
                                                return DropDownDTO(name: e.nextStep!.name.replaceAll("_", " "));
                                              }
                                              return null;
                                            }(),
                                            onSelect: (value) {
                                              e.nextStep = EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                                            },
                                            items: [
                                              DropDownDTO(name: "Scan Appliance", id: 0),
                                              DropDownDTO(name: "ReImpression", id: 1),
                                              DropDownDTO(name: "ReBite", id: 2),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        CIA_CheckBoxWidget(
                                          text: "Needs Remake",
                                          onChange: (v) => e.needsRemake = v,
                                          value: e.needsRemake ?? false,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                align: TextAlign.center,
                                                text: e.operator!.name ?? "",
                                                secondaryInfo: true,
                                              )),
                                              SizedBox(width: 10),
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                align: TextAlign.center,
                                                text: e.date ?? "",
                                                secondaryInfo: true,
                                              )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              _setState(() {
                                                diagnosticModel!.prostheticDiagnostic_Bite!.add(BiteModel());
                                              });
                                            },
                                            icon: Icon(Icons.add))
                                      ],
                                    ),
                                  ))
                              .toList());

                          r.add(Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: FormTextKeyWidget(text: "Scan Appliance"),
                          ));
                          r.addAll(diagnosticModel!.prostheticDiagnostic_ScanAppliance!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CIA_DropDownSearch(
                                            label: "Diagnostic",
                                            selectedItem: () {
                                              if (e.diagnostic != null) {
                                                return DropDownDTO(name: e.diagnostic!.name.replaceAll("_", " "));
                                              }
                                              return null;
                                            }(),
                                            onSelect: (value) {
                                              e.diagnostic = EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];
                                            },
                                            items: [
                                              DropDownDTO(name: "Done", id: 0),
                                              DropDownDTO(name: "Needs ReBite", id: 1),
                                              DropDownDTO(name: "Needs ReImpression", id: 2),
                                              DropDownDTO(name: "Needs ReDesign", id: 3),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(child: SizedBox()),
                                        SizedBox(width: 10),
                                        CIA_CheckBoxWidget(
                                          text: "Needs Remake",
                                          onChange: (v) => e.needsRemake = v,
                                          value: e.needsRemake ?? false,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                align: TextAlign.center,
                                                text: e.operator!.name ?? "",
                                                secondaryInfo: true,
                                              )),
                                              SizedBox(width: 10),
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                align: TextAlign.center,
                                                text: e.date ?? "",
                                                secondaryInfo: true,
                                              )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {
                                              _setState(() {
                                                diagnosticModel!.prostheticDiagnostic_ScanAppliance!.add(ScanApplianceModel());
                                              });
                                            },
                                            icon: Icon(Icons.add))
                                      ],
                                    ),
                                  ))
                              .toList());

                          r = r.map((e) => CIA_MedicalAbsrobPointerWidget(child: e)).toList();
                          return r;
                          /*
                        * FormTextKeyWidget(text: "Diagnostic Impression"),
                        Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Diagnostic",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticDiagnosticImpressionDiagnostic != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticDiagnosticImpressionDiagnostic!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticDiagnosticImpressionDiagnostic =
                                      EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Physical", id: 0),
                                  DropDownDTO(name: "Digital", id: 1),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Next Step",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticDiagnosticImpressionNextStep != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticDiagnosticImpressionNextStep!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticDiagnosticImpressionNextStep =
                                      EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Ready for implant", id: 0),
                                  DropDownDTO(name: "Bite", id: 1),
                                  DropDownDTO(name: "Needs new impression", id: 2),
                                  DropDownDTO(name: "Needs scan PPT", id: 3),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              onChange: (v) => model.prostheticDiagnosticDiagnosticImpressionNeedsRemake = v,
                              value: model.prostheticDiagnosticDiagnosticImpressionNeedsRemake ?? false,
                            ),
                          ],
                        ),
                        FormTextKeyWidget(text: "Bite"),
                        Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Diagnostic",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticBiteDiagnostic != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticBiteDiagnostic!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticBiteDiagnostic = EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Done", id: 0),
                                  DropDownDTO(name: "Needs ReScan", id: 1),
                                  DropDownDTO(name: "Needs ReImpression", id: 2),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Next Step",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticBiteNextStep != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticBiteNextStep!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticBiteNextStep = EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Scan Appliance", id: 0),
                                  DropDownDTO(name: "ReImpression", id: 1),
                                  DropDownDTO(name: "ReBite", id: 2),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              onChange: (v) => model.prostheticDiagnosticBiteNeedsRemake = v,
                              value: model.prostheticDiagnosticBiteNeedsRemake ?? false,
                            ),
                          ],
                        ),
                        FormTextKeyWidget(text: "Scan Appliance"),
                        Row(
                          children: [
                            Expanded(
                              child: CIA_DropDownSearch(
                                label: "Diagnostic",
                                selectedItem: () {
                                  if (model.prostheticDiagnosticScanApplianceDiagnostic != null) {
                                    return DropDownDTO(name: model.prostheticDiagnosticScanApplianceDiagnostic!.name.replaceAll("_", " "));
                                  }
                                  return null;
                                }(),
                                onSelect: (value) {
                                  model.prostheticDiagnosticScanApplianceDiagnostic = EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];
                                },
                                items: [
                                  DropDownDTO(name: "Done", id: 0),
                                  DropDownDTO(name: "Needs ReBite", id: 1),
                                  DropDownDTO(name: "Needs ReImpression", id: 2),
                                  DropDownDTO(name: "Needs ReDesign", id: 3),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: SizedBox()),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              onChange: (v) => model.prostheticDiagnosticScanApplianceNeedsRemake = v,
                              value: model.prostheticDiagnosticScanApplianceNeedsRemake ?? false,
                            ),
                          ],
                        ),
                        CIA_PrimaryButton(label: "Save", onTab: ()async{
                          await MedicalAPI.UpdatePatientProstheticTreatmentDiagnostic(widget.patientId, model);
                        })

                      ,*/
                        }());
                      },
                    );
                  },
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 500,
                        child: TabBar(
                          labelColor: Colors.black,
                          indicatorColor: Colors.orange,
                          tabs: [
                            Tab(
                              text: "Single & Bridge",
                            ),
                            Tab(
                              text: "Full Arch",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            CIA_MedicalAbsrobPointerWidget(
                              child: CIA_FutureBuilder(
                                  loadFunction: MedicalAPI.GetPatientProstheticTreatmentFinalProthesisSingleBridge(widget.patientId),
                                  onSuccess: (data) {
                                    singleBridgeModel = data as ProstheticTreatmentModel;
                                    return CIA_MedicalPagesWidget(
                                      children: [
                                        CIA_TeethChart(
                                          onChange: (selectedTeethList) {
                                            singleBridgeModel!.finalProthesisSingleBridgeTeeth = selectedTeethList;
                                          },
                                          selectedTeeth: singleBridgeModel!.finalProthesisSingleBridgeTeeth ?? [],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_CheckBoxWidget(
                                                text: "Healing Collar",
                                                onChange: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeHealingCollar = value;
                                                },
                                                value: singleBridgeModel!.finalProthesisSingleBridgeHealingCollar ?? false,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Customization",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeHealingCollarStatus != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeHealingCollarStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeHealingCollarStatus =
                                                      EnumFinalProthesisSingleBridgeHealingCollarStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "With Customization", id: 0),
                                                  DropDownDTO(name: "Without Customization", id: 1),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(child: SizedBox()),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_CheckBoxWidget(
                                                text: "Impression",
                                                onChange: (v) => singleBridgeModel!.finalProthesisSingleBridgeImpression = v,
                                                value: singleBridgeModel!.finalProthesisSingleBridgeImpression ?? false,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Procedure",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeImpressionStatus != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeImpressionStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeImpressionStatus =
                                                      EnumFinalProthesisSingleBridgeImpressionStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Scan by scan body", id: 0),
                                                  DropDownDTO(name: "Scan by abutment", id: 1),
                                                  DropDownDTO(name: "Physical Impression open tray", id: 2),
                                                  DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Next Visit",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeImpressionNextVisit != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeImpressionNextVisit!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeImpressionNextVisit =
                                                      EnumFinalProthesisSingleBridgeImpressionNextVisit.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Custom Abutment", id: 0),
                                                  DropDownDTO(name: "Try In", id: 1),
                                                  DropDownDTO(name: "Delivery", id: 2),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CIA_CheckBoxWidget(
                                              text: "Try in",
                                              onChange: (v) => singleBridgeModel!.finalProthesisSingleBridgeTryIn = v,
                                              value: singleBridgeModel!.finalProthesisSingleBridgeTryIn ?? false,
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Procedure",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeTryInStatus != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeTryInStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeTryInStatus =
                                                      EnumFinalProthesisSingleBridgeTryInStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                                                  DropDownDTO(name: "Try in PMMA", id: 1),
                                                  DropDownDTO(name: "Try in on scan abutment PMMY", id: 2),
                                                  DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Next Visit",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeTryInNextVisit != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeTryInNextVisit!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeTryInNextVisit =
                                                      EnumFinalProthesisSingleBridgeTryInNextVisit.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Delivery", id: 0),
                                                  DropDownDTO(name: "Try in PMMA", id: 1),
                                                  DropDownDTO(name: "ReImpression", id: 2),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CIA_CheckBoxWidget(
                                              text: "Delivery",
                                              onChange: (v) => singleBridgeModel!.finalProthesisSingleBridgeDelivery = v,
                                              value: singleBridgeModel!.finalProthesisSingleBridgeDelivery ?? false,
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Status",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeDeliveryStatus != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeDeliveryStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeDeliveryStatus =
                                                      EnumFinalProthesisSingleBridgeDeliveryStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Done", id: 0),
                                                  DropDownDTO(name: "ReDesign", id: 1),
                                                  DropDownDTO(name: "ReImpression", id: 2),
                                                  DropDownDTO(name: "ReTryIn", id: 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Next Visit",
                                                selectedItem: () {
                                                  if (singleBridgeModel!.finalProthesisSingleBridgeDeliveryNextVisit != null) {
                                                    return DropDownDTO(
                                                        name: singleBridgeModel!.finalProthesisSingleBridgeDeliveryNextVisit!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  singleBridgeModel!.finalProthesisSingleBridgeDeliveryNextVisit =
                                                      EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Done", id: 0),
                                                  DropDownDTO(name: "ReDesign", id: 1),
                                                  DropDownDTO(name: "ReImpression", id: 2),
                                                  DropDownDTO(name: "ReTryIn", id: 3),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            CIA_MedicalAbsrobPointerWidget(
                              child: CIA_FutureBuilder(
                                  loadFunction: MedicalAPI.GetPatientProstheticTreatmentFinalProthesisFullArch(widget.patientId),
                                  onSuccess: (data) {
                                    fullArchModel = data as ProstheticTreatmentModel;
                                    return CIA_MedicalPagesWidget(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CIA_CheckBoxWidget(
                                              text: "Healing Collar",
                                              onChange: (value) {
                                                fullArchModel!.finalProthesisFullArchHealingCollar = value;
                                              },
                                              value: fullArchModel!.finalProthesisFullArchHealingCollar ?? false,
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Customization",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchHealingCollarStatus != null) {
                                                    return DropDownDTO(
                                                        name: fullArchModel!.finalProthesisFullArchHealingCollarStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchHealingCollarStatus =
                                                      EnumFinalProthesisSingleBridgeHealingCollarStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "With Customization", id: 0),
                                                  DropDownDTO(name: "Without Customization", id: 1),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(child: SizedBox()),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_CheckBoxWidget(
                                                text: "Impression",
                                                onChange: (v) => fullArchModel!.finalProthesisFullArchImpression = v,
                                                value: fullArchModel!.finalProthesisFullArchImpression ?? false,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Procedure",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchImpressionStatus != null) {
                                                    return DropDownDTO(name: fullArchModel!.finalProthesisFullArchImpressionStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchImpressionStatus =
                                                      EnumFinalProthesisSingleBridgeImpressionStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Scan by scan body", id: 0),
                                                  DropDownDTO(name: "Scan by abutment", id: 1),
                                                  DropDownDTO(name: "Physical Impression open tray", id: 2),
                                                  DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Next Visit",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchImpressionNextVisit != null) {
                                                    return DropDownDTO(
                                                        name: fullArchModel!.finalProthesisFullArchImpressionNextVisit!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchImpressionNextVisit =
                                                      EnumFinalProthesisSingleBridgeImpressionNextVisit.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Custom Abutment", id: 0),
                                                  DropDownDTO(name: "Try In", id: 1),
                                                  DropDownDTO(name: "Delivery", id: 2),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CIA_CheckBoxWidget(
                                              text: "Try in",
                                              onChange: (v) => fullArchModel!.finalProthesisFullArchTryIn = v,
                                              value: fullArchModel!.finalProthesisFullArchTryIn ?? false,
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Procedure",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchTryInStatus != null) {
                                                    return DropDownDTO(name: fullArchModel!.finalProthesisFullArchTryInStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchTryInStatus =
                                                      EnumFinalProthesisSingleBridgeTryInStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                                                  DropDownDTO(name: "Try in PMMA", id: 1),
                                                  DropDownDTO(name: "Try in on scan abutment PMMY", id: 2),
                                                  DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Next Visit",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchTryInNextVisit != null) {
                                                    return DropDownDTO(name: fullArchModel!.finalProthesisFullArchTryInNextVisit!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchTryInNextVisit =
                                                      EnumFinalProthesisSingleBridgeTryInNextVisit.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Delivery", id: 0),
                                                  DropDownDTO(name: "Try In PMMA", id: 1),
                                                  DropDownDTO(name: "ReImpression", id: 2),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CIA_CheckBoxWidget(
                                              text: "Delivery",
                                              onChange: (v) => fullArchModel!.finalProthesisFullArchDelivery = v,
                                              value: fullArchModel!.finalProthesisFullArchDelivery ?? false,
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Status",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchDeliveryStatus != null) {
                                                    return DropDownDTO(name: fullArchModel!.finalProthesisFullArchDeliveryStatus!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchDeliveryStatus =
                                                      EnumFinalProthesisSingleBridgeDeliveryStatus.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Done", id: 0),
                                                  DropDownDTO(name: "ReDesign", id: 1),
                                                  DropDownDTO(name: "ReImpression", id: 2),
                                                  DropDownDTO(name: "ReTryIn", id: 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearch(
                                                label: "Next Visit",
                                                selectedItem: () {
                                                  if (fullArchModel!.finalProthesisFullArchDeliveryNextVisit != null) {
                                                    return DropDownDTO(name: fullArchModel!.finalProthesisFullArchDeliveryNextVisit!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  fullArchModel!.finalProthesisFullArchDeliveryNextVisit =
                                                      EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Done", id: 0),
                                                  DropDownDTO(name: "ReDesign", id: 1),
                                                  DropDownDTO(name: "ReImpression", id: 2),
                                                  DropDownDTO(name: "ReTryIn", id: 3),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: SizedBox())
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (!siteController.disableMedicalEdit.value)
      Future.delayed(Duration.zero, () async {
        try {
          if (fullArchModel != null) await MedicalAPI.UpdatePatientProstheticTreatmentFinalProthesisFullArch(widget.patientId, fullArchModel!);
        } on Exception catch (e) {
          // TODO
        }
        try {
          if (diagnosticModel != null) await MedicalAPI.UpdatePatientProstheticTreatmentDiagnostic(widget.patientId, diagnosticModel!);
        } on Exception catch (e) {
          // TODO
        }
        try {
          if (singleBridgeModel != null) await MedicalAPI.UpdatePatientProstheticTreatmentFinalProthesisSingleBridge(widget.patientId, singleBridgeModel!);
        } on Exception catch (e) {
          // TODO
        }
      });

    siteController.disableMedicalEdit.value = true;
    super.dispose();
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
                  CIA_MultiSelectChipWidgeModel(label: "Not Done", value: "notDone"),
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
                  values: ["Patient's Desire", "Waiting for scan applicance", "Work required before CBCT", "Other"],
                ),
              ),
            ),
            SizedBox(width: 10),
            done != null && !done! && reason == "Other"
                ? Expanded(
                    child: CIA_TextFormField(label: "Other", controller: TextEditingController()),
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
                  child: CIA_TextFormField(label: "Date", controller: TextEditingController()),
                )),
          ],
        ),
        Wrap(
          children: [
            Container(width: 150, child: CIA_SecondaryButton(label: "Request new CBCT", onTab: () {})),
          ],
        )
      ],
    );
  }
}
