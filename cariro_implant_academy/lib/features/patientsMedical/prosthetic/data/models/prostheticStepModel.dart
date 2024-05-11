import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';

class ProstheticStepModel extends ProstheticStepEntity {
  ProstheticStepModel({
    super.id,
    super.patientId,
    super.patient,
    super.operatorId,
    super.operator,
    super.needsRemake,
    super.scanned,
    super.dateTime,
    super.index,
    super.itemId,
    super.item,
    super.statusId,
    super.status,
    super.nextVisitId,
    super.nextVisit,
    super.tooth,
    super.single = false,
    super.bridge = false,
    super.fullArchUpper = false,
    super.fullArchLower = false,
  });
  ProstheticStepModel.fromEntity(ProstheticStepEntity entity) {
    id = entity.id;
    patientId = entity.patientId;
    patient = entity.patient;
    operatorId = entity.operatorId;
    operator = entity.operator;
    needsRemake = entity.needsRemake;
    scanned = entity.scanned;
    dateTime = entity.dateTime;
    index = entity.index;
    itemId = entity.itemId;
    item = entity.item;
    statusId = entity.statusId;
    status = entity.status;
    nextVisitId = entity.nextVisitId;
    nextVisit = entity.nextVisit;
    tooth = entity.tooth;
    single = entity.single;
    bridge = entity.bridge;
    fullArchUpper = entity.fullArchUpper;
    fullArchLower = entity.fullArchLower;
  }

  ProstheticStepModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    patientId = data['patientId'];
    patient = data['patient'] == null ? null : BasicNameIdObjectModel.fromJson(data['patient']);
    operatorId = data['operatorId'];
    operator = data['operator'] == null ? null : BasicNameIdObjectModel.fromJson(data['operator']);
    needsRemake = data['needsRemake'];
    scanned = data['scanned'];
    dateTime = DateTime.tryParse(data['dateTime'] ?? "")?.toLocal();
    index = data['index'];
    tooth = data['tooth'];
    single = data['single'];
    bridge = data['bridge'];
    fullArchUpper = data['fullArchUpper'];
    fullArchLower = data['fullArchLower'];

    if (data['diagnosticItemId'] != null) {
      itemId = data['diagnosticItemId'];
    } else if (data['finalItemId'] != null) {
      itemId = data['finalItemId'];
    }

    if (data['diagnosticStatusItemId'] != null) {
      statusId = data['diagnosticStatusItemId'];
    } else if (data['finalStatusItemId'] != null) {
      statusId = data['finalStatusItemId'];
    }

    if (data['diagnosticNextVisitItemId'] != null) {
      nextVisitId = data['diagnosticNextVisitItemId'];
    } else if (data['finalNextVisitItemId'] != null) {
      nextVisitId = data['finalNextVisitItemId'];
    }

    if (data['diagnosticItem'] != null) {
      item = data['diagnosticItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['diagnosticItem']);
    } else if (data['finalItem'] != null) {
      item = data['finalItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['finalItem']);
    }
    if (data['finalStatusItem'] != null) {
      status = data['finalStatusItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['finalStatusItem']);
    } else if (data['diagnosticStatusItem'] != null) {
      status = data['diagnosticStatusItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['diagnosticStatusItem']);
    }
    if (data['diagnosticNextVisitItem'] != null) {
      nextVisit = data['diagnosticNextVisitItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['diagnosticNextVisitItem']);
    } else if (data['finalNextVisitItem'] != null) {
      nextVisit = data['finalNextVisitItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['finalNextVisitItem']);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data['id'] = id;
    data['patientId'] = patientId;
    data['operatorId'] = operatorId;
    data['needsRemake'] = needsRemake;
    data['scanned'] = scanned;
    data['dateTime'] = dateTime?.toUtc()?.toIso8601String();
    data['index'] = index;
    data['tooth'] = tooth;
    data['single'] = single;
    data['bridge'] = bridge;
    data['fullArchUpper'] = fullArchUpper;
    data['fullArchLower'] = fullArchLower;    
    data['diagnosticItemId'] = itemId;
    data['finalItemId'] = itemId;
    data['diagnosticStatusItemId'] = statusId;
    data['finalStatusItemId'] = statusId;
    data['diagnosticNextVisitItemId'] = nextVisitId;
    data['finalNextVisitItemId'] = nextVisitId;

    return data;
  }
}
