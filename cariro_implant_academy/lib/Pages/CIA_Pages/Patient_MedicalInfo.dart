import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/DentalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/MedicalExaminationModel.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/TreatmentPlanModel.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Calendar.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_StepTimelineWidget.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../Models/MedicalModels/SurgicalTreatmentModel.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_IncrementalHBA1CTextField.dart';
import '../../Widgets/CIA_IncrementalTextField.dart';
import '../../Widgets/CIA_MedicalPageWidget.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/CIA_TagsInputWidget.dart';
import '../../Widgets/CIA_TeethChart.dart';
import '../../Widgets/CIA_TeethSurgicalTreatmentWidget.dart';
import '../../Widgets/CIA_TeethTreatmentWidget.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/MedicalSlidingBar.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import 'package:collection/collection.dart';

import '../../Widgets/SnackBar.dart';
import '../SharedPages/LapRequestSharedPage.dart';

late PatientMedicalController MasterController;
late int patientID;
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
  PatientMedicalInfoPage({Key? key, required this.patientMedicalController, required this.patientID}) : super(key: key);
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

  List<Widget> pages = [
    _PatientMedicalHistory(),
    _PatientDentalHistory(),
    PatientDentalExamination(),
    PatientNonSurgicalTreatment(),
    _PatientTreatmentPlan(),
    _PatientSurgicalTreatment(),
    // _PatientProstheticTreatment(),
    //_Patient_CBCTandPhotos(),
  ];
  int index = 0;

  Uint8List? personalImageBytes;
  @override
  Widget build(BuildContext context) {
    siteController.setMedicalAppBar(
      bar: MedicalSlidingBar(
          pages: [
        MedicalSlidingModel(
            name: "Medical Examination",
            ),
        MedicalSlidingModel(
            name: "Dental History",
          ),
        MedicalSlidingModel(
            name: "Dental Examination",
           ),
        MedicalSlidingModel(
            name: "Non Surgical Treatment",
          onSave: ()async{
            await MedicalAPI.AddPatientNonSurgicalTreatment(patientID, nonSurgicalTreatment);
            await MedicalAPI.UpdatePatientDentalExamination(patientID, tempDentalExamination);

          }
            ),
        MedicalSlidingModel(
            name: "Treatment Plan",
          onSave: ()async{
            await MedicalAPI.UpdatePatientTreatmentPlan(patientID, treatmentPlanModel!.treatmentPlan!);
          }
           ),
        MedicalSlidingModel(
            name: "Surgical Treatment",
          onSave: ()async{
            await MedicalAPI.UpdatePatientSurgicalTreatment(patientID, surgicalTreatmentModel);
          }
           ),
        MedicalSlidingModel(
            name: "Prosthetic Treatment",
            onSave: () {
              print("3");
            }),
        MedicalSlidingModel(
            name: "Photos and CBCTs",
            onSave: () {
              print("4");
            }),
      ]),
    );

    patient?.gender = "Male";
    return CIA_FutureBuilder(
        loadFunction: ()async{
          var res = await PatientAPI.GetPatientData(patientID);
          if(res.statusCode==200)
            {
              var temp = res.result as PatientInfoModel;
              if (temp.profileImageId != null) await PatientAPI.DownloadImage(temp.profileImageId!).then((value) {
                if (value.statusCode == 200)
                  personalImageBytes = base64Decode(value.result as String);
              },);
            }
          return res;
        }(),
        onSuccess: (data) {
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
                                  internalPagesController.jumpToPage(2);
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            CIA_SecondaryButton(
                                label: "LAB Request",
                                icon: Icon(Icons.document_scanner_outlined),
                                onTab: () {
                                  CIA_ShowPopUp(
                                    hideButton: true,
                                    context: context,
                                    width: 1100,
                                    height: 650,
                                    onSave: () {},
                                    child: LapRequestSharedPage(isDoctor: true, patient: patient),
                                  );
                                }),
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

class _PatientMedicalHistory extends StatefulWidget {
  const _PatientMedicalHistory({Key? key}) : super(key: key);

  @override
  State<_PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<_PatientMedicalHistory> {
  bool diseases = false;
  Color illegalDrugs = Color_TextFieldBorder;
  late Future load;

  @override
  void initState() {
    load = MedicalAPI.GetPatientMedicalExamination(patientID);
  }


  @override
  void dispose() async{
    await MedicalAPI.UpdatePatientMedicalExamination(patientID, medicalExaminationModel);
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
                            var regExp = RegExp("/");
                            Iterable<Match> match = regExp.allMatches(
                              value,
                            );
                            if (match.length > 1) value = value.replaceRange(value.lastIndexOf("/"), value.lastIndexOf("/") + 1, "");

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
                            var regExp = RegExp("/");
                            Iterable<Match> match = regExp.allMatches(
                              value,
                            );
                            if (match.length > 1) value = value.replaceRange(value.lastIndexOf("/"), value.lastIndexOf("/") + 1, "");

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
                            medicalExaminationModel.diabetic?.lastReading = value;
                          },
                          label: "Last Reading ",
                          controller: TextEditingController(text: medicalExaminationModel.diabetic?.lastReading)),
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
                            medicalExaminationModel.diabetic?.randomInClinic = value;
                          },
                          label: "Random in clinic ",
                          controller: TextEditingController(text: medicalExaminationModel.diabetic?.randomInClinic)),
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
                  if(medicalExaminationModel.drugsTaken!.isEmpty) medicalExaminationModel.drugsTaken!.add("");
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
                                SizedBox(width:10),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Drug",
                                    controller: TextEditingController(text: e),
                                    onChange: (v) {
                                      e = v;
                                      medicalExaminationModel.drugsTaken![index-1] = v;
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
  void dispose() async{
    await MedicalAPI.UpdatePatientDentalHistory(patientID, dentalHistoryModel);
  }

  @override
  void initState() {
    load = MedicalAPI.GetPatientDentalHistory(patientID);
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
                                if ((_getxClass.tobacco.value) == 0) {
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
  const PatientDentalExamination({Key? key}) : super(key: key);

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
  void dispose() async{
    await MedicalAPI.UpdatePatientDentalExamination(patientID, dentalExaminationModel);

  }

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
                patientController: MasterController,
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
                onChange: (value) {
                  MasterController.updateDentalExamination("Carious", value);
                },
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).carious = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                patientController: MasterController,
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
                onChange: (value) => MasterController.updateDentalExamination("Filled", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).filled = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                patientController: MasterController,
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
                onChange: (value) => MasterController.updateDentalExamination("Missed", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).missed = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                patientController: MasterController,
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
                onChange: (value) => MasterController.updateDentalExamination("Not Sure", value),
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
                      patientController: MasterController,
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
                      onChange: (value) => MasterController.updateDentalExamination("Mobility I", value),
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
                      patientController: MasterController,
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
                      onChange: (value) => MasterController.updateDentalExamination("Mobility II", value),
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
                      patientController: MasterController,
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
                      onChange: (value) => MasterController.updateDentalExamination("Mobility III", value),
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
                patientController: MasterController,
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
                onChange: (value) => MasterController.updateDentalExamination("Hopeless teeth", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).hopelessteeth = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                patientController: MasterController,
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
                onChange: (value) => MasterController.updateDentalExamination("Implant Placed", value),
                onDelete: (value) {
                  dentalExaminationModel.dentalExaminations.firstWhere((element) => element.tooth.toString() == value).implantPlaced = false;
                  setState(() {});
                },
              ),
              CIA_TagsInputWidget(
                dynamicVisibility: true,
                key: GlobalKey(),
                patientController: MasterController,
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
                onChange: (value) => MasterController.updateDentalExamination("Implant Failed", value),
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
  const PatientNonSurgicalTreatment({Key? key}) : super(key: key);

  @override
  State<PatientNonSurgicalTreatment> createState() => _PatientNonSurgicalTreatmentState();
}

class _PatientNonSurgicalTreatmentState extends State<PatientNonSurgicalTreatment> {
  String date = "";

  late Future load;

  @override
  void dispose() async{
    await MedicalAPI.AddPatientNonSurgicalTreatment(patientID, nonSurgicalTreatment);
    await MedicalAPI.UpdatePatientDentalExamination(patientID, tempDentalExamination);
  }

  @override
  void initState() {
    load = loadFuntionc();
  }

  loadFuntionc() async {
    var r = await MedicalAPI.GetPatientNonSurgicalTreatment(patientID);
    if (r.statusCode == 200) {
      nonSurgicalTreatment = r.result as NonSurgicalTreatmentModel;
    }
    await Future.delayed(Duration(milliseconds: 600));
    r = await MedicalAPI.GetPatientDentalExamination(patientID);
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
            return CIA_MedicalPagesWidget(children: [
              CIA_TextFormField(
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
              Row(
                children: [
                  Expanded(
                    child: CIA_DropDownSearch(
                      asyncItems: LoadinAPI.LoadSupervisors,
                      onSelect: (value) {
                        nonSurgicalTreatment.supervisorID = value.id;
                      },
                      selectedItem: DropDownDTO(name: nonSurgicalTreatment.supervisor!.name! ?? "", id: nonSurgicalTreatment.supervisorID ?? 0),
                      label: "Supervisor",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CIA_SecondaryButton(
                      label: "View History",
                      onTab: () {
                        CIA_PopupDialog_Table(patientID, context, "View History Treatments", (value) {});
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
                            patientID: patientID,
                            onNewVisit: (newVisit) {
                              nonSurgicalTreatment.nextVisit = newVisit.reservationTime;
                            },
                          ),
                        );
                      }),
                ],
              ),
              Obx(() => _buildTeethSuggestion())
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
              var res = await MedicalAPI.GetPaidPlanItem(patientID, currentToothDentalExamination.tooth!, value);
              if (res.statusCode == 200) {
                var model = res.result as Map<String, TreatmentPlanFieldsModel?>;
                if (model['extraction'] != null) {
                  await CIA_ShowPopUpYesNo(
                    context: context,
                    onSave: () async {
                      var res = await MedicalAPI.AddPatientReceipt(patientID, currentToothDentalExamination!.tooth!, "extraction");
                      if (res.statusCode == 200)
                        ShowSnackBar(isSuccess: true, message: "Receipt updated!");
                      else
                        ShowSnackBar(isSuccess: false);
                    },
                    title: "Extraction done at price ${model['extraction']!.planPrice!.toString()}?",
                  );
                }
              }
            } else if (value == "Filled") {
              var res = await MedicalAPI.GetPaidPlanItem(patientID, currentToothDentalExamination.tooth!, value);
              if (res.statusCode == 200) {
                var model = res.result as Map<String, TreatmentPlanFieldsModel?>;
                bool crown = false;
                bool rootCanalTreatment = false;
                bool restoration = false;

                await CIA_ShowPopUp(
                  context: context,
                  onSave: () async {
                    API_Response res = API_Response();
                    if (crown) res = await MedicalAPI.AddPatientReceipt(patientID, currentToothDentalExamination!.tooth!, "crown");
                    if (rootCanalTreatment) res = await MedicalAPI.AddPatientReceipt(patientID, currentToothDentalExamination!.tooth!, "rootCanaltreatment");
                    if (restoration) res = await MedicalAPI.AddPatientReceipt(patientID, currentToothDentalExamination!.tooth!, "restoration");

                    if (res.statusCode == 200)
                      ShowSnackBar(isSuccess: true, message: "Receipt updated!");
                    else
                      ShowSnackBar(isSuccess: false);
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

class _PatientTreatmentPlan extends StatefulWidget {
  _PatientTreatmentPlan({Key? key}) : super(key: key);

  @override
  State<_PatientTreatmentPlan> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<_PatientTreatmentPlan> {

  @override
  Widget build(BuildContext context) {
    return CIA_TeethTreatmentPlanWidget(
      patientID: patientID,
    );
  }

  @override
  void dispose() async{
    await MedicalAPI.UpdatePatientTreatmentPlan(patientID, treatmentPlanModel!.treatmentPlan!);

  }
}

class _PatientSurgicalTreatment extends StatefulWidget {
  const _PatientSurgicalTreatment({Key? key}) : super(key: key);

  @override
  State<_PatientSurgicalTreatment> createState() => _PatientSurgicalTreatmentState();
}

class _PatientSurgicalTreatmentState extends State<_PatientSurgicalTreatment> {

  @override
  Widget build(BuildContext context) {
    return CIA_TeethTreatmentPlanWidget(
      patientID: patientID,
      surgical: true,
    );
  }

  @override
  void dispose() async{
    await MedicalAPI.UpdatePatientSurgicalTreatment(patientID, surgicalTreatmentModel);

  }
}

class _PatientProstheticTreatment extends StatefulWidget {
  const _PatientProstheticTreatment({Key? key}) : super(key: key);

  @override
  State<_PatientProstheticTreatment> createState() => _PatientProstheticTreatmentState();
}

class _PatientProstheticTreatmentState extends State<_PatientProstheticTreatment> {
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
    /*for (String key in MasterController.TreatmentPlan.keys) {
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
    }*/
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
    StepModel(name: "Exposure", stepStatus: LabStepStatus.Done),
    StepModel(name: "Impression", stepStatus: LabStepStatus.InProgress),
    StepModel(name: "Follow Up", stepStatus: LabStepStatus.NotYet),
    StepModel(name: "Try In", stepStatus: LabStepStatus.NotYet),
    StepModel(name: "Verification Jig", stepStatus: LabStepStatus.NotYet),
    StepModel(name: "Delivery", stepStatus: LabStepStatus.NotYet),
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
                    if (myActiveIndex! != 0) myActiveIndex = (myActiveIndex as int) - 1;
                    setState(() {});
                  } catch (e) {}
                },
                child: Icon(Icons.keyboard_arrow_left)),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  try {
                    if (myActiveIndex! != stepModels.indexWhere((element) => element.stepStatus == LabStepStatus.InProgress))
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
            myActiveIndex != null ? FormTextValueWidget(text: stepModels[myActiveIndex!].name) : Text(""),
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
    myActiveIndex = stepModels.indexWhere((element) => element.stepStatus == LabStepStatus.InProgress);
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
