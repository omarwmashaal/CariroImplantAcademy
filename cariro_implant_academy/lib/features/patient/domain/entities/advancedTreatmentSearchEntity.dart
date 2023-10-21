import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../Models/API_Response.dart';

class AdvancedTreatmentSearchEntity extends Equatable {
  int? id;
  String? patientName;
  bool? done;
  bool? scaling;
  bool? crown;
  bool? rootCanalTreatment;
  bool? restoration;
  bool? pontic;
  bool? extraction;
  bool? simpleImplant;
  bool? immediateImplant;
  bool? expansionWithImplant;
  bool? splittingWithImplant;
  bool? gbrWithImplant;
  bool? openSinusWithImplant;
  bool? closedSinusWithImplant;
  bool? guidedImplant;
  bool? expansionWithoutImplant;
  bool? splittingWithoutImplant;
  bool? gbrWithoutImplant;
  bool? openSinusWithoutImplant;
  bool? closedSinusWithoutImplant;
  bool? noTreatmentPlan;

  String? str_scaling;
  String? str_crown;
  String? str_rootCanalTreatment;
  String? str_restoration;
  String? str_pontic;
  String? str_extraction;
  String? str_simpleImplant;
  String? str_immediateImplant;
  String? str_expansionWithImplant;
  String? str_splittingWithImplant;
  String? str_gbrWithImplant;
  String? str_openSinusWithImplant;
  String? str_closedSinusWithImplant;
  String? str_guidedImplant;
  String? str_expansionWithoutImplant;
  String? str_splittingWithoutImplant;
  String? str_gbrWithoutImplant;
  String? str_openSinusWithoutImplant;
  String? str_closedSinusWithoutImplant;
  EnumTeethClassification? teethClassification;

  AdvancedTreatmentSearchEntity({
    this.id,
    this.patientName,
    this.done,
    this.scaling,
    this.crown,
    this.rootCanalTreatment,
    this.restoration,
    this.pontic,
    this.extraction,
    this.simpleImplant,
    this.immediateImplant,
    this.expansionWithImplant,
    this.splittingWithImplant,
    this.gbrWithImplant,
    this.openSinusWithImplant,
    this.closedSinusWithImplant,
    this.guidedImplant,
    this.expansionWithoutImplant,
    this.splittingWithoutImplant,
    this.gbrWithoutImplant,
    this.openSinusWithoutImplant,
    this.closedSinusWithoutImplant,
    this.noTreatmentPlan,
    this.str_scaling,
    this.str_crown,
    this.str_rootCanalTreatment,
    this.str_restoration,
    this.str_pontic,
    this.str_extraction,
    this.str_simpleImplant,
    this.str_immediateImplant,
    this.str_expansionWithImplant,
    this.str_splittingWithImplant,
    this.str_gbrWithImplant,
    this.str_openSinusWithImplant,
    this.str_closedSinusWithImplant,
    this.str_guidedImplant,
    this.str_expansionWithoutImplant,
    this.str_splittingWithoutImplant,
    this.str_gbrWithoutImplant,
    this.str_openSinusWithoutImplant,
    this.str_closedSinusWithoutImplant,
    this.teethClassification,
  });


  @override
  List<Object?> get props => [this.id,
    this.patientName,
    this.done,
    this.scaling,
    this.crown,
    this.rootCanalTreatment,
    this.restoration,
    this.pontic,
    this.noTreatmentPlan,
    this.extraction,
    this.simpleImplant,
    this.immediateImplant,
    this.expansionWithImplant,
    this.splittingWithImplant,
    this.gbrWithImplant,
    this.openSinusWithImplant,
    this.closedSinusWithImplant,
    this.guidedImplant,
    this.expansionWithoutImplant,
    this.splittingWithoutImplant,
    this.gbrWithoutImplant,
    this.openSinusWithoutImplant,
    this.closedSinusWithoutImplant,
    this.str_scaling,
    this.str_crown,
    this.str_rootCanalTreatment,
    this.str_restoration,
    this.str_pontic,
    this.str_extraction,
    this.str_simpleImplant,
    this.str_immediateImplant,
    this.str_expansionWithImplant,
    this.str_splittingWithImplant,
    this.str_gbrWithImplant,
    this.str_openSinusWithImplant,
    this.str_closedSinusWithImplant,
    this.str_guidedImplant,
    this.str_expansionWithoutImplant,
    this.str_splittingWithoutImplant,
    this.str_gbrWithoutImplant,
    this.str_openSinusWithoutImplant,
    this.str_closedSinusWithoutImplant,
    this.teethClassification,];
}
