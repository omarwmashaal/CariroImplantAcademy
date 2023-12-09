import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/entities/notificationEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/createOrViewPatientPage.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/patientProfileComplainsPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';
import '../../../../../Helpers/Router.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../../features/patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({title, content, id, read, date, type, onClickAction, infoId})
      : super(
          id: id,
          date: date,
          read: read,
          title: title,
          content: content,
          type: type,
          onClickAction: onClickAction,
          infoId: infoId,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      read: json['read'] ?? false,
      date: DateTime.tryParse(json['date']??"")?.toLocal(),
      infoId: json['infoId'],
      type: json['type'] == null ? null : EnumNotificationType.values[json['type']],
      onClickAction: (context) {
        var type = mapToEnum<EnumNotificationType>(EnumNotificationType.values, json['type']);
        if (type == EnumNotificationType.Patient)
          GoRouter.of(context).goNamed(CreateOrViewPatientPage.getVisitPatientRouteName(), pathParameters: {'id': json['infoId']?.toString()??""});
        else if (type == EnumNotificationType.TreatmentPlan)
          GoRouter.of( context).goNamed(TreatmentPage.getRouteName(), pathParameters: {'id': json['infoId']?.toString()??""});
        else if (type == EnumNotificationType.Complains)
        GoRouter.of( context).goNamed(PatientProfileComplainsPage.getRouteName(), pathParameters: {'id': json['infoId']?.toString()??""});
        else if (type == EnumNotificationType.LabRequest)
        GoRouter.of( context).goNamed(CIA_Router.routeConst_LabView, pathParameters: {'id': json['infoId']?.toString()??""});
       else if (type == EnumNotificationType.SurgicalTreatment)
        GoRouter.of( context).goNamed(SurgicalTreatmentPage.getRouteName(), pathParameters: {'id': json['infoId']?.toString()??""});
      },
    );
  }
}
