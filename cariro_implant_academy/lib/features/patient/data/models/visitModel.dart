import 'package:cariro_implant_academy/features/patient/data/models/roomModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';

import '../../../../Helpers/CIA_DateConverters.dart';

class VisitModel extends VisitEntity {
  VisitModel({
    id,
    secondaryId,
    from,
    title,
    to,
    roomId,
    status,
    changeRequestId,
    reservationTime,
    realVisitTime,
    entersClinicTime,
    leaveTime,
    doctorName,
    doctorId,
    patientId,
    room,
    changeRequest,
    patientName,
  }) : super(
          id: id,
          secondaryId: secondaryId,
          from: from,
          title: title,
          to: to,
          roomId: roomId,
          changeRequestId: changeRequestId,
          status: status,
          reservationTime: reservationTime,
          realVisitTime: realVisitTime,
          entersClinicTime: entersClinicTime,
          leaveTime: leaveTime,
          doctorName: doctorName,
          doctorId: doctorId,
          patientId: patientId,
          room: room,
          changeRequest: changeRequest,
          patientName: patientName,
        );

  VisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    secondaryId = json['secondaryId'];
    status = json['status'];
    changeRequestId = json['visitsLogIdUpdateRequestId'];
    treatment = json['treatment'];
    reservationTime = DateTime.tryParse(json['reservationTime'] ?? "")?.toLocal();
    realVisitTime = DateTime.tryParse(json['realVisitTime'] ?? "")?.toLocal();
    entersClinicTime = DateTime.tryParse(json['entersClinicTime'] ?? "")?.toLocal();
    leaveTime = DateTime.tryParse(json['leaveTime'] ?? "")?.toLocal();
    doctorName = json['doctorName'];
    doctorId = json['doctorId'];
    from = DateTime.tryParse(json['from'] ?? "")?.toLocal();
    to = DateTime.tryParse(json['to'] ?? "")?.toLocal();
    title = json['title'];
    roomId = json['roomId'];
    patientId = json['patientID'] ?? 0;
    patientName = json['patientName'] ?? "";
    duration = CIA_DateConverters.fromBackendToTimeSpan(json['duration']) ?? "";
    room = json['room'] != null ? RoomModel.fromJson(json['room'] as Map<String, dynamic>) : RoomModel();
    changeRequest = json['changeRequest'] != null ? VisitModel.fromJson(json['changeRequest'] as Map<String, dynamic>) : VisitModel();
  }

  factory VisitModel.fromEntity(VisitEntity entity) {
    return VisitModel(
      id: entity.id,
      from: entity.from,
      title: entity.title,
      changeRequestId: entity.changeRequestId,
      to: entity.to,
      roomId: entity.roomId,
      status: entity.status,
      reservationTime: entity.reservationTime,
      realVisitTime: entity.realVisitTime,
      entersClinicTime: entity.entersClinicTime,
      leaveTime: entity.leaveTime,
      doctorName: entity.doctorName,
      doctorId: entity.doctorId,
      patientId: entity.patientId,
      room: entity.room,
      patientName: entity.patientName,
      changeRequest: entity.changeRequest,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['visitsLogIdUpdateRequestId'] = changeRequestId;
    data['changeRequest'] = this.changeRequest == null ? null : VisitModel.fromEntity(this.changeRequest!).toJson();
    data['reservationTime'] = reservationTime == null ? null : reservationTime!.toUtc().toIso8601String();
    data['realVisitTime'] = realVisitTime == null ? null : realVisitTime!.toUtc().toIso8601String();
    data['entersClinicTime'] = entersClinicTime == null ? null : entersClinicTime!.toUtc().toIso8601String();
    data['leaveTime'] = leaveTime == null ? null : leaveTime!.toUtc().toIso8601String();
    data['doctorName'] = doctorName;
    data['doctorId'] = doctorId;
    data['roomId'] = roomId;
    data['from'] = from == null ? null : from!.toUtc().toIso8601String();
    data['to'] = to == null ? null : to!.toUtc().toIso8601String();
    data['title'] = title;
    data['patientId'] = patientId;
    return data;
  }
}
