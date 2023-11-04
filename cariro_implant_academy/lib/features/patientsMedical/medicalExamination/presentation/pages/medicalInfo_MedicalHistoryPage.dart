import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Constants/Colors.dart';
import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_IncrementalHBA1CTextField.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../core/injection_contianer.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../domain/entities/bloodPressureEntity.dart';
import '../../domain/entities/diabeticEntity.dart';
import '../../domain/entities/hba1cEntity.dart';
import '../../domain/entities/medicalExaminationEntity.dart';
import '../bloc/medicaHistoryBloc.dart';

class PatientMedicalHistory extends StatefulWidget {
  PatientMedicalHistory({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "MedicalHistory";
   static String routeNameClinic = "ClinicMedicalHistory";
static String routePath = ":id/MedicalHistory";
  int patientId;

  static String getPath(String id) {
    return "/CIA/Patients/$id/MedicalHistory";
  }

  @override
  State<PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory> {
  late MedicalHistoryBloc bloc;
  late MedicalInfoShellBloc medicalShellBloc;
  bool edit = false;
  late MedicalExaminationEntity medicalHistoryData;

  @override
  void initState() {
    bloc = BlocProvider.of<MedicalHistoryBloc>(context);
    medicalShellBloc = context.read<MedicalInfoShellBloc>();
  }

  @override
  Widget build(BuildContext context) {
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Medical History"));
    bloc.add(MedicalHistoryBloc_GetMedicalHistoryEvent(id: widget.patientId));
    return BlocConsumer<MedicalHistoryBloc, MedicalHistoryBloc_States>(
      listener: (context, state) {

      },
      buildWhen: (previous, current) =>
          current is MedicalHistoryBloc_LoadingState || current is MedicalHistoryBloc_DataLoaded || current is MedicalHistoryBloc_ErrorState,
      builder: (context, state) {
        if (state is MedicalHistoryBloc_LoadingState)
          return LoadingWidget();
        else if (state is MedicalHistoryBloc_DataLoaded) {
          medicalHistoryData = state.medicalExaminationEntity;
          medicalShellBloc.emit(MedicalInfoBlocChangeDateState(date: state.medicalExaminationEntity.date,data: medicalHistoryData));

          bloc.isInitialized = true;
          return ListView(
            shrinkWrap: false,
            children: [
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                  bloc: medicalShellBloc,
                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                  builder: (context, stateShell) {
                    return AbsorbPointer(
                      absorbing: () {
                        if (stateShell is MedicalInfoBlocChangeViewEditState) {
                          edit = stateShell.edit;
                          return !edit;
                        } else {
                          edit = false;
                          return true;
                        }
                      }(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormTextKeyWidget(text: "General Health"),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_MultiSelectChipWidget(
                            singleSelect: true,
                            onChange: (value, isSelected) {
                              switch (value) {
                                case "Excellent":
                                  medicalHistoryData.generalHealth = GeneralHealthEnum.Excellent;
                                  break;
                                case "Very good":
                                  medicalHistoryData.generalHealth = GeneralHealthEnum.VeryGood;
                                  break;
                                case "Good":
                                  medicalHistoryData.generalHealth = GeneralHealthEnum.Good;
                                  break;
                                case "Fair":
                                  medicalHistoryData.generalHealth = GeneralHealthEnum.Fair;
                                  break;
                                case "Fail":
                                  medicalHistoryData.generalHealth = GeneralHealthEnum.Fail;
                                  break;
                              }
                            },
                            labels: [
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Excellent", selectedColor: Colors.green, isSelected: medicalHistoryData.generalHealth == GeneralHealthEnum.Excellent),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Very good", selectedColor: Colors.green, isSelected: medicalHistoryData.generalHealth == GeneralHealthEnum.VeryGood),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Good", selectedColor: Colors.orange, isSelected: medicalHistoryData.generalHealth == GeneralHealthEnum.Good),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Fair", selectedColor: Colors.orange, isSelected: medicalHistoryData.generalHealth == GeneralHealthEnum.Fair),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Fail", selectedColor: Colors.red, isSelected: medicalHistoryData.generalHealth == GeneralHealthEnum.Fail),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                  child: HorizontalRadioButtons(
                                names: ["None", "Pregnant", "Lactating"],
                                selectionColor: Colors.red,
                                notColoredWord: "None",
                                onChange: (value) => medicalHistoryData.pregnancyStatus = mapToEnum(PregnancyEnum.values, value),
                                groupValue: medicalHistoryData.pregnancyStatus == null ? "" : medicalHistoryData.pregnancyStatus!.name,
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TextFormField(
                              label: "Are you treated for anything now?",
                              onChange: (value) => medicalHistoryData.areYouTreatedFromAnyThing = value,
                              controller: TextEditingController(text: medicalHistoryData.areYouTreatedFromAnyThing ?? "")),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TextFormField(
                              onChange: (value) => medicalHistoryData.recentSurgery = value,
                              label: "Recent Surgery",
                              controller: TextEditingController(text: medicalHistoryData.recentSurgery ?? "")),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TextFormField(
                              onChange: (value) => medicalHistoryData.comment = value,
                              label: "Comment",
                              controller: TextEditingController(text: medicalHistoryData.comment ?? "")),
                          SizedBox(
                            height: 20,
                          ),
                          FormTextKeyWidget(text: "Did you have ever?"),
                          SizedBox(
                            height: 10,
                          ),
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
                              if (medicalHistoryData.diseases == null) {
                                medicalHistoryData.diseases = [];
                              }
                              if (isSelected) {
                                medicalHistoryData.diseases?.add(disease!);
                              } else {
                                medicalHistoryData.diseases?.remove(disease);
                              }
                            },
                            redFlags: true,
                            labels: [
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Kidney Disease",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.KidneyDisease)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Liver Disease",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.LiverDisease)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Asthma",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Asthma)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Psychological",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Psychological)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Rhemuatic",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Rhemuatic)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Anemia",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Anemia)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Epilepsy",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Epilepsy)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Heart problem",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.HeartProblem)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Thyroid",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Thyroid)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Hepatitis",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Hepatitis)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Venereal Disease",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.VenerealDisease)),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Other",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diseases != null && medicalHistoryData.diseases!.contains(DiseasesEnum.Other))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormTextKeyWidget(text: "Blood Pressure"),
                          SizedBox(
                            height: 10,
                          ),
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
                                if (medicalHistoryData.bloodPressure == null) medicalHistoryData.bloodPressure = BloodPressureEntity();
                                medicalHistoryData.bloodPressure?.status = bloodPressure;
                              }
                            },
                            singleSelect: true,
                            labels: [
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Normal",
                                  isSelected: medicalHistoryData.bloodPressure != null && medicalHistoryData.bloodPressure?.status == BloodPressureEnum.Normal),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Hypertensive controlled",
                                  isSelected: medicalHistoryData.bloodPressure != null &&
                                      medicalHistoryData.bloodPressure?.status == BloodPressureEnum.HypertensiveControlled),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Hypertensive uncontrolled",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.bloodPressure != null &&
                                      medicalHistoryData.bloodPressure?.status == BloodPressureEnum.HypertensiveUncontrolled),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Hypotensive controlled",
                                  isSelected: medicalHistoryData.bloodPressure != null &&
                                      medicalHistoryData.bloodPressure?.status == BloodPressureEnum.HypotensiveControlled),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Hypotensive uncontrolled",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.bloodPressure != null &&
                                      medicalHistoryData.bloodPressure?.status == BloodPressureEnum.HypotensiveUncontrolled),
                            ],
                          ),
                          SizedBox(
                            height: 10,
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
                                        if (medicalHistoryData.bloodPressure == null) {
                                          medicalHistoryData.bloodPressure = BloodPressureEntity();
                                        }
                                        medicalHistoryData.bloodPressure?.lastReading = value;
                                      },
                                      label: "Last Reading ",
                                      controller: TextEditingController(
                                          text: medicalHistoryData.bloodPressure != null ? (medicalHistoryData.bloodPressure?.lastReading ?? "") : "")),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: CIA_DateTimeTextFormField(
                                      onChange: (value) {
                                        if (medicalHistoryData.bloodPressure == null) {
                                          medicalHistoryData.bloodPressure = BloodPressureEntity();
                                        }
                                        medicalHistoryData.bloodPressure?.when = value;
                                      },
                                      label: "When? ",
                                      controller: TextEditingController(
                                          text: medicalHistoryData?.bloodPressure?.when == null
                                              ? ""
                                              : DateFormat("dd-MM-yyyy").format(medicalHistoryData!.bloodPressure!.when!))),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: CIA_TextFormField(
                                      onChange: (value) {
                                        if (medicalHistoryData.bloodPressure == null) {
                                          medicalHistoryData.bloodPressure = BloodPressureEntity();
                                        }
                                        medicalHistoryData.bloodPressure?.drug = value;
                                      },
                                      label: "Drug ",
                                      controller: TextEditingController(
                                          text: medicalHistoryData.bloodPressure != null ? (medicalHistoryData.bloodPressure?.drug ?? "") : "")),
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
                                        if (medicalHistoryData.bloodPressure == null) {
                                          medicalHistoryData.bloodPressure = BloodPressureEntity();
                                        }
                                        medicalHistoryData.bloodPressure?.readingInClinic = value;
                                      },
                                      label: "Reading in clinic ",
                                      controller: TextEditingController(
                                          text: medicalHistoryData.bloodPressure != null ? (medicalHistoryData.bloodPressure?.readingInClinic ?? "") : "")),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormTextKeyWidget(text: "Glucose Status"),
                          SizedBox(
                            height: 10,
                          ),
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
                                if (medicalHistoryData.diabetic == null) medicalHistoryData.diabetic = new DiabeticEntity();
                                medicalHistoryData.diabetic?.status = diabetese;
                              }
                            },
                            singleSelect: true,
                            labels: [
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Non diabetic",
                                  isSelected: medicalHistoryData.diabetic != null && medicalHistoryData.diabetic?.status == DiabetesEnum.Normal),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Diabetic controlled",
                                  isSelected: medicalHistoryData.diabetic != null && medicalHistoryData.diabetic?.status == DiabetesEnum.DiabeticControlled),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Diabetic uncontrolled",
                                  selectedColor: Colors.red,
                                  isSelected: medicalHistoryData.diabetic != null && medicalHistoryData.diabetic?.status == DiabetesEnum.DiabeticUncontrolled),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CIA_DropDownSearch(
                                    disableSearch: true,
                                    onSelect: (value) {
                                      if (medicalHistoryData.diabetic == null) medicalHistoryData.diabetic = DiabeticEntity();
                                      if (value.name.toString().toLowerCase() == "random")
                                        medicalHistoryData.diabetic?.type = DiabetesMeasureType.Random;
                                      else if (value.name.toString().toLowerCase() == "fasting")
                                        medicalHistoryData.diabetic?.type = DiabetesMeasureType.Fasting;
                                    },
                                    label: 'Type',
                                    items: [DropDownDTO(name: "Random"), DropDownDTO(name: "Fasting")],
                                    selectedItem: DropDownDTO(
                                        name: medicalHistoryData.diabetic != null && medicalHistoryData.diabetic?.type != null
                                            ? medicalHistoryData.diabetic?.type!.name ?? ""
                                            : ""),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: CIA_TextFormField(
                                      isNumber: true,
                                      onChange: (value) {
                                        if (medicalHistoryData.diabetic == null) {
                                          medicalHistoryData.diabetic = DiabeticEntity();
                                        }
                                        medicalHistoryData.diabetic?.lastReading = int.parse(value);
                                      },
                                      label: "Last Reading ",
                                      controller: TextEditingController(
                                          text: medicalHistoryData.diabetic != null && medicalHistoryData.diabetic?.lastReading != null
                                              ? medicalHistoryData.diabetic?.lastReading.toString()
                                              : "")),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: CIA_DateTimeTextFormField(
                                      onChange: (value) {
                                        if (medicalHistoryData.diabetic == null) {
                                          medicalHistoryData.diabetic = DiabeticEntity();
                                        }
                                        medicalHistoryData.diabetic?.when = value;
                                      },
                                      label: "When? ",
                                      controller:
                                          TextEditingController(text: medicalHistoryData?.diabetic?.when != null ? DateFormat("dd-MM-yyyy").format(medicalHistoryData.diabetic!.when!) : "")),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: CIA_TextFormField(
                                      isNumber: true,
                                      onChange: (value) {
                                        if (medicalHistoryData.diabetic == null) {
                                          medicalHistoryData.diabetic = DiabeticEntity();
                                        }
                                        medicalHistoryData.diabetic?.randomInClinic = int.parse(value);
                                      },
                                      label: "Random in clinic ",
                                      controller: TextEditingController(
                                          text: medicalHistoryData.diabetic != null ? (medicalHistoryData.diabetic?.randomInClinic ?? "").toString() : "")),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormTextKeyWidget(text: "HBA1c"),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_IncrementalHBA1CTextField(
                              onChange: (value) {
                                medicalHistoryData.hbA1c = value;
                              },
                              model: medicalHistoryData.hbA1c != null ? medicalHistoryData.hbA1c as List<HbA1cEntity> : []),
                          SizedBox(
                            height: 20,
                          ),
                          FormTextKeyWidget(text: "Are you allergic to?"),
                          Row(
                            children: [
                              Expanded(
                                child: CIA_MultiSelectChipWidget(
                                    onChange: (value, isSelected) {
                                      if (value == "Penicillin")
                                        medicalHistoryData.penicillin = isSelected;
                                      else if (value == "Sulfa")
                                        medicalHistoryData.sulfa = isSelected;
                                      else if (value == "Other") medicalHistoryData.otherAllergy = isSelected;
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Penicillin",
                                          selectedColor: Colors.red,
                                          isSelected: medicalHistoryData.penicillin != null ? medicalHistoryData.penicillin as bool : false),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Sulfa", isSelected: medicalHistoryData.sulfa != null ? medicalHistoryData.sulfa as bool : false),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Other",
                                          isSelected: medicalHistoryData.otherAllergy != null ? medicalHistoryData.otherAllergy as bool : false),
                                    ]),
                              ),
                              Expanded(
                                flex: 2,
                                child: CIA_TextFormField(
                                    label: "Other Allergy",
                                    onChange: (value) => medicalHistoryData.otherAllergyComment = value,
                                    controller: TextEditingController(text: medicalHistoryData.otherAllergyComment ?? "")),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
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
                                      medicalHistoryData.prolongedBleedingOrAspirin = isSelected;
                                    else if (value == "No") medicalHistoryData.prolongedBleedingOrAspirin = !isSelected;
                                  },
                                  singleSelect: true,
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(
                                        label: "Yes",
                                        isSelected:
                                            medicalHistoryData.prolongedBleedingOrAspirin != null && medicalHistoryData.prolongedBleedingOrAspirin as bool),
                                    CIA_MultiSelectChipWidgeModel(
                                        label: "No",
                                        isSelected:
                                            medicalHistoryData.prolongedBleedingOrAspirin != null && !(medicalHistoryData.prolongedBleedingOrAspirin as bool)),
                                  ]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
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
                                      medicalHistoryData.chronicDigestion = isSelected;
                                    else if (value == "No") medicalHistoryData.chronicDigestion = !isSelected;
                                  },
                                  singleSelect: true,
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(
                                        label: "Yes", isSelected: medicalHistoryData.chronicDigestion != null && (medicalHistoryData.chronicDigestion as bool)),
                                    CIA_MultiSelectChipWidgeModel(
                                        label: "No", isSelected: medicalHistoryData.chronicDigestion != null && !(medicalHistoryData.chronicDigestion as bool)),
                                  ]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TextFormField(
                            changeColorIfFilled: true,
                            borderColorOnChange: Colors.red,
                            borderColor: Color_TextFieldBorder,
                            label: "Illegal Drugs",
                            controller: TextEditingController(text: medicalHistoryData.illegalDrugs ?? ""),
                            onChange: (value) {
                              medicalHistoryData.illegalDrugs = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TextFormField(
                              onChange: (value) => medicalHistoryData.operatorComments = value,
                              label: "Operator Comments",
                              controller: TextEditingController(text: medicalHistoryData.operatorComments ?? "")),
                          SizedBox(
                            height: 20,
                          ),
                          FormTextKeyWidget(text: "Drugs Taken by patient"),
                          SizedBox(
                            height: 10,
                          ),
                          StatefulBuilder(
                            builder: (context, setState) {
                              int index = 0;

                              if (medicalHistoryData.drugsTaken == null) medicalHistoryData.drugsTaken = [];
                              if (medicalHistoryData.drugsTaken!.isEmpty) medicalHistoryData.drugsTaken!.add("");
                              return Column(
                                children: medicalHistoryData.drugsTaken!
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
                                                controller: TextEditingController(text: e ?? ""),
                                                onChange: (v) {
                                                  e = v;
                                                  medicalHistoryData.drugsTaken![index - 1] = v;
                                                },
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() => medicalHistoryData.drugsTaken!.add(""));
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() => medicalHistoryData.drugsTaken!.remove(e));
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
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is MedicalHistoryBloc_ErrorState)
          return BigErrorPageWidget(message: state.message);
        else
          return BigErrorPageWidget(message: "Couldn't retrieve data");
      },
    );
  }

  @override
  void dispose() {
    if (bloc.isInitialized && edit) bloc.add(MedicalHistoryBloc_SaveMedicalHistoryEvent(medicalExaminationEntity: medicalHistoryData));
    super.dispose();
  }
}
