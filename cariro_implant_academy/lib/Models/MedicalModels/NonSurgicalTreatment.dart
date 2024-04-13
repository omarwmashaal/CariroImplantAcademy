import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/TempPatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Helpers/CIA_DateConverters.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../DTOs/DropDownDTO.dart';

class NonSurgicalTreatmentModelsssss {
  int? id;
  String? treatment;
  int? supervisorID;
  DropDownDTO? supervisor;
  int? operatorID;
  DropDownDTO? operator;
  String? date;
  String? nextVisit;

  NonSurgicalTreatmentModelsssss({this.id,this.treatment, this.supervisorID, this.supervisor, this.operator, this.operatorID, this.date, this.nextVisit});

  NonSurgicalTreatmentModelsssss.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment'];
    id = json['id'];
    supervisorID = json['supervisorID'];
    supervisor = DropDownDTO.fromJson(json['supervisor'] ?? Map<String, dynamic>());
    operatorID = json['operatorID'];
    operator = DropDownDTO.fromJson(json['operator'] ?? Map<String, dynamic>());
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    nextVisit = CIA_DateConverters.fromBackendToDateTime(json['nextVisit']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['treatment'] = this.treatment;
    data['supervisorID'] = this.supervisorID;
    data['operatorID'] = this.operatorID;
    data['nextVisit'] = CIA_DateConverters.fromDateTimeToBackend(nextVisit);
    return data;
  }

  Compare(NonSurgicalTreatmentModelsssss model) {
    return this.toJson() == model.toJson();
  }

  static List<String> columns = [
    "Date",
    "Treatment",
    "Operator",
    "Supervisor",
    "Next Visit",
  ];
}

