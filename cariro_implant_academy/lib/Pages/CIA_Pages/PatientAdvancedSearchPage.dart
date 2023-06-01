import 'package:cariro_implant_academy/Models/DTOs/AdvancedPatientSearchDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/ComplainsModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';

import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_SecondaryButton.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/Title.dart';
import '../SharedPages/PatientSharedPages.dart';
import 'Patient_MedicalInfo.dart';



class PatientAdvancedSearchPage extends StatefulWidget {
  PatientAdvancedSearchPage({Key? key}) : super(key: key);
  static String routeName = "AdvancedSearch";

  @override
  State<PatientAdvancedSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientAdvancedSearchPage> {
  AdvancedPatientSearchDataSource dataSource = AdvancedPatientSearchDataSource();
  AdvancedPatientSearchDTO searchDTO = AdvancedPatientSearchDTO();
  List<String> columns =[];
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TitleWidget(
                title: "Advanced Search",
                showBackButton: false,
              ),
            ),
            CIA_SecondaryButton(
                label: "Load Last Filter",
                onTab: () {
                  searchDTO = siteController.searchPatientQuery;
                  columns = siteController.searchPatientColumn;
                  dataSource.loadData(msearchDTO: searchDTO).then((value) => setState((){columns = value;}));

                }),
            SizedBox(width: 10,),
            CIA_PrimaryButton(
                label: "Show filter",
                onTab: () {
                  CIA_ShowPopUp(
                      width: 1100,
                      context: context,
                      title: "Filters",
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Age Range"),
                              SizedBox(width: 10),
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "From",
                                  controller: TextEditingController(text: (searchDTO.ageRangeFrom ?? "").toString()),
                                  isNumber: true,
                                  onChange: (v) {
                                    if (v == null || v == "" || v=="0")
                                      searchDTO.ageRangeFrom = null;
                                    else
                                      searchDTO.ageRangeFrom = int.parse(v);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "To",
                                  controller: TextEditingController(text: (searchDTO.ageRangeTo ?? "").toString()),
                                  isNumber: true,
                                  onChange: (v) {
                                    if (v == null || v == "" || v == "0")
                                      searchDTO.ageRangeTo = null;
                                    else
                                      searchDTO.ageRangeTo = int.parse(v);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Gender"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.gender == null),
                                  CIA_MultiSelectChipWidgeModel(label: "Male", isSelected: searchDTO.gender == EnumGender.Male),
                                  CIA_MultiSelectChipWidgeModel(label: "Female", isSelected: searchDTO.gender == EnumGender.Female),

                                ],
                                singleSelect: true,
                                onChange: (item, isSelected) {
                                  if (item == "Male")
                                    searchDTO.gender = EnumGender.Male;
                                  else if (item == "Female")
                                    searchDTO.gender = EnumGender.Female;
                                  else if (item == "All") searchDTO.gender = null;
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Any Diseases"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.anyDiseases == null),
                                  CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: searchDTO.anyDiseases == true),
                                  CIA_MultiSelectChipWidgeModel(label: "No", isSelected: searchDTO.anyDiseases == false),
                                ],
                                singleSelect: true,
                                onChange: (item, isSelected) {
                                  if (item == "Yes")
                                    searchDTO.anyDiseases = true;
                                  else if (item == "No") searchDTO.anyDiseases = false;
                                  else if (item == "All") searchDTO.anyDiseases = null;
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Blood Pressure"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.bloodPressureCategories == null),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Normal",
                                      isSelected:
                                          searchDTO.bloodPressureCategories != null && searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.Normal)),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Hypertensive Controlled",
                                      isSelected: searchDTO.bloodPressureCategories != null &&
                                          searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypertensiveControlled)),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Hypertensive Uncontrolled",
                                      isSelected: searchDTO.bloodPressureCategories != null &&
                                          searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypertensiveUncontrolled)),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Hypotensive Controlled",
                                      isSelected: searchDTO.bloodPressureCategories != null &&
                                          searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypotensiveControlled)),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Hypotensive Uncontrolled",
                                      isSelected: searchDTO.bloodPressureCategories != null &&
                                          searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypotensiveUncontrolled)),
                                ],
                                onChange: (item, isSelected) {
                                  if (isSelected) {
                                    if (item == "All")
                                      searchDTO.bloodPressureCategories = null;
                                    else {
                                      if (searchDTO.bloodPressureCategories == null) searchDTO.bloodPressureCategories = [];
                                      if (item == "Normal")
                                        searchDTO.bloodPressureCategories!.add(BloodPressureEnum.Normal);
                                      else if (item == "Hypertensive Controlled")
                                        searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypertensiveControlled);
                                      else if (item == "Hypertensive Uncontrolled")
                                        searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypertensiveUncontrolled);
                                      else if (item == "Hypotensive Controlled")
                                        searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypotensiveControlled);
                                      else if (item == "Hypotensive Uncontrolled")
                                        searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypotensiveUncontrolled);
                                    }
                                  } else {
                                    if (searchDTO.bloodPressureCategories != null) {
                                      if (item == "Normal")
                                        searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.Normal);
                                      else if (item == "Hypertensive Controlled")
                                        searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypertensiveControlled);
                                      else if (item == "Hypertensive Uncontrolled")
                                        searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypertensiveUncontrolled);
                                      else if (item == "Hypotensive Controlled")
                                        searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypotensiveControlled);
                                      else if (item == "Hypotensive Uncontrolled")
                                        searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypotensiveUncontrolled);

                                      if (searchDTO.bloodPressureCategories!.isEmpty) searchDTO.bloodPressureCategories = null;
                                    }
                                  }
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Diabetes"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.diabetesCategories == null),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Normal",
                                      isSelected: searchDTO.diabetesCategories != null && searchDTO.diabetesCategories!.contains(DiabetesEnum.Normal)),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Diabetic Controlled",
                                      isSelected:
                                          searchDTO.diabetesCategories != null && searchDTO.diabetesCategories!.contains(DiabetesEnum.DiabeticControlled)),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Diabetic Uncontrolled",
                                      isSelected:
                                          searchDTO.diabetesCategories != null && searchDTO.diabetesCategories!.contains(DiabetesEnum.DiabeticUncontrolled)),
                                ],
                                onChange: (item, isSelected) {
                                  if (isSelected) {
                                    if (item == "All")
                                      searchDTO.diabetesCategories = null;
                                    else {
                                      if (searchDTO.diabetesCategories == null) searchDTO.diabetesCategories = [];
                                      if (item == "Normal")
                                        searchDTO.diabetesCategories!.add(DiabetesEnum.Normal);
                                      else if (item == "Diabetic Controlled")
                                        searchDTO.diabetesCategories!.add(DiabetesEnum.DiabeticControlled);
                                      else if (item == "Diabetic Uncontrolled") searchDTO.diabetesCategories!.add(DiabetesEnum.DiabeticUncontrolled);
                                    }
                                  } else {
                                    if (searchDTO.diabetesCategories != null) {
                                      if (item == "Normal")
                                        searchDTO.diabetesCategories!.remove(DiabetesEnum.Normal);
                                      else if (item == "Diabetic Controlled")
                                        searchDTO.diabetesCategories!.remove(DiabetesEnum.DiabeticControlled);
                                      else if (item == "Diabetic Uncontrolled") searchDTO.diabetesCategories!.remove(DiabetesEnum.DiabeticUncontrolled);

                                      if (searchDTO.diabetesCategories!.isEmpty) searchDTO.diabetesCategories = null;
                                    }
                                  }
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Last HAB1c Range"),
                              SizedBox(width: 10),
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "From",
                                  controller: TextEditingController(text: (searchDTO.lastHAB1cFrom ?? "").toString()),
                                  isNumber: true,
                                  onChange: (v) {
                                    if (v == null || v == "" || v=="0")
                                      searchDTO.lastHAB1cFrom = null;
                                    else
                                      searchDTO.lastHAB1cFrom = int.parse(v);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "To",
                                  controller: TextEditingController(text: (searchDTO.lastHAB1cTo ?? "").toString()),
                                  isNumber: true,
                                  onChange: (v) {
                                    if (v == null || v == "" || v == "0")
                                      searchDTO.lastHAB1cTo = null;
                                    else
                                      searchDTO.lastHAB1cTo = int.parse(v);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Penecilin"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.penecilin == null),
                                      CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: searchDTO.penecilin == true),
                                      CIA_MultiSelectChipWidgeModel(label: "No", isSelected: searchDTO.penecilin == false),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "Yes")
                                        searchDTO.penecilin = true;
                                      else if (item == "No") searchDTO.penecilin = false;
                                      else if (item == "All") searchDTO.penecilin = null;
                                    },
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "IllegalDrugs"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.illegalDrugs == null),
                                      CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: searchDTO.illegalDrugs == true),
                                      CIA_MultiSelectChipWidgeModel(label: "No", isSelected: searchDTO.illegalDrugs == false),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "Yes")
                                        searchDTO.illegalDrugs = true;
                                      else if (item == "No") searchDTO.illegalDrugs = false;
                                      else if (item == "All") searchDTO.illegalDrugs = null;
                                    },
                                  ))
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Pregnancy"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.pregnancy == null),
                                      CIA_MultiSelectChipWidgeModel(label: "None", isSelected: searchDTO.pregnancy == PregnancyEnum.None),
                                      CIA_MultiSelectChipWidgeModel(label: "Pregnant", isSelected: searchDTO.pregnancy == PregnancyEnum.Pregnant),
                                      CIA_MultiSelectChipWidgeModel(label: "Lactating", isSelected: searchDTO.pregnancy == PregnancyEnum.Lactating),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "None")
                                        searchDTO.pregnancy = PregnancyEnum.None;
                                      else if (item == "Pregnant")
                                        searchDTO.pregnancy = PregnancyEnum.Pregnant;
                                      else if (item == "Lactating") searchDTO.pregnancy = PregnancyEnum.Lactating;
                                      else if (item == "All") searchDTO.pregnancy = null;
                                    },
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Chewing Sensitivity"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.chewing == null),
                                      CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: searchDTO.chewing == true),
                                      CIA_MultiSelectChipWidgeModel(label: "No", isSelected: searchDTO.chewing == false),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "Yes")
                                        searchDTO.chewing = true;
                                      else if (item == "No") searchDTO.chewing = false;
                                      else if (item == "All") searchDTO.chewing = null;
                                    },
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Smoking"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.smokingStatus == null),
                                      CIA_MultiSelectChipWidgeModel(label: "None Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.NoneSmoker),
                                      CIA_MultiSelectChipWidgeModel(label: "Light Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.LightSmoker),
                                      CIA_MultiSelectChipWidgeModel(label: "Medium Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.MediumSmoker),
                                      CIA_MultiSelectChipWidgeModel(label: "Heavy Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.HeavySmoker),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "All")
                                        searchDTO.smokingStatus = null;
                                      else if (item == "None Smoker")
                                        searchDTO.smokingStatus = SmokingStatus.NoneSmoker;
                                      else if (item == "Light Smoker")
                                        searchDTO.smokingStatus = SmokingStatus.LightSmoker;
                                      else if (item == "Medium Smoker") searchDTO.smokingStatus = SmokingStatus.MediumSmoker;
                                      else if (item == "Heavy Smoker") searchDTO.smokingStatus = SmokingStatus.HeavySmoker;
                                    },
                                  ))
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Cooperation Level"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.cooperationScore == null),
                                      CIA_MultiSelectChipWidgeModel(label: "Bad Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.BadCooperation),
                                      CIA_MultiSelectChipWidgeModel(label: "Fair Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.FairCooperation),
                                      CIA_MultiSelectChipWidgeModel(label: "Good Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.GoodCooperation),
                                      CIA_MultiSelectChipWidgeModel(label: "Excellent Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.ExcellentCooperation),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "All")
                                        searchDTO.cooperationScore = null;
                                      else if (item == "Bad Cooperation")
                                        searchDTO.cooperationScore = EnumCooperationScore.BadCooperation;
                                      else if (item == "Fair Cooperation") searchDTO.cooperationScore = EnumCooperationScore.FairCooperation;
                                      else if (item == "Good Cooperation") searchDTO.cooperationScore = EnumCooperationScore.GoodCooperation;
                                      else if (item == "Excellent Cooperation") searchDTO.cooperationScore = EnumCooperationScore.ExcellentCooperation;
                                    },
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              FormTextKeyWidget(text: "Oral Hygiene"),
                              SizedBox(width: 10),
                              Expanded(
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchDTO.oralHygieneRating == null),
                                      CIA_MultiSelectChipWidgeModel(label: "Bad", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.BadHygiene),
                                      CIA_MultiSelectChipWidgeModel(label: "Fair", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.FairHygiene),
                                      CIA_MultiSelectChipWidgeModel(label: "Good", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.GoodHygiene),
                                      CIA_MultiSelectChipWidgeModel(label: "Excellent", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.ExcellentHygiene),
                                    ],
                                    singleSelect: true,
                                    onChange: (item, isSelected) {
                                      if (item == "All")
                                        searchDTO.oralHygieneRating =null;
                                      else if (item == "Bad")
                                        searchDTO.oralHygieneRating = EnumOralHygieneRating.BadHygiene;
                                      else if (item == "Fair") searchDTO.oralHygieneRating = EnumOralHygieneRating.FairHygiene;
                                      else if (item == "Good") searchDTO.oralHygieneRating = EnumOralHygieneRating.GoodHygiene;
                                      else if (item == "Excellent") searchDTO.oralHygieneRating = EnumOralHygieneRating.ExcellentHygiene;
                                    },
                                  ))
                            ],
                          ),

                        ],

                      ),
                      onSave: (){
                        dataSource.loadData(msearchDTO: searchDTO).then((value) => setState((){columns = value;}));
                        siteController.searchPatientColumn = columns;
                        siteController.searchPatientQuery = searchDTO;
                      }
                  );
                }),
          ],
        ),
        Expanded(
          child: CIA_Table(
            key: GlobalKey(),
            columnNames: columns,
            loadFunction: ()  async{
              columns = await dataSource.loadData(msearchDTO: searchDTO);
              return columns;
            },
            dataSource: dataSource,
            onCellClick: (value) {
              //print(dataSource.models[value - 1].id);
              // setState(() {
              //selectedPatientID = dataSource.models[value - 1].id!;
              //print("");
              //});
              //internalPagesController.jumpToPage(1);
              context.goNamed(CIA_Router.routeConst_PatientInfo, pathParameters: {"id": dataSource.models[value - 1].id!.toString()});
            },
          ),
        ),
      ],
    );
  }
}
