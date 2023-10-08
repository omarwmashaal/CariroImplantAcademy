import 'package:cariro_implant_academy/features/patient/data/models/roomModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';

import '../../../../Helpers/CIA_DateConverters.dart';

class VisitModel extends VisitEntity {
  VisitModel({
    id,
    from,
    title,
    to,
    roomId,
    status,
    reservationTime,
    realVisitTime,
    entersClinicTime,
    leaveTime,
    doctorName,
    doctorId,
    patientId,
    room,
    patientName,
  }) : super(
          id: id,
          from: from,
          title: title,
          to: to,
          roomId: roomId,
          status: status,
          reservationTime: reservationTime,
          realVisitTime: realVisitTime,
          entersClinicTime: entersClinicTime,
          leaveTime: leaveTime,
          doctorName: doctorName,
          doctorId: doctorId,
          patientId: patientId,
          room: room,
          patientName: patientName,
        );

  VisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    treatment = json['treatment'];
    reservationTime = DateTime.tryParse(json['reservationTime']??"")?.toLocal();
    realVisitTime = DateTime.tryParse(json['realVisitTime']??"")?.toLocal();
    entersClinicTime = DateTime.tryParse(json['entersClinicTime']??"")?.toLocal();
    leaveTime = DateTime.tryParse(json['leaveTime']??"")?.toLocal();
    doctorName = json['doctorName'];
    doctorId = json['doctorId'];
    from = DateTime.tryParse(json['from']??"")?.toLocal();
    to = DateTime.tryParse(json['to']??"")?.toLocal();
    title = json['title'];
    roomId = json['roomId'] ?? 0;
    patientId = json['patientID'] ?? 0;
    patientName = json['patientName'] ?? "";
    duration = CIA_DateConverters.fromBackendToTimeSpan(json['duration']) ?? "";
    room = json['room'] != null ? RoomModel.fromJson(json['room'] as Map<String, dynamic>) : RoomModel();
  }

  factory VisitModel.fromEntity(VisitEntity entity) {
    return VisitModel(
      id: entity.id,
      from: entity.from,
      title: entity.title,
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
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['reservationTime'] = reservationTime==null?null: reservationTime!.toUtc().toIso8601String();
    data['realVisitTime'] = realVisitTime==null?null: realVisitTime!.toUtc().toIso8601String();
    data['entersClinicTime'] = entersClinicTime==null?null: entersClinicTime!.toUtc().toIso8601String();
    data['leaveTime'] = leaveTime==null?null: leaveTime!.toUtc().toIso8601String();
    data['doctorName'] = doctorName;
    data['doctorId'] = doctorId;
    data['roomId'] = roomId;
    data['from'] = from==null?null: from!.toUtc().toIso8601String();
    data['to'] = to==null?null: to!.toUtc().toIso8601String();
    data['title'] = title;
    data['patientId'] = patientId;
    return data;
  }
}
