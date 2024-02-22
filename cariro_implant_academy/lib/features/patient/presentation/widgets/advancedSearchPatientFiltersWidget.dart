import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'advancedSearchFilterChildWidgert.dart';

class AdvancedSearchPatientFilterWidget extends StatefulWidget {
  AdvancedSearchPatientFilterWidget({
    Key? key,
    required this.searchDTO,
  }) : super(key: key);
  AdvancedPatientSearchEntity searchDTO;

  @override
  State<AdvancedSearchPatientFilterWidget> createState() => _AdvancedSearchPatientFilterWidgetState();
}

class _AdvancedSearchPatientFilterWidgetState extends State<AdvancedSearchPatientFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionTile(
        title: Text("Patient Filter"),
        children: [
          AdvancedSearchFilterChildWidget(
            title: "Age Range",
            child: Row(
              children: [
                Expanded(
                  child: CIA_TextFormField(
                    label: "From",
                    controller: TextEditingController(text: (widget.searchDTO.ageRangeFrom ?? "").toString()),
                    isNumber: true,
                    onChange: (v) {
                      if (v == null || v == "" || v == "0")
                        widget.searchDTO.ageRangeFrom = null;
                      else
                        widget.searchDTO.ageRangeFrom = int.parse(v);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CIA_TextFormField(
                    label: "To",
                    controller: TextEditingController(text: (widget.searchDTO.ageRangeTo ?? "").toString()),
                    isNumber: true,
                    onChange: (v) {
                      if (v == null || v == "" || v == "0")
                        widget.searchDTO.ageRangeTo = null;
                      else
                        widget.searchDTO.ageRangeTo = int.parse(v);
                    },
                  ),
                ),
              ],
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Gender",
            child: Row(
              children: [
                CIA_CheckBoxWidget(text: "All", onChange: (value) => setState(() => widget.searchDTO.gender = null), value: widget.searchDTO.gender == null),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "Male",
                    onChange: (value) => setState(() => widget.searchDTO.gender = EnumGender.Male),
                    value: widget.searchDTO.gender == EnumGender.Male),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "Female",
                    onChange: (value) => setState(() => widget.searchDTO.gender = EnumGender.Female),
                    value: widget.searchDTO.gender == EnumGender.Female),
              ],
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Any Diseases",
            child: Row(
              children: [
                CIA_CheckBoxWidget(
                    text: "All", onChange: (value) => setState(() => widget.searchDTO.anyDiseases = null), value: widget.searchDTO.anyDiseases == null),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "Yes", onChange: (value) => setState(() => widget.searchDTO.anyDiseases = true), value: widget.searchDTO.anyDiseases == true),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "No", onChange: (value) => setState(() => widget.searchDTO.anyDiseases = false), value: widget.searchDTO.anyDiseases == false),
              ],
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Blood Pressure",
            child: Column(
              children: [
                CIA_CheckBoxWidget(
                    text: "All",
                    onChange: (value) {
                      setState(() {
                        widget.searchDTO.bloodPressureCategories = null;
                      });
                    },
                    value: (widget.searchDTO.bloodPressureCategories??[]).isEmpty),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Normal",
                    onChange: (value) {
                      if (widget.searchDTO.bloodPressureCategories == null) widget.searchDTO.bloodPressureCategories = [];
                      if (value && !widget.searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.Normal))
                        widget.searchDTO.bloodPressureCategories!.add(BloodPressureEnum.Normal);
                      else
                        widget.searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.Normal);
                      setState(() {});
                    },
                    value: (widget.searchDTO.bloodPressureCategories??[]).contains(BloodPressureEnum.Normal)),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Hypertensive Controlled",
                    onChange: (value) {
                      if (widget.searchDTO.bloodPressureCategories == null) widget.searchDTO.bloodPressureCategories = [];
                      if (value && !widget.searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypertensiveControlled))
                        widget.searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypertensiveControlled);
                      else
                        widget.searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypertensiveControlled);
                      setState(() {});
                    },
                    value: (widget.searchDTO.bloodPressureCategories??[]).contains(BloodPressureEnum.HypertensiveControlled)),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Hypertensive Uncontrolled",
                    onChange: (value) {
                      if (widget.searchDTO.bloodPressureCategories == null) widget.searchDTO.bloodPressureCategories = [];
                      if (value && !widget.searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypertensiveUncontrolled))
                        widget.searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypertensiveUncontrolled);
                      else
                        widget.searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypertensiveUncontrolled);
                      setState(() {});
                    },
                    value:  (widget.searchDTO.bloodPressureCategories??[]).contains(BloodPressureEnum.HypertensiveUncontrolled)),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Hypotensive Controlled",
                    onChange: (value) {
                      if (widget.searchDTO.bloodPressureCategories == null) widget.searchDTO.bloodPressureCategories = [];
                      if (value && !widget.searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypotensiveControlled))
                        widget.searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypotensiveControlled);
                      else
                        widget.searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypotensiveControlled);
                      setState(() {});
                    },
                    value:  (widget.searchDTO.bloodPressureCategories??[]).contains(BloodPressureEnum.HypotensiveControlled)),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Hypotensive Uncontrolled",
                    onChange: (value) {
                      if (widget.searchDTO.bloodPressureCategories == null) widget.searchDTO.bloodPressureCategories = [];
                      if (value && !widget.searchDTO.bloodPressureCategories!.contains(BloodPressureEnum.HypotensiveUncontrolled))
                        widget.searchDTO.bloodPressureCategories!.add(BloodPressureEnum.HypotensiveUncontrolled);
                      else
                        widget.searchDTO.bloodPressureCategories!.remove(BloodPressureEnum.HypotensiveUncontrolled);
                      setState(() {});
                    },
                    value:  (widget.searchDTO.bloodPressureCategories??[]).contains(BloodPressureEnum.HypotensiveUncontrolled)),
              ],
            ),

          ),
          AdvancedSearchFilterChildWidget(
            title: "Diabetes",
            child: Column(
              children: [
                CIA_CheckBoxWidget(
                    text: "All",
                    onChange: (value) {
                      setState(() {
                        widget.searchDTO.diabetesCategories = null;
                      });
                    },
                    value: (widget.searchDTO.diabetesCategories??[]).isEmpty),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Non Diabetic",
                    onChange: (value) {
                      if (widget.searchDTO.diabetesCategories == null) widget.searchDTO.diabetesCategories = [];
                      if (value && !widget.searchDTO.diabetesCategories!.contains(DiabetesEnum.Normal))
                        widget.searchDTO.diabetesCategories!.add(DiabetesEnum.Normal);
                      else
                        widget.searchDTO.diabetesCategories!.remove(DiabetesEnum.Normal);
                      setState(() {});
                    },
                    value: (widget.searchDTO.diabetesCategories??[]).contains(DiabetesEnum.Normal)),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Hypertensive Controlled",
                    onChange: (value) {
                      if (widget.searchDTO.diabetesCategories == null) widget.searchDTO.diabetesCategories = [];
                      if (value && !widget.searchDTO.diabetesCategories!.contains(DiabetesEnum.DiabeticControlled))
                        widget.searchDTO.diabetesCategories!.add(DiabetesEnum.DiabeticControlled);
                      else
                        widget.searchDTO.diabetesCategories!.remove(DiabetesEnum.DiabeticControlled);
                      setState(() {});
                    },
                    value: (widget.searchDTO.diabetesCategories??[]).contains(DiabetesEnum.DiabeticControlled)),
                SizedBox(height: 10),
                CIA_CheckBoxWidget(
                    text: "Hypertensive Uncontrolled",
                    onChange: (value) {
                      if (widget.searchDTO.diabetesCategories == null) widget.searchDTO.diabetesCategories = [];
                      if (value && !widget.searchDTO.diabetesCategories!.contains(DiabetesEnum.DiabeticUncontrolled))
                        widget.searchDTO.diabetesCategories!.add(DiabetesEnum.DiabeticUncontrolled);
                      else
                        widget.searchDTO.diabetesCategories!.remove(DiabetesEnum.DiabeticUncontrolled);
                      setState(() {});
                    },
                    value:  (widget.searchDTO.diabetesCategories??[]).contains(DiabetesEnum.DiabeticUncontrolled)),

              ],
            ),

          ),
          AdvancedSearchFilterChildWidget(
            title: "Last HAB1C",
            child: Row(
              children: [
                Expanded(
                  child: CIA_TextFormField(
                    label: "From",
                    controller: TextEditingController(text: (widget.searchDTO.lastHAB1cFrom ?? "").toString()),
                    isNumber: true,
                    onChange: (v) {
                      if (v == null || v == "" || v == "0")
                        widget.searchDTO.lastHAB1cFrom = null;
                      else
                        widget.searchDTO.lastHAB1cFrom = int.parse(v);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CIA_TextFormField(
                    label: "To",
                    controller: TextEditingController(text: (widget.searchDTO.lastHAB1cTo ?? "").toString()),
                    isNumber: true,
                    onChange: (v) {
                      if (v == null || v == "" || v == "0")
                        widget.searchDTO.lastHAB1cTo = null;
                      else
                        widget.searchDTO.lastHAB1cTo = int.parse(v);
                    },
                  ),
                ),
              ],
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Illegal Drugs",
            child: Row(
              children: [
                CIA_CheckBoxWidget(
                    text: "All", onChange: (value) => setState(() => widget.searchDTO.illegalDrugs = null), value: widget.searchDTO.illegalDrugs == null),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "Yes", onChange: (value) => setState(() => widget.searchDTO.illegalDrugs = true), value: widget.searchDTO.illegalDrugs == true),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "No", onChange: (value) => setState(() => widget.searchDTO.illegalDrugs = false), value: widget.searchDTO.illegalDrugs == false),
              ],
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Pregnancy",
            child: CIA_DropDownSearchBasicIdName(
              items: [
                BasicNameIdObjectEntity(name: "All"),
                BasicNameIdObjectEntity(name: "None", id: 0),
                BasicNameIdObjectEntity(name: "Pregnant", id: 1),
                BasicNameIdObjectEntity(name: "Lactating", id: 2),
              ],
              selectedItem: BasicNameIdObjectEntity(name: widget.searchDTO.pregnancy?.name ?? "All", id: widget.searchDTO.pregnancy?.index),
              onSelect: (value) {
                widget.searchDTO.pregnancy = PregnancyEnum.values.firstWhereOrNull((element) => element.index == value.id);
              },
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Chewing Sensitivity",
            child: Row(
              children: [
                CIA_CheckBoxWidget(text: "All", onChange: (value) => setState(() => widget.searchDTO.chewing = null), value: widget.searchDTO.chewing == null),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(text: "Yes", onChange: (value) => setState(() => widget.searchDTO.chewing = true), value: widget.searchDTO.chewing == true),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(text: "No", onChange: (value) => setState(() => widget.searchDTO.chewing = false), value: widget.searchDTO.chewing == false),
              ],
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Smoking",
            child: CIA_DropDownSearchBasicIdName(
              items: [
                BasicNameIdObjectEntity(name: "All"),
                BasicNameIdObjectEntity(name: "None", id: 0),
                BasicNameIdObjectEntity(name: "Light Smoker", id: 1),
                BasicNameIdObjectEntity(name: "Medium Smoker", id: 2),
                BasicNameIdObjectEntity(name: "Heavy Smoker", id: 3),
              ],
              selectedItem: BasicNameIdObjectEntity(name: widget.searchDTO.smokingStatus?.name ?? "All", id: widget.searchDTO.smokingStatus?.index),
              onSelect: (value) {
                widget.searchDTO.smokingStatus = SmokingStatus.values.firstWhereOrNull((element) => element.index == value.id);
              },
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Cooperation Level",
            child: CIA_DropDownSearchBasicIdName(
              items: [
                BasicNameIdObjectEntity(name: "All"),
                BasicNameIdObjectEntity(name: "Bad Cooperation", id: 0),
                BasicNameIdObjectEntity(name: "Fair Cooperation", id: 1),
                BasicNameIdObjectEntity(name: "Good Cooperation", id: 2),
                BasicNameIdObjectEntity(name: "Excellent Cooperation", id: 3),
              ],
              selectedItem: BasicNameIdObjectEntity(name: widget.searchDTO.cooperationScore?.name ?? "All", id: widget.searchDTO.cooperationScore?.index),
              onSelect: (value) {
                widget.searchDTO.cooperationScore = EnumCooperationScore.values.firstWhereOrNull((element) => element.index == value.id);
              },
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Oral Hygiene",
            child: CIA_DropDownSearchBasicIdName(
              items: [
                BasicNameIdObjectEntity(name: "All"),
                BasicNameIdObjectEntity(name: "Bad", id: 0),
                BasicNameIdObjectEntity(name: "Fair", id: 1),
                BasicNameIdObjectEntity(name: "Good", id: 2),
                BasicNameIdObjectEntity(name: "Excellent", id: 3),
              ],
              selectedItem: BasicNameIdObjectEntity(name: widget.searchDTO.oralHygieneRating?.name ?? "All", id: widget.searchDTO.oralHygieneRating?.index),
              onSelect: (value) {
                widget.searchDTO.oralHygieneRating = EnumOralHygieneRating.values.firstWhereOrNull((element) => element.index == value.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
