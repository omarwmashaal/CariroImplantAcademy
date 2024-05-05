import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'advancedSearchFilterChildWidgert.dart';

class AdvancedSearchTreatmentFilterWidget extends StatefulWidget {
  AdvancedSearchTreatmentFilterWidget({
    Key? key,
    required this.searchTreatmentsDTO,
    required this.treatmentItems,
  }) : super(key: key);

  AdvancedTreatmentSearchEntity searchTreatmentsDTO;
  List<TreatmentItemEntity> treatmentItems;

  @override
  State<AdvancedSearchTreatmentFilterWidget> createState() => _AdvancedSearchTreatmentFilterWidgetState();
}

class _AdvancedSearchTreatmentFilterWidgetState extends State<AdvancedSearchTreatmentFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionTile(
        title: Text("Treatment Filter"),
        children: [
          AdvancedSearchFilterChildWidget(
            title: "No Treatment Plans Assigned",
            child: Row(
              children: [
                CIA_CheckBoxWidget(
                    text: "Yes",
                    onChange: (value) {
                      if (value == true) {
                        widget.searchTreatmentsDTO.and_treatmentIds!.clear();
                        widget.searchTreatmentsDTO.or_treatmentIds!.clear();                        
                        widget.searchTreatmentsDTO.done = null;
                      } else {
                        widget.searchTreatmentsDTO.done = false;
                      }
                      setState(() => widget.searchTreatmentsDTO.noTreatmentPlan = value == true ? true : null);
                    },
                    value: widget.searchTreatmentsDTO.noTreatmentPlan == true),
              ],
            ),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
              title: "Plan Or Surgery",
              child: Row(
                children: [
                  CIA_CheckBoxWidget(
                      text: "Plan",
                      onChange: (value) => setState(() => widget.searchTreatmentsDTO.done = false),
                      value: widget.searchTreatmentsDTO.done == false),
                  SizedBox(width: 10),
                  CIA_CheckBoxWidget(
                      text: "Surgery",
                      onChange: (value) => setState(() => widget.searchTreatmentsDTO.done = true),
                      value: widget.searchTreatmentsDTO.done == true)
                ],
              ),
            ),
          ),
          AdvancedSearchFilterChildWidget(
            title: "Implant Failed",
            child: Row(
              children: [
                CIA_CheckBoxWidget(
                    text: "All",
                    onChange: (value) => setState(() => widget.searchTreatmentsDTO.implantFailed = null),
                    value: widget.searchTreatmentsDTO.implantFailed == null),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "Yes",
                    onChange: (value) => setState(() => widget.searchTreatmentsDTO.implantFailed = true),
                    value: widget.searchTreatmentsDTO.implantFailed == true),
                SizedBox(width: 10),
                CIA_CheckBoxWidget(
                    text: "No",
                    onChange: (value) => setState(() => widget.searchTreatmentsDTO.implantFailed = false),
                    value: widget.searchTreatmentsDTO.implantFailed == false)
              ],
            ),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
              title: "Teeth",
              child: CIA_DropDownSearchBasicIdName(
                items: [
                  BasicNameIdObjectEntity(
                    name: "All",
                  ),
                  BasicNameIdObjectEntity(name: "Upper Anterior", id: 0),
                  BasicNameIdObjectEntity(name: "Lower Anterior", id: 1),
                  BasicNameIdObjectEntity(name: "Upper Posterior", id: 2),
                  BasicNameIdObjectEntity(name: "Lower Posterior", id: 3),
                ],
                selectedItem: BasicNameIdObjectEntity(
                    name: widget.searchTreatmentsDTO.teethClassification?.name ?? "All", id: widget.searchTreatmentsDTO.teethClassification?.index),
                onSelect: (value) {
                  widget.searchTreatmentsDTO.teethClassification =
                      EnumTeethClassification.values.firstWhereOrNull((element) => element.index == value.id);
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
                title: "Post Surgery Complications (One of the following)",
                child: Column(
                  children: [
                    CIA_CheckBoxWidget(
                      text: "All",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.isNull() ?? true,
                      onChange: (value) {
                        setState(() {
                          widget.searchTreatmentsDTO.complicationsAfterSurgeryOr = null;
                        });
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Swelling",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.swelling == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.swelling = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.swelling = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Open Wound",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.openWound == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.openWound = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.openWound = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Numbness",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.numbness == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.numbness = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.numbness = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Oroantral Communication",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.oroantralCommunication == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.oroantralCommunication = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.oroantralCommunication = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Pus In Implant Site",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.pusInImplantSite == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.pusInImplantSite = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.pusInImplantSite = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Pus In Donor Site",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.pusInDonorSite == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.pusInDonorSite = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.pusInDonorSite = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Sinus Elevation Failure",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.sinusElevationFailure == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.sinusElevationFailure = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.sinusElevationFailure = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "GBR Failure",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.gbrFailure == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgeryOr!.gbrFailure = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgery?.gbrFailure = null;
                        setState(() {});
                      },
                    ),
                  ],
                )),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
                title: "Post Surgery Complications (All of the following)",
                child: Column(
                  children: [
                    CIA_CheckBoxWidget(
                      text: "All",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.isNull() ?? true,
                      onChange: (value) {
                        setState(() {
                          widget.searchTreatmentsDTO.complicationsAfterSurgery = null;
                        });
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Swelling",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.swelling == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.swelling = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.swelling = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Open Wound",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.openWound == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.openWound = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.openWound = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Numbness",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.numbness == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.numbness = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.numbness = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Oroantral Communication",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.oroantralCommunication == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.oroantralCommunication = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.oroantralCommunication = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Pus In Implant Site",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.pusInImplantSite == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.pusInImplantSite = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.pusInImplantSite = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Pus In Donor Site",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.pusInDonorSite == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.pusInDonorSite = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.pusInDonorSite = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Sinus Elevation Failure",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.sinusElevationFailure == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.sinusElevationFailure = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.sinusElevationFailure = null;
                        setState(() {});
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "GBR Failure",
                      value: widget.searchTreatmentsDTO.complicationsAfterSurgery?.gbrFailure == true,
                      onChange: (value) {
                        widget.searchTreatmentsDTO.complicationsAfterSurgery ??= ComplicationsAfterSurgeryEntity();
                        widget.searchTreatmentsDTO.complicationsAfterSurgery!.gbrFailure = value;
                        if (value == true) widget.searchTreatmentsDTO.complicationsAfterSurgeryOr?.gbrFailure = null;
                        setState(() {});
                      },
                    ),
                  ],
                )),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
                title: "Treatment Type (One of the following)",
                child: Column(
                  children: widget.treatmentItems
                      .map(
                        (e) => CIA_CheckBoxWidget(
                          text: e.name!,
                          value: widget.searchTreatmentsDTO.or_treatmentIds!.contains(e.id),
                          onChange: (value) {
                            if (value) {
                              widget.searchTreatmentsDTO.or_treatmentIds!.add(e.id!);
                              widget.searchTreatmentsDTO.and_treatmentIds!.remove(e.id!);
                            } else
                              widget.searchTreatmentsDTO.or_treatmentIds!.remove(e.id!);

                            widget.searchTreatmentsDTO.or_treatmentIds = widget.searchTreatmentsDTO.or_treatmentIds!.toSet().toList();
                            widget.searchTreatmentsDTO.and_treatmentIds = widget.searchTreatmentsDTO.and_treatmentIds!.toSet().toList();
                          },
                        ),
                      )
                      .toList(),
                )),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
                title: "Treatment Type (All of the following)",
                child: Column(
                  children: widget.treatmentItems
                      .map(
                        (e) => CIA_CheckBoxWidget(
                          text: e.name!,
                          value: widget.searchTreatmentsDTO.and_treatmentIds!.contains(e.id),
                          onChange: (value) {
                            if (value) {
                              widget.searchTreatmentsDTO.and_treatmentIds!.add(e.id!);
                              widget.searchTreatmentsDTO.or_treatmentIds!.remove(e.id!);
                            } else
                              widget.searchTreatmentsDTO.and_treatmentIds!.remove(e.id!);

                            widget.searchTreatmentsDTO.or_treatmentIds = widget.searchTreatmentsDTO.or_treatmentIds!.toSet().toList();
                            widget.searchTreatmentsDTO.and_treatmentIds = widget.searchTreatmentsDTO.and_treatmentIds!.toSet().toList();
                          },
                        ),
                      )
                      .toList(),
                )),
          ),
        ],
      ),
    );
  }
}
