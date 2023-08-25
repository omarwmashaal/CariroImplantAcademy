import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/notificationEntity.dart';

import '../../../Helpers/CIA_DateConverters.dart';
import '../../../Models/Enum.dart';

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
        date: CIA_DateConverters.fromBackendToDateTime(json['date']),
        infoId: json['infoId'],
        type: json['type'] == null ? null : EnumNotificationType.values[json['type']],
        /*onClickAction: () {
          var type = mapToEnum<EnumNotificationType>(EnumNotificationType.values, json['type']);
          if (type == EnumNotificationType.Patient)
            return  CIA_Router.routeConst_PatientInfo;
          else if (type == EnumNotificationType.TreatmentPlan)
            return  PatientTreatmentPlan.routeName;
          else if (type == EnumNotificationType.Complains)
            return  PatientComplains.routeName;
          else if (type == EnumNotificationType.LabRequest) return  CIA_Router.routeConst_LabView;
        }()*/);
  }
}
