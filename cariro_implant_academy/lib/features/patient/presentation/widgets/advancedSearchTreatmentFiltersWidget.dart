import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'advancedSearchFilterChildWidgert.dart';

class AdvancedSearchTreatmentFilterWidget extends StatefulWidget {
  AdvancedSearchTreatmentFilterWidget({
    Key? key,
    required this.searchTreatmentsDTO,
  }) : super(key: key);

  AdvancedTreatmentSearchEntity searchTreatmentsDTO;

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
                        widget.searchTreatmentsDTO.scaling = null;
                        widget.searchTreatmentsDTO.crown = null;
                        widget.searchTreatmentsDTO.rootCanalTreatment = null;
                        widget.searchTreatmentsDTO.restoration = null;
                        widget.searchTreatmentsDTO.pontic = null;
                        widget.searchTreatmentsDTO.extraction = null;
                        widget.searchTreatmentsDTO.simpleImplant = null;
                        widget.searchTreatmentsDTO.immediateImplant = null;
                        widget.searchTreatmentsDTO.expansionWithImplant = null;
                        widget.searchTreatmentsDTO.splittingWithImplant = null;
                        widget.searchTreatmentsDTO.gbrWithImplant = null;
                        widget.searchTreatmentsDTO.openSinusWithImplant = null;
                        widget.searchTreatmentsDTO.closedSinusWithImplant = null;
                        widget.searchTreatmentsDTO.guidedImplant = null;
                        widget.searchTreatmentsDTO.expansionWithoutImplant = null;
                        widget.searchTreatmentsDTO.splittingWithoutImplant = null;
                        widget.searchTreatmentsDTO.gbrWithoutImplant = null;
                        widget.searchTreatmentsDTO.openSinusWithoutImplant = null;
                        widget.searchTreatmentsDTO.closedSinusWithoutImplant = null;
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
                  children: [
                    CIA_CheckBoxWidget(
                      text: "Scaling",
                      value: widget.searchTreatmentsDTO.scaling == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.scaling = true;
                          widget.searchTreatmentsDTO.and_scaling = null;
                        } else
                          widget.searchTreatmentsDTO.scaling = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Crown",
                      value: widget.searchTreatmentsDTO.crown == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.crown = true;
                          widget.searchTreatmentsDTO.and_crown = null;
                        } else
                          widget.searchTreatmentsDTO.crown = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Root Canal Treatment",
                      value: widget.searchTreatmentsDTO.rootCanalTreatment == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.rootCanalTreatment = true;
                          widget.searchTreatmentsDTO.and_rootCanalTreatment = null;
                        } else
                          widget.searchTreatmentsDTO.rootCanalTreatment = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Restoration",
                      value: widget.searchTreatmentsDTO.restoration == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.restoration = true;
                          widget.searchTreatmentsDTO.and_restoration = null;
                        } else
                          widget.searchTreatmentsDTO.restoration = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Pontic",
                      value: widget.searchTreatmentsDTO.pontic == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.pontic = true;
                          widget.searchTreatmentsDTO.and_pontic = null;
                        } else
                          widget.searchTreatmentsDTO.pontic = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Extraction",
                      value: widget.searchTreatmentsDTO.extraction == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.extraction = true;
                          widget.searchTreatmentsDTO.and_extraction = null;
                        } else
                          widget.searchTreatmentsDTO.extraction = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Simple Implant",
                      value: widget.searchTreatmentsDTO.simpleImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.simpleImplant = true;
                          widget.searchTreatmentsDTO.and_simpleImplant = null;
                        } else
                          widget.searchTreatmentsDTO.simpleImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Immediate Implant",
                      value: widget.searchTreatmentsDTO.immediateImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.immediateImplant = true;
                          widget.searchTreatmentsDTO.and_immediateImplant = null;
                        } else
                          widget.searchTreatmentsDTO.immediateImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Expansion With Implant",
                      value: widget.searchTreatmentsDTO.expansionWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.expansionWithImplant = true;
                          widget.searchTreatmentsDTO.and_expansionWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.expansionWithImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Splitting With Implant",
                      value: widget.searchTreatmentsDTO.splittingWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.splittingWithImplant = true;
                          widget.searchTreatmentsDTO.and_splittingWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.splittingWithImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "GBR With Implant",
                      value: widget.searchTreatmentsDTO.gbrWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.gbrWithImplant = true;
                          widget.searchTreatmentsDTO.and_gbrWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.gbrWithImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Open Sinus With Implant",
                      value: widget.searchTreatmentsDTO.openSinusWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.openSinusWithImplant = true;
                          widget.searchTreatmentsDTO.and_openSinusWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.openSinusWithImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Closed Sinus With Implant",
                      value: widget.searchTreatmentsDTO.closedSinusWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.closedSinusWithImplant = true;
                          widget.searchTreatmentsDTO.and_closedSinusWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.closedSinusWithImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Guided Implant",
                      value: widget.searchTreatmentsDTO.guidedImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.guidedImplant = true;
                          widget.searchTreatmentsDTO.and_guidedImplant = null;
                        } else
                          widget.searchTreatmentsDTO.guidedImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Expansion Without Implant",
                      value: widget.searchTreatmentsDTO.expansionWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.expansionWithoutImplant = true;
                          widget.searchTreatmentsDTO.and_expansionWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.expansionWithoutImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Splitting Without Implant",
                      value: widget.searchTreatmentsDTO.splittingWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.splittingWithoutImplant = true;
                          widget.searchTreatmentsDTO.and_splittingWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.splittingWithoutImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "GBR Without Implant",
                      value: widget.searchTreatmentsDTO.gbrWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.gbrWithoutImplant = true;
                          widget.searchTreatmentsDTO.and_gbrWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.gbrWithoutImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Open Sinus Without Implant",
                      value: widget.searchTreatmentsDTO.openSinusWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.openSinusWithoutImplant = true;
                          widget.searchTreatmentsDTO.and_openSinusWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.openSinusWithoutImplant = null;
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Closed Sinus Without Implant",
                      value: widget.searchTreatmentsDTO.closedSinusWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.closedSinusWithoutImplant = true;
                          widget.searchTreatmentsDTO.and_closedSinusWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.closedSinusWithoutImplant = null;
                      },
                    ),
                  ],
                )),
          ),
          Visibility(
            visible: widget.searchTreatmentsDTO.noTreatmentPlan != true,
            child: AdvancedSearchFilterChildWidget(
                title: "Treatment Type (All of the following)",
                child: Column(
                  children: [
                    CIA_CheckBoxWidget(
                      text: "Scaling",
                      value: widget.searchTreatmentsDTO.and_scaling == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_scaling = true;
                          widget.searchTreatmentsDTO.scaling = null;
                        } else
                          widget.searchTreatmentsDTO.and_scaling = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Crown",
                      value: widget.searchTreatmentsDTO.and_crown == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_crown = true;
                          widget.searchTreatmentsDTO.crown = null;
                        } else
                          widget.searchTreatmentsDTO.and_crown = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Root Canal Treatment",
                      value: widget.searchTreatmentsDTO.and_rootCanalTreatment == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_rootCanalTreatment = true;
                          widget.searchTreatmentsDTO.rootCanalTreatment = null;
                        } else
                          widget.searchTreatmentsDTO.and_rootCanalTreatment = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Restoration",
                      value: widget.searchTreatmentsDTO.and_restoration == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_restoration = true;
                          widget.searchTreatmentsDTO.restoration = null;
                        } else
                          widget.searchTreatmentsDTO.and_restoration = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Pontic",
                      value: widget.searchTreatmentsDTO.and_pontic == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_pontic = true;
                          widget.searchTreatmentsDTO.pontic = null;
                        } else
                          widget.searchTreatmentsDTO.and_pontic = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Extraction",
                      value: widget.searchTreatmentsDTO.and_extraction == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_extraction = true;
                          widget.searchTreatmentsDTO.extraction = null;
                        } else
                          widget.searchTreatmentsDTO.and_extraction = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Simple Implant",
                      value: widget.searchTreatmentsDTO.and_simpleImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_simpleImplant = true;
                          widget.searchTreatmentsDTO.simpleImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_simpleImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Immediate Implant",
                      value: widget.searchTreatmentsDTO.and_immediateImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_immediateImplant = true;
                          widget.searchTreatmentsDTO.immediateImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_immediateImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Expansion With Implant",
                      value: widget.searchTreatmentsDTO.and_expansionWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_expansionWithImplant = true;
                          widget.searchTreatmentsDTO.expansionWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_expansionWithImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Splitting With Implant",
                      value: widget.searchTreatmentsDTO.and_splittingWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_splittingWithImplant = true;
                          widget.searchTreatmentsDTO.splittingWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_splittingWithImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "GBR With Implant",
                      value: widget.searchTreatmentsDTO.and_gbrWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_gbrWithImplant = true;
                          widget.searchTreatmentsDTO.gbrWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_gbrWithImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Open Sinus With Implant",
                      value: widget.searchTreatmentsDTO.and_openSinusWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_openSinusWithImplant = true;
                          widget.searchTreatmentsDTO.openSinusWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_openSinusWithImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Closed Sinus With Implant",
                      value: widget.searchTreatmentsDTO.and_closedSinusWithImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_closedSinusWithImplant = true;
                          widget.searchTreatmentsDTO.closedSinusWithImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_closedSinusWithImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Guided Implant",
                      value: widget.searchTreatmentsDTO.and_guidedImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_guidedImplant = true;
                          widget.searchTreatmentsDTO.guidedImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_guidedImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Expansion Without Implant",
                      value: widget.searchTreatmentsDTO.and_expansionWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_expansionWithoutImplant = true;
                          widget.searchTreatmentsDTO.expansionWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_expansionWithoutImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Splitting Without Implant",
                      value: widget.searchTreatmentsDTO.and_splittingWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_splittingWithoutImplant = true;
                          widget.searchTreatmentsDTO.splittingWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_splittingWithoutImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "GBR Without Implant",
                      value: widget.searchTreatmentsDTO.and_gbrWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_gbrWithoutImplant = true;
                          widget.searchTreatmentsDTO.gbrWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_gbrWithoutImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Open Sinus Without Implant",
                      value: widget.searchTreatmentsDTO.and_openSinusWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_openSinusWithoutImplant = true;
                          widget.searchTreatmentsDTO.openSinusWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_openSinusWithoutImplant = null;
                        setState(() => null);
                      },
                    ),
                    CIA_CheckBoxWidget(
                      text: "Closed Sinus Without Implant",
                      value: widget.searchTreatmentsDTO.and_closedSinusWithoutImplant == true,
                      onChange: (value) {
                        if (value) {
                          widget.searchTreatmentsDTO.and_closedSinusWithoutImplant = true;
                          widget.searchTreatmentsDTO.closedSinusWithoutImplant = null;
                        } else
                          widget.searchTreatmentsDTO.and_closedSinusWithoutImplant = null;
                        setState(() => null);
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
