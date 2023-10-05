import 'dart:ui';

import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewTask.dart';

import '../Helpers/Router.dart';
import '../features/patient/presentation/presentation/patientProfileComplainsPage.dart';
import '../features/patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';
import 'Enum.dart';

class NotificationModel {
  int? id;
  String? title;
  String? content;
  bool? read;
  String? date;
  int? infoId;
  EnumNotificationType? type;
  String Function()? onClickAction;

  NotificationModel({this.title, this.content, this.id, this.read = false, this.date = ""});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? "";
    content = json['content'] ?? "";
    read = json['read'] ?? false;
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    infoId = json['infoId'];
    type = json['type'] == null ? null : EnumNotificationType.values[json['type']];
    if (type == EnumNotificationType.Patient) onClickAction = () => CIA_Router.routeConst_PatientInfo;
    else if (type == EnumNotificationType.TreatmentPlan) onClickAction = () => TreatmentPage.routeName;
    else if (type == EnumNotificationType.Complains) onClickAction = () => PatientProfileComplainsPage.routeName;
    else if (type == EnumNotificationType.LabRequest) onClickAction = () => CIA_Router.routeConst_LabView;
  }
}
