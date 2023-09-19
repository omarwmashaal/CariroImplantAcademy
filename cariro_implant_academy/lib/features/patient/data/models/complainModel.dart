import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';

import '../../../../core/constants/enums/enums.dart';

class ComplainModel extends ComplainsEntity {
  ComplainModel(
      {super.id,
      super.comment,
      super.patientID,
      super.patient,
      super.lastDoctorId,
      super.lastDoctor,
      super.lastSupervisorId,
      super.notes,
      super.lastSupervisor,
      super.lastCandidateId,
      super.lastCandidate,
      super.mentionedDoctorId,
      super.mentionedDoctor,
      super.entryById,
      super.entryBy,
      super.entryTime});

  factory ComplainModel.fromEntity(ComplainsEntity entity){
    return ComplainModel(
        id:entity.id,
        comment:entity.comment,
        patientID:entity.patientID,
        patient:entity.patient,
        lastDoctorId:entity.lastDoctorId,
        lastDoctor:entity.lastDoctor,
        lastSupervisorId:entity.lastSupervisorId,
        notes:entity.notes,
        lastSupervisor:entity.lastSupervisor,
        lastCandidateId:entity.lastCandidateId,
        lastCandidate:entity.lastCandidate,
        mentionedDoctorId:entity.mentionedDoctorId,
        mentionedDoctor:entity.mentionedDoctor,
        entryById:entity.entryById,
        entryBy:entity.entryBy,
        entryTime:entity.entryTime, 
    );
  }
  ComplainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    notes = json['queueNotes'] ?? "";
    status = json['status'] == null ? EnumComplainStatus.Untouched : EnumComplainStatus.values[json['status']];
    patientID = json['patientID'];
    patient = BasicNameIdObjectModel.fromJson((json['patient'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    lastDoctorId = json['lastDoctorId'];
    lastDoctor = BasicNameIdObjectModel.fromJson((json['lastDoctor'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    lastSupervisorId = json['lastSupervisorId'];
    lastSupervisor = BasicNameIdObjectModel.fromJson((json['lastSupervisor'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    lastCandidateId = json['lastCandidateId'];
    lastCandidate = BasicNameIdObjectModel.fromJson((json['lastCandidate'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    mentionedDoctorId = json['mentionedDoctorId'];
    mentionedDoctor = BasicNameIdObjectModel.fromJson((json['mentionedDoctor'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    entryById = json['entryById'];
    entryBy = BasicNameIdObjectModel.fromJson((json['entryBy'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    resolvedById = json['resolvedById'];
    resolvedBy = BasicNameIdObjectModel.fromJson((json['resolvedBy'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    entryTime = DateTime.tryParse(json['entryTime']??"");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['patientID'] = this.patientID;
    data['mentionedDoctorId'] = this.mentionedDoctorId;
    return data;
  }

}
