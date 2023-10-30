import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/pages/prsotheticTreatmentPage.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/ComplainsModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../Models/PatientInfo.dart';
import '../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../Widgets/CIA_Table.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../Widgets/Title.dart';
import '../../../patientsMedical/prosthetic/domain/enums/enum.dart';
import '../../../patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import '../../../patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';
import '../../domain/usecases/advancedProstheticSearchUseCase.dart';
import '../bloc/advancedSearchBloc.dart';

enum AdvancedSearchEnum { Patient, Treatments, Prosthetic }

enum _ProstheticSearchType {
  DiagnosticImpression,
  ScanAppliance,
  Bite,
  SingleAndBridge,
  FullArch,
}

enum _FinalProstheticSearchType {
  HealingCollar,
  Impression,
  TryIn,
  Delivery,
}

class PatientAdvancedSearchPage extends StatefulWidget {
  PatientAdvancedSearchPage({Key? key, required this.advancedSearchType}) : super(key: key);
  static String routeNamePatients = "PatientsAdvancedSearch";
  static String routeNameTreatments = "TreatmentAdvancedSearch";
  static String routeNameProsthetic = "ProstheticAdvancedSearch";
  static String routePathPatients = "AdvancedSearch/PatientsAdvancedSearch";
  static String routePathTreatments = "AdvancedSearch/TreatmentAdvancedSearch";
  static String routePathProsthetic = "AdvancedSearch/ProstheticAdvancedSearch";
  AdvancedSearchEnum advancedSearchType;

  @override
  State<PatientAdvancedSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientAdvancedSearchPage> with TickerProviderStateMixin {
  AdvancedPatientSearchDataGridSource dataSource_patients = AdvancedPatientSearchDataGridSource();
  AdvancedTreatmentSearchDataGridSource dataSource_treatments = AdvancedTreatmentSearchDataGridSource();
  AdvancedProstheticSearchDataGridSource dataSource_prosthetic = AdvancedProstheticSearchDataGridSource();
  AdvancedPatientSearchEntity searchDTO = AdvancedPatientSearchEntity();
  AdvancedTreatmentSearchEntity searchTreatmentsDTO = AdvancedTreatmentSearchEntity(done: false);
  ProstheticTreatmentEntity searchProstheticDTO = ProstheticTreatmentEntity();
  AdvancedProstheticSearchParams searchProstheticQuery = AdvancedProstheticSearchParams(query: ProstheticTreatmentEntity());
  List<String> columns = [];

  late AdvancedSearchBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AdvancedSearchBloc>(context);
    bloc.add(widget.advancedSearchType == AdvancedSearchEnum.Treatments
        ? AdvancedSearchBloc_SearchTreatmentsEvents(query: searchTreatmentsDTO)
        : AdvancedSearchBloc_SearchPatientsEvents(query: searchDTO));
    tabController = TabController(length: 3, vsync: this);
    tabController.index = (widget.advancedSearchType == AdvancedSearchEnum.Treatments
        ? 1
        : widget.advancedSearchType == AdvancedSearchEnum.Patient
            ? 0
            : 2);
  }

  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TabBar(
            onTap: (value) {
              if (value == 0) {
                context.goNamed(PatientAdvancedSearchPage.routeNamePatients);
                bloc.add(AdvancedSearchBloc_SearchPatientsEvents(query: searchDTO));
              } else if (value == 1) {
                context.goNamed(PatientAdvancedSearchPage.routeNameTreatments);
                bloc.add(AdvancedSearchBloc_SearchTreatmentsEvents(query: searchTreatmentsDTO));
              } else if (value == 2) {
                context.goNamed(PatientAdvancedSearchPage.routeNameProsthetic);
                // bloc.add(AdvancedSearchBloc_SearchTreatmentsEvents(query: searchTreatmentsDTO));
              }

              //setState(() {});
            },
            controller: tabController,
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: "Patients",
              ),
              Tab(
                text: "Treatments",
              ),
              Tab(
                text: "Prosthetic Treatment",
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
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
                            searchDTO = bloc.searchPatientQuery;
                            bloc.add(AdvancedSearchBloc_SearchPatientsEvents(query: searchDTO));
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      CIA_PrimaryButton(
                          isLong: true,
                          label: "Show filter",
                          onTab: () {
                            CIA_ShowPopUp(
                                width: 1100,
                                context: context,
                                title: "Filters",
                                child: ListView(
                                  children: [

                                    CIA_MultiSelectChipWidget(
                                      key: GlobalKey(),
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "No Treatment Plans Assigned",  isSelected: searchDTO.noTreatmentPlan == true),

                                      ],
                                      onChange: (item, isSelected) {
                                        searchDTO.noTreatmentPlan = isSelected;
                                      },
                                    ),
                                    SizedBox(height: 10,),
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
                                              if (v == null || v == "" || v == "0")
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
                                            else if (item == "No")
                                              searchDTO.anyDiseases = false;
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
                                                isSelected: searchDTO.bloodPressureCategories != null &&
                                                    searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.Normal)),
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
                                                isSelected:
                                                    searchDTO.diabetesCategories != null && searchDTO.diabetesCategories!.contains(DiabetesEnum.Normal)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Diabetic Controlled",
                                                isSelected: searchDTO.diabetesCategories != null &&
                                                    searchDTO.diabetesCategories!.contains(DiabetesEnum.DiabeticControlled)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Diabetic Uncontrolled",
                                                isSelected: searchDTO.diabetesCategories != null &&
                                                    searchDTO.diabetesCategories!.contains(DiabetesEnum.DiabeticUncontrolled)),
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
                                                else if (item == "Diabetic Uncontrolled")
                                                  searchDTO.diabetesCategories!.remove(DiabetesEnum.DiabeticUncontrolled);

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
                                              if (v == null || v == "" || v == "0")
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
                                            else if (item == "No")
                                              searchDTO.penecilin = false;
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
                                            else if (item == "No")
                                              searchDTO.illegalDrugs = false;
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
                                            else if (item == "Lactating")
                                              searchDTO.pregnancy = PregnancyEnum.Lactating;
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
                                            else if (item == "No")
                                              searchDTO.chewing = false;
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
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "None Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.NoneSmoker),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Light Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.LightSmoker),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Medium Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.MediumSmoker),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Heavy Smoker", isSelected: searchDTO.smokingStatus == SmokingStatus.HeavySmoker),
                                          ],
                                          singleSelect: true,
                                          onChange: (item, isSelected) {
                                            if (item == "All")
                                              searchDTO.smokingStatus = null;
                                            else if (item == "None Smoker")
                                              searchDTO.smokingStatus = SmokingStatus.NoneSmoker;
                                            else if (item == "Light Smoker")
                                              searchDTO.smokingStatus = SmokingStatus.LightSmoker;
                                            else if (item == "Medium Smoker")
                                              searchDTO.smokingStatus = SmokingStatus.MediumSmoker;
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
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Bad Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.BadCooperation),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Fair Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.FairCooperation),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Good Cooperation", isSelected: searchDTO.cooperationScore == EnumCooperationScore.GoodCooperation),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Excellent Cooperation",
                                                isSelected: searchDTO.cooperationScore == EnumCooperationScore.ExcellentCooperation),
                                          ],
                                          singleSelect: true,
                                          onChange: (item, isSelected) {
                                            if (item == "All")
                                              searchDTO.cooperationScore = null;
                                            else if (item == "Bad Cooperation")
                                              searchDTO.cooperationScore = EnumCooperationScore.BadCooperation;
                                            else if (item == "Fair Cooperation")
                                              searchDTO.cooperationScore = EnumCooperationScore.FairCooperation;
                                            else if (item == "Good Cooperation")
                                              searchDTO.cooperationScore = EnumCooperationScore.GoodCooperation;
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
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Bad", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.BadHygiene),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Fair", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.FairHygiene),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Good", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.GoodHygiene),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Excellent", isSelected: searchDTO.oralHygieneRating == EnumOralHygieneRating.ExcellentHygiene),
                                          ],
                                          singleSelect: true,
                                          onChange: (item, isSelected) {
                                            if (item == "All")
                                              searchDTO.oralHygieneRating = null;
                                            else if (item == "Bad")
                                              searchDTO.oralHygieneRating = EnumOralHygieneRating.BadHygiene;
                                            else if (item == "Fair")
                                              searchDTO.oralHygieneRating = EnumOralHygieneRating.FairHygiene;
                                            else if (item == "Good")
                                              searchDTO.oralHygieneRating = EnumOralHygieneRating.GoodHygiene;
                                            else if (item == "Excellent") searchDTO.oralHygieneRating = EnumOralHygieneRating.ExcellentHygiene;
                                          },
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                                onSave: () {
                                  bloc.add(AdvancedSearchBloc_SearchPatientsEvents(query: searchDTO));
                                  bloc.searchPatientQuery = searchDTO;
                                });
                          }),
                    ],
                  ),
                  Expanded(
                    child: BlocConsumer<AdvancedSearchBloc, AdvancedSearchBloc_States>(listener: (context, state) {
                      if (state is AdvancedSearchBloc_LoadedPatientsSuccessfullyState)
                        dataSource_patients.updateData(
                          searchQuery: searchDTO,
                          searchResults: state.data,
                        );
                    }, builder: (context, state) {
                      if (state is AdvancedSearchBloc_LoadingErrorState)
                        return BigErrorPageWidget(message: state.message);
                      else if (state is AdvancedSearchBloc_LoadingState) return LoadingWidget();
                      return TableWidget(
                        key: GlobalKey(),
                        allowSorting: true,
                        dataSource: dataSource_patients,
                        onCellClick: (value) {
                          // setState(() {
                          //selectedPatientID = dataSource.models[value - 1].id!;

                          //});
                          //internalPagesController.jumpToPage(1);
                          print(value);
                          context.goNamed(CIA_Router.routeConst_PatientInfo, pathParameters: {"id": value.toString()});
                        },
                      );
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TitleWidget(
                          title: "Advanced Search",
                          showBackButton: false,
                        ),
                      ),
                      Row(
                        children: [
                          FormTextValueWidget(text: "Done"),
                          SizedBox(width: 10),
                          Container(
                            color: Colors.green,
                            width: 10,
                            height: 10,
                          ),
                          SizedBox(width: 10),
                          FormTextValueWidget(text: "Planned"),
                          SizedBox(width: 10),
                          Container(
                            color: Colors.orange,
                            width: 10,
                            height: 10,
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      CIA_SecondaryButton(
                          label: "Load Last Filter",
                          onTab: () {
                            searchTreatmentsDTO = bloc.searchTreatmentQuery;
                            bloc.add(AdvancedSearchBloc_SearchTreatmentsEvents(query: searchTreatmentsDTO));
                          }),
                      SizedBox(width: 10),
                      CIA_PrimaryButton(
                          isLong: true,
                          label: "Show filter",
                          onTab: () {
                            CIA_ShowPopUp(
                                width: 1100,
                                context: context,
                                title: "Filters",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    CIA_MultiSelectChipWidget(
                                      key: GlobalKey(),
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "No Treatment Plans Assigned",  isSelected: searchTreatmentsDTO.noTreatmentPlan == true),

                                      ],
                                      onChange: (item, isSelected) {
                                        searchTreatmentsDTO.noTreatmentPlan = isSelected;
                                      },
                                    ),
                                    SizedBox(height: 10,),
                                    CIA_MultiSelectChipWidget(
                                      key: GlobalKey(),
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "Plan", isSelected: searchTreatmentsDTO.done == false),
                                        CIA_MultiSelectChipWidgeModel(label: "Treatment", isSelected: searchTreatmentsDTO.done == true),
                                      ],
                                      singleSelect: true,
                                      onChange: (item, isSelected) {
                                        if (item == "Plan")
                                          searchTreatmentsDTO.done = false;
                                        else
                                          searchTreatmentsDTO.done = true;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    CIA_MultiSelectChipWidget(
                                      key: GlobalKey(),
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Upper Anterior",
                                            isSelected: searchTreatmentsDTO.teethClassification == EnumTeethClassification.UpperAnterior),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Lower Anterior",
                                            isSelected: searchTreatmentsDTO.teethClassification == EnumTeethClassification.LowerAnterior),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Upper Posterior",
                                            isSelected: searchTreatmentsDTO.teethClassification == EnumTeethClassification.UpperPosterior),
                                        CIA_MultiSelectChipWidgeModel(
                                            label: "Lower Posterior",
                                            isSelected: searchTreatmentsDTO.teethClassification == EnumTeethClassification.LowerPosterior),
                                        CIA_MultiSelectChipWidgeModel(label: "All", isSelected: searchTreatmentsDTO.teethClassification == null),
                                      ],
                                      singleSelect: true,
                                      onChange: (item, isSelected) {
                                        if (item == "Upper Anterior")
                                          searchTreatmentsDTO.teethClassification = EnumTeethClassification.UpperAnterior;
                                        else if (item == "Upper Posterior")
                                          searchTreatmentsDTO.teethClassification = EnumTeethClassification.UpperPosterior;
                                        else if (item == "Lower Anterior")
                                          searchTreatmentsDTO.teethClassification = EnumTeethClassification.LowerAnterior;
                                        else if (item == "Lower Posterior")
                                          searchTreatmentsDTO.teethClassification = EnumTeethClassification.LowerPosterior;
                                        else if (item == "All") searchTreatmentsDTO.teethClassification = null;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    Wrap(
                                      children: [
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Scaling", isSelected: searchTreatmentsDTO.scaling == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.scaling = true;
                                            else
                                              searchTreatmentsDTO.scaling = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Crown", isSelected: searchTreatmentsDTO.crown == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.crown = true;
                                            else
                                              searchTreatmentsDTO.crown = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Root Canal Treatment", isSelected: searchTreatmentsDTO.rootCanalTreatment == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.rootCanalTreatment = true;
                                            else
                                              searchTreatmentsDTO.rootCanalTreatment = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Restoration", isSelected: searchTreatmentsDTO.restoration == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.restoration = true;
                                            else
                                              searchTreatmentsDTO.restoration = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Pontic", isSelected: searchTreatmentsDTO.pontic == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.pontic = true;
                                            else
                                              searchTreatmentsDTO.pontic = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Extraction", isSelected: searchTreatmentsDTO.extraction == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.extraction = true;
                                            else
                                              searchTreatmentsDTO.extraction = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Simple Implant", isSelected: searchTreatmentsDTO.simpleImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.simpleImplant = true;
                                            else
                                              searchTreatmentsDTO.simpleImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Immediate Implant", isSelected: searchTreatmentsDTO.immediateImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.immediateImplant = true;
                                            else
                                              searchTreatmentsDTO.immediateImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Expansion With Implant", isSelected: searchTreatmentsDTO.expansionWithImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.expansionWithImplant = true;
                                            else
                                              searchTreatmentsDTO.expansionWithImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Splitting With Implant", isSelected: searchTreatmentsDTO.splittingWithImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.splittingWithImplant = true;
                                            else
                                              searchTreatmentsDTO.splittingWithImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "GBR With Implant", isSelected: searchTreatmentsDTO.gbrWithImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.gbrWithImplant = true;
                                            else
                                              searchTreatmentsDTO.gbrWithImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Open Sinus With Implant", isSelected: searchTreatmentsDTO.openSinusWithImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.openSinusWithImplant = true;
                                            else
                                              searchTreatmentsDTO.openSinusWithImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Closed Sinus With Implant", isSelected: searchTreatmentsDTO.closedSinusWithImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.closedSinusWithImplant = true;
                                            else
                                              searchTreatmentsDTO.closedSinusWithImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Guided Implant", isSelected: searchTreatmentsDTO.guidedImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.guidedImplant = true;
                                            else
                                              searchTreatmentsDTO.guidedImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Expansion Without Implant", isSelected: searchTreatmentsDTO.expansionWithoutImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.expansionWithoutImplant = true;
                                            else
                                              searchTreatmentsDTO.expansionWithoutImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Splitting Without Implant", isSelected: searchTreatmentsDTO.splittingWithoutImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.splittingWithoutImplant = true;
                                            else
                                              searchTreatmentsDTO.splittingWithoutImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "GBR Without Implant", isSelected: searchTreatmentsDTO.gbrWithoutImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.gbrWithoutImplant = true;
                                            else
                                              searchTreatmentsDTO.gbrWithoutImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Open Sinus Without Implant", isSelected: searchTreatmentsDTO.openSinusWithoutImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.openSinusWithoutImplant = true;
                                            else
                                              searchTreatmentsDTO.openSinusWithoutImplant = null;
                                          },
                                        ),
                                        CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Closed Sinus Without Implant", isSelected: searchTreatmentsDTO.closedSinusWithoutImplant == true),
                                          ],
                                          onChange: (item, isSelected) {
                                            if (isSelected)
                                              searchTreatmentsDTO.closedSinusWithoutImplant = true;
                                            else
                                              searchTreatmentsDTO.closedSinusWithoutImplant = null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onSave: () async {
                                  bloc.searchTreatmentQuery = searchTreatmentsDTO;
                                  bloc.add(AdvancedSearchBloc_SearchTreatmentsEvents(query: searchTreatmentsDTO));
                                });
                          }),
                    ],
                  ),
                  Expanded(
                    child: BlocConsumer<AdvancedSearchBloc, AdvancedSearchBloc_States>(listener: (context, state) {
                      if (state is AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState) dataSource_treatments.updateData(state.data);
                    }, builder: (context, state) {
                      if (state is AdvancedSearchBloc_LoadingErrorState)
                        return BigErrorPageWidget(message: state.message);
                      else if (state is AdvancedSearchBloc_LoadingState) return LoadingWidget();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: TableWidget(
                              key: GlobalKey(),
                              headerHeight: 60,
                              headerStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              dataSource: dataSource_treatments,
                              onCellClick: (value) {
                                // setState(() {
                                //selectedPatientID = dataSource.models[value - 1].id!;

                                //});
                                //internalPagesController.jumpToPage(1);
                                if (searchTreatmentsDTO.done == true)
                                  context.goNamed(SurgicalTreatmentPage.routeName, pathParameters: {"id": value.toString()});
                                else
                                  context.goNamed(TreatmentPage.routeName, pathParameters: {"id": value.toString()});
                              },
                            ),
                          ),
                          Divider(),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Expanded(child: SizedBox()),
                                FormTextKeyWidget(text: "Total: "),
                                FormTextValueWidget(text: dataSource_treatments.models.length.toString()),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TitleWidget(
                          title: "Prosthetic Advanced Search",
                          showBackButton: false,
                        ),
                      ),
                      CIA_SecondaryButton(
                          label: "Load Last Filter",
                          onTab: () {
                            searchProstheticQuery = bloc.searchProstheticQuery;
                            bloc.add(AdvancedSearchBloc_SearchProstheticEvents(query: AdvancedProstheticSearchParams(query: searchProstheticDTO)));
                          }),
                      SizedBox(width: 10),
                      CIA_PrimaryButton(
                          isLong: true,
                          label: "Show filter",
                          onTab: () {
                            _ProstheticSearchType searchType = _ProstheticSearchType.DiagnosticImpression;
                            DateTime? _from;
                            DateTime? _to;

                            CIA_ShowPopUp(
                                width: 1100,
                                context: context,
                                title: "Filters",
                                child: StatefulBuilder(builder: (context, _setState) {
                                  searchProstheticDTO = ProstheticTreatmentEntity();
                                  searchProstheticQuery = bloc.searchProstheticQuery;
                                  if (searchType == _ProstheticSearchType.DiagnosticImpression) {
                                    searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression = DiagnosticImpressionEntity();
                                  } else if (searchType == _ProstheticSearchType.Bite) {
                                    searchProstheticDTO.searchProstheticDiagnostic_Bite = BiteEntity();
                                  } else if (searchType == _ProstheticSearchType.ScanAppliance) {
                                    searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance = ScanApplianceEntity();
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      CIA_MultiSelectChipWidget(
                                        onChange: (item, isSelected) {
                                          searchType = _ProstheticSearchType.values.firstWhere((element) => element.name.toLowerCase() == item.toLowerCase());
                                          _setState(() {});
                                        },
                                        singleSelect: true,
                                        labels: [
                                          CIA_MultiSelectChipWidgeModel(
                                            label: "Diagnostic Impression",
                                            value: "DiagnosticImpression",
                                            isSelected: searchType == _ProstheticSearchType.DiagnosticImpression,
                                          ),
                                          CIA_MultiSelectChipWidgeModel(
                                            label: "Bite",
                                            value: "Bite",
                                            isSelected: searchType == _ProstheticSearchType.Bite,
                                          ),
                                          CIA_MultiSelectChipWidgeModel(
                                            label: "Scan Appliance",
                                            value: "ScanAppliance",
                                            isSelected: searchType == _ProstheticSearchType.ScanAppliance,
                                          ),
                                          CIA_MultiSelectChipWidgeModel(
                                            label: "Single And Bridge",
                                            value: "SingleAndBridge",
                                            isSelected: searchType == _ProstheticSearchType.SingleAndBridge,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: CIA_DateTimeTextFormField(
                                            label: "From",
                                            controller: TextEditingController(text: _from == null ? "" : DateFormat("dd-MM-yyyy").format(_from!)),
                                            onChange: (value) => _from = value,
                                          )),
                                          SizedBox(width: 10),
                                          Expanded(
                                              child: CIA_DateTimeTextFormField(
                                            label: "To",
                                            controller: TextEditingController(text: _to == null ? "" : DateFormat("dd-MM-yyyy").format(_to!)),
                                            onChange: (value) => _to = value,
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(child: () {
                                        if (searchType == _ProstheticSearchType.DiagnosticImpression)
                                          return Column(
                                            children: [
                                              CIA_DropDownSearch(
                                                label: "Diagnostic",
                                                selectedItem: () {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression?.diagnostic != null) {
                                                    return DropDownDTO(
                                                        name: (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression?.diagnostic?.name ?? "")
                                                            .replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression == null)
                                                    searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression = DiagnosticImpressionEntity();
                                                  searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression!.diagnostic =
                                                      EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Physical", id: 0),
                                                  DropDownDTO(name: "Digital", id: 1),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              CIA_DropDownSearch(
                                                label: "Next Step",
                                                selectedItem: () {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression?.nextStep != null) {
                                                    return DropDownDTO(
                                                        name: (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression?.nextStep?.name ?? "")
                                                            .replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression == null)
                                                    searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression = (DiagnosticImpressionEntity());

                                                  searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression!.nextStep =
                                                      EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Ready for implant", id: 0),
                                                  DropDownDTO(name: "Bite", id: 1),
                                                  DropDownDTO(name: "Needs new impression", id: 2),
                                                  DropDownDTO(name: "Needs scan PPT", id: 3),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              CIA_CheckBoxWidget(
                                                text: "Needs Remake",
                                                onChange: (v) {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression == null)
                                                    searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression = (DiagnosticImpressionEntity());

                                                  return searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression!.needsRemake = v;
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              CIA_CheckBoxWidget(
                                                text: "Scanned",
                                                onChange: (v) {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression == null)
                                                    searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression = (DiagnosticImpressionEntity());

                                                  return searchProstheticDTO.searchProstheticDiagnostic_DiagnosticImpression!.scanned = v;
                                                },
                                              ),
                                            ],
                                          );
                                        else if (searchType == _ProstheticSearchType.Bite)
                                          return Column(
                                            children: [
                                              CIA_DropDownSearch(
                                                label: "Diagnostic",
                                                selectedItem: () {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_Bite?.diagnostic != null) {
                                                    return DropDownDTO(
                                                        name:
                                                            (searchProstheticDTO.searchProstheticDiagnostic_Bite?.diagnostic?.name ?? "").replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  searchProstheticDTO.searchProstheticDiagnostic_Bite!.diagnostic =
                                                      EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Done", id: 0),
                                                  DropDownDTO(name: "Needs ReScan", id: 1),
                                                  DropDownDTO(name: "Needs ReImpression", id: 2),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              CIA_DropDownSearch(
                                                label: "Next Step",
                                                selectedItem: () {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_Bite?.nextStep != null) {
                                                    return DropDownDTO(
                                                        name: searchProstheticDTO.searchProstheticDiagnostic_Bite!.nextStep!.name.replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  searchProstheticDTO.searchProstheticDiagnostic_Bite!.nextStep =
                                                      EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Scan Appliance", id: 0),
                                                  DropDownDTO(name: "ReImpression", id: 1),
                                                  DropDownDTO(name: "ReBite", id: 2),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              CIA_CheckBoxWidget(
                                                text: "Needs Remake",
                                                onChange: (v) {
                                                  return searchProstheticDTO.searchProstheticDiagnostic_Bite!.needsRemake = v;
                                                },
                                                value: searchProstheticDTO.searchProstheticDiagnostic_Bite?.needsRemake ?? false,
                                              ),
                                              SizedBox(height: 10),
                                              CIA_CheckBoxWidget(
                                                text: "Scanned",
                                                onChange: (v) {
                                                  return searchProstheticDTO.searchProstheticDiagnostic_Bite!.scanned = v;
                                                },
                                                value: searchProstheticDTO.searchProstheticDiagnostic_Bite?.scanned ?? false,
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          );
                                        else if (searchType == _ProstheticSearchType.ScanAppliance)
                                          return Column(
                                            children: [
                                              CIA_DropDownSearch(
                                                label: "Diagnostic",
                                                selectedItem: () {
                                                  if (searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance?.diagnostic != null) {
                                                    return DropDownDTO(
                                                        name: searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance!.diagnostic!.name
                                                            .replaceAll("_", " "));
                                                  }
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance!.diagnostic =
                                                      EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];
                                                },
                                                items: [
                                                  DropDownDTO(name: "Done", id: 0),
                                                  DropDownDTO(name: "Needs ReBite", id: 1),
                                                  DropDownDTO(name: "Needs ReImpression", id: 2),
                                                  DropDownDTO(name: "Needs ReDesign", id: 3),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              CIA_CheckBoxWidget(
                                                text: "Needs Remake",
                                                onChange: (v) {
                                                  return searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance!.needsRemake = v;
                                                },
                                                value: searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance?.needsRemake ?? false,
                                              ), SizedBox(height: 10),
                                              CIA_CheckBoxWidget(
                                                text: "Scanned",
                                                onChange: (v) {
                                                  return searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance!.scanned = v;
                                                },
                                                value: searchProstheticDTO.searchProstheticDiagnostic_ScanAppliance?.scanned ?? false,
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          );
                                        else if (searchType == _ProstheticSearchType.SingleAndBridge) {
                                          _FinalProstheticSearchType finalProstheticSearchType = _FinalProstheticSearchType.HealingCollar;
                                          return StatefulBuilder(builder: (context, __setState) {
                                            searchProstheticDTO = ProstheticTreatmentEntity();
                                            return Column(
                                              children: [
                                                CIA_MultiSelectChipWidget(
                                                  onChange: (item, isSelected) {
                                                    finalProstheticSearchType = _FinalProstheticSearchType.values
                                                        .firstWhere((element) => element.name.toLowerCase() == item.toLowerCase());
                                                    __setState(() {});
                                                  },
                                                  singleSelect: true,
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Healing Collar",
                                                      value: "HealingCollar",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.HealingCollar,
                                                    ),
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Impression",
                                                      value: "Impression",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.Impression,
                                                    ),
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Try In",
                                                      value: "TryIn",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.TryIn,
                                                    ),
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Delivery",
                                                      value: "Delivery",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.Delivery,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                CIA_MultiSelectChipWidget(
                                                  key: GlobalKey(),
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Upper Anterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.UpperAnterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Lower Anterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.LowerAnterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Upper Posterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.UpperPosterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Lower Posterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.LowerPosterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "All", isSelected: searchProstheticDTO.searchTeethClassification == null),
                                                  ],
                                                  singleSelect: true,
                                                  onChange: (item, isSelected) {
                                                    if (item == "Upper Anterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.UpperAnterior;
                                                    else if (item == "Upper Posterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.UpperPosterior;
                                                    else if (item == "Lower Anterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.LowerAnterior;
                                                    else if (item == "Lower Posterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.LowerPosterior;
                                                    else if (item == "All") searchProstheticDTO.searchTeethClassification = null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                () {
                                                  if (finalProstheticSearchType == _FinalProstheticSearchType.HealingCollar)
                                                    return CIA_DropDownSearch(
                                                      label: "Customization",
                                                      selectedItem: () {
                                                        if (searchProstheticDTO!.finalProthesisSingleBridgeHealingCollarStatus != null) {
                                                          return DropDownDTO(
                                                              name: searchProstheticDTO!.finalProthesisSingleBridgeHealingCollarStatus!.name
                                                                  .replaceAll("_", " "));
                                                        }
                                                        return null;
                                                      }(),
                                                      onSelect: (value) {
                                                        searchProstheticDTO!.finalProthesisSingleBridgeHealingCollarStatus =
                                                            EnumFinalProthesisSingleBridgeHealingCollarStatus.values[value.id!];
                                                      },
                                                      items: [
                                                        DropDownDTO(name: "With Customization", id: 0),
                                                        DropDownDTO(name: "Without Customization", id: 1),
                                                      ],
                                                    );
                                                  else if (finalProstheticSearchType == _FinalProstheticSearchType.Impression)
                                                    return Column(
                                                      children: [
                                                        CIA_DropDownSearch(
                                                          label: "Procedure",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisSingleBridgeImpressionStatus != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisSingleBridgeImpressionStatus!.name
                                                                      .replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisSingleBridgeImpressionStatus =
                                                                EnumFinalProthesisSingleBridgeImpressionStatus.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Scan by scan body", id: 0),
                                                            DropDownDTO(name: "Scan by abutment", id: 1),
                                                            DropDownDTO(name: "Physical Impression open tray", id: 2),
                                                            DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_DropDownSearch(
                                                          label: "Next Visit",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisSingleBridgeImpressionNextVisit != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisSingleBridgeImpressionNextVisit!.name
                                                                      .replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisSingleBridgeImpressionNextVisit =
                                                                EnumFinalProthesisSingleBridgeImpressionNextVisit.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Custom Abutment", id: 0),
                                                            DropDownDTO(name: "Try In", id: 1),
                                                            DropDownDTO(name: "Delivery", id: 2),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  else if (finalProstheticSearchType == _FinalProstheticSearchType.TryIn)
                                                    return Column(
                                                      children: [
                                                        CIA_DropDownSearch(
                                                          label: "Procedure",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisSingleBridgeTryInStatus != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisSingleBridgeTryInStatus!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisSingleBridgeTryInStatus =
                                                                EnumFinalProthesisSingleBridgeTryInStatus.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                                                            DropDownDTO(name: "Try in PMMA", id: 1),
                                                            DropDownDTO(name: "Try in on scan abutment PMMY", id: 2),
                                                            DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_DropDownSearch(
                                                          label: "Next Visit",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisSingleBridgeTryInNextVisit != null) {
                                                              return DropDownDTO(
                                                                  name:
                                                                      searchProstheticDTO!.finalProthesisSingleBridgeTryInNextVisit!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisSingleBridgeTryInNextVisit =
                                                                EnumFinalProthesisSingleBridgeTryInNextVisit.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Delivery", id: 0),
                                                            DropDownDTO(name: "Try in PMMA", id: 1),
                                                            DropDownDTO(name: "ReImpression", id: 2),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  else if (finalProstheticSearchType == _FinalProstheticSearchType.Delivery)
                                                    return Column(
                                                      children: [
                                                        CIA_DropDownSearch(
                                                          label: "Status",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisSingleBridgeDeliveryStatus != null) {
                                                              return DropDownDTO(
                                                                  name:
                                                                      searchProstheticDTO!.finalProthesisSingleBridgeDeliveryStatus!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisSingleBridgeDeliveryStatus =
                                                                EnumFinalProthesisSingleBridgeDeliveryStatus.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Done", id: 0),
                                                            DropDownDTO(name: "ReDesign", id: 1),
                                                            DropDownDTO(name: "ReImpression", id: 2),
                                                            DropDownDTO(name: "ReTryIn", id: 3),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_DropDownSearch(
                                                          label: "Next Visit",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisSingleBridgeDeliveryNextVisit != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisSingleBridgeDeliveryNextVisit!.name
                                                                      .replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisSingleBridgeDeliveryNextVisit =
                                                                EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Done", id: 0),
                                                            DropDownDTO(name: "ReDesign", id: 1),
                                                            DropDownDTO(name: "ReImpression", id: 2),
                                                            DropDownDTO(name: "ReTryIn", id: 3),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  return Container();
                                                }(),
                                              ],
                                            );
                                          });
                                        } else if (searchType == _ProstheticSearchType.FullArch) {
                                          _FinalProstheticSearchType finalProstheticSearchType = _FinalProstheticSearchType.HealingCollar;
                                          return StatefulBuilder(builder: (context, __setState) {
                                            searchProstheticDTO = ProstheticTreatmentEntity();
                                            return Column(
                                              children: [
                                                CIA_MultiSelectChipWidget(
                                                  onChange: (item, isSelected) {
                                                    finalProstheticSearchType = _FinalProstheticSearchType.values
                                                        .firstWhere((element) => element.name.toLowerCase() == item.toLowerCase());
                                                    __setState(() {});
                                                  },
                                                  singleSelect: true,
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Healing Collar",
                                                      value: "HealingCollar",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.HealingCollar,
                                                    ),
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Impression",
                                                      value: "Impression",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.Impression,
                                                    ),
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Try In",
                                                      value: "TryIn",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.TryIn,
                                                    ),
                                                    CIA_MultiSelectChipWidgeModel(
                                                      label: "Delivery",
                                                      value: "Delivery",
                                                      isSelected: finalProstheticSearchType == _FinalProstheticSearchType.Delivery,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                CIA_MultiSelectChipWidget(
                                                  key: GlobalKey(),
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Upper Anterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.UpperAnterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Lower Anterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.LowerAnterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Upper Posterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.UpperPosterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Lower Posterior",
                                                        isSelected: searchProstheticDTO.searchTeethClassification == EnumTeethClassification.LowerPosterior),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "All", isSelected: searchProstheticDTO.searchTeethClassification == null),
                                                  ],
                                                  singleSelect: true,
                                                  onChange: (item, isSelected) {
                                                    if (item == "Upper Anterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.UpperAnterior;
                                                    else if (item == "Upper Posterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.UpperPosterior;
                                                    else if (item == "Lower Anterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.LowerAnterior;
                                                    else if (item == "Lower Posterior")
                                                      searchProstheticDTO.searchTeethClassification = EnumTeethClassification.LowerPosterior;
                                                    else if (item == "All") searchProstheticDTO.searchTeethClassification = null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                () {
                                                  if (finalProstheticSearchType == _FinalProstheticSearchType.HealingCollar)
                                                    return CIA_DropDownSearch(
                                                      label: "Customization",
                                                      selectedItem: () {
                                                        if (searchProstheticDTO!.finalProthesisFullArchHealingCollarStatus != null) {
                                                          return DropDownDTO(
                                                              name: searchProstheticDTO!.finalProthesisFullArchHealingCollarStatus!.name.replaceAll("_", " "));
                                                        }
                                                        return null;
                                                      }(),
                                                      onSelect: (value) {
                                                        searchProstheticDTO!.finalProthesisFullArchHealingCollarStatus =
                                                            EnumFinalProthesisSingleBridgeHealingCollarStatus.values[value.id!];
                                                      },
                                                      items: [
                                                        DropDownDTO(name: "With Customization", id: 0),
                                                        DropDownDTO(name: "Without Customization", id: 1),
                                                      ],
                                                    );
                                                  else if (finalProstheticSearchType == _FinalProstheticSearchType.Impression)
                                                    return Column(
                                                      children: [
                                                        CIA_DropDownSearch(
                                                          label: "Procedure",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisFullArchImpressionStatus != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisFullArchImpressionStatus!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisFullArchImpressionStatus =
                                                                EnumFinalProthesisSingleBridgeImpressionStatus.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Scan by scan body", id: 0),
                                                            DropDownDTO(name: "Scan by abutment", id: 1),
                                                            DropDownDTO(name: "Physical Impression open tray", id: 2),
                                                            DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_DropDownSearch(
                                                          label: "Next Visit",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisFullArchImpressionNextVisit != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisFullArchImpressionNextVisit!.name
                                                                      .replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisFullArchImpressionNextVisit =
                                                                EnumFinalProthesisSingleBridgeImpressionNextVisit.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Custom Abutment", id: 0),
                                                            DropDownDTO(name: "Try In", id: 1),
                                                            DropDownDTO(name: "Delivery", id: 2),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  else if (finalProstheticSearchType == _FinalProstheticSearchType.TryIn)
                                                    return Column(
                                                      children: [
                                                        CIA_DropDownSearch(
                                                          label: "Procedure",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisFullArchTryInStatus != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisFullArchTryInStatus!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisFullArchTryInStatus =
                                                                EnumFinalProthesisSingleBridgeTryInStatus.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                                                            DropDownDTO(name: "Try in PMMA", id: 1),
                                                            DropDownDTO(name: "Try in on scan abutment PMMY", id: 2),
                                                            DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_DropDownSearch(
                                                          label: "Next Visit",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisFullArchTryInNextVisit != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisFullArchTryInNextVisit!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisFullArchTryInNextVisit =
                                                                EnumFinalProthesisSingleBridgeTryInNextVisit.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Delivery", id: 0),
                                                            DropDownDTO(name: "Try in PMMA", id: 1),
                                                            DropDownDTO(name: "ReImpression", id: 2),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  else if (finalProstheticSearchType == _FinalProstheticSearchType.Delivery)
                                                    return Column(
                                                      children: [
                                                        CIA_DropDownSearch(
                                                          label: "Status",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisFullArchDeliveryStatus != null) {
                                                              return DropDownDTO(
                                                                  name: searchProstheticDTO!.finalProthesisFullArchDeliveryStatus!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisFullArchDeliveryStatus =
                                                                EnumFinalProthesisSingleBridgeDeliveryStatus.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Done", id: 0),
                                                            DropDownDTO(name: "ReDesign", id: 1),
                                                            DropDownDTO(name: "ReImpression", id: 2),
                                                            DropDownDTO(name: "ReTryIn", id: 3),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_DropDownSearch(
                                                          label: "Next Visit",
                                                          selectedItem: () {
                                                            if (searchProstheticDTO!.finalProthesisFullArchDeliveryNextVisit != null) {
                                                              return DropDownDTO(
                                                                  name:
                                                                      searchProstheticDTO!.finalProthesisFullArchDeliveryNextVisit!.name.replaceAll("_", " "));
                                                            }
                                                            return null;
                                                          }(),
                                                          onSelect: (value) {
                                                            searchProstheticDTO!.finalProthesisFullArchDeliveryNextVisit =
                                                                EnumFinalProthesisSingleBridgeDeliveryNextVisit.values[value.id!];
                                                          },
                                                          items: [
                                                            DropDownDTO(name: "Done", id: 0),
                                                            DropDownDTO(name: "ReDesign", id: 1),
                                                            DropDownDTO(name: "ReImpression", id: 2),
                                                            DropDownDTO(name: "ReTryIn", id: 3),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  return Container();
                                                }(),
                                              ],
                                            );
                                          });
                                        }

                                        return Container();
                                      }())
                                    ],
                                  );
                                }),
                                onSave: () {
                                  searchProstheticQuery = AdvancedProstheticSearchParams(
                                    query: searchProstheticDTO,
                                    to: _to,
                                    from: _from,
                                  );
                                  bloc.searchProstheticQuery = searchProstheticQuery;
                                  bloc.add(AdvancedSearchBloc_SearchProstheticEvents(query: searchProstheticQuery));
                                  return true;
                                });
                          }),
                    ],
                  ),
                  Expanded(
                    child: BlocConsumer<AdvancedSearchBloc, AdvancedSearchBloc_States>(
                        listener: (context, state) {
                      if (state is AdvancedSearchBloc_LoadedProstheticSuccessfullyState)
                        dataSource_prosthetic.updateData(newData: state.data, search: searchProstheticDTO);
                    }, builder: (context, state) {
                      if (state is AdvancedSearchBloc_LoadingErrorState)
                        return BigErrorPageWidget(message: state.message);
                      else if (state is AdvancedSearchBloc_LoadingState) return LoadingWidget();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: TableWidget(
                              key: GlobalKey(),
                              headerHeight: 60,
                              headerStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              dataSource: dataSource_prosthetic,
                              onCellClick: (value) {
                                // setState(() {
                                //selectedPatientID = dataSource.models[value - 1].id!;

                                //});
                                //internalPagesController.jumpToPage(1);
                                  context.goNamed(ProstheticTreatmentPage.routeName, pathParameters: {"id": value.toString()});

                              },
                            ),
                          ),
                          Divider(),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Expanded(child: SizedBox()),
                                FormTextKeyWidget(text: "Total: "),
                                FormTextValueWidget(text: dataSource_prosthetic.models.length.toString()),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
