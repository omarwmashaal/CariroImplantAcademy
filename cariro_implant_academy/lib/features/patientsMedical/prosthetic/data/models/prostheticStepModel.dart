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
    super.date,
    super.index,
    super.itemId,
    super.item,
    super.statusId,
    super.status,
    super.nextVisitId,
    super.nextVisit,
    super.teeth,
    super.tryInCheckListId,
    super.single = false,
    super.bridge = false,
    super.fullArchUpper = false,
    super.fullArchLower = false,
    super.cementRetained,
    super.screwRetained,
    super.material,
    super.materialId,
    super.technique,
    super.techniqueId,
  });
  ProstheticStepModel.fromEntity(ProstheticStepEntity entity) {
    id = entity.id;
    patientId = entity.patientId;
    patient = entity.patient;
    operatorId = entity.operatorId;
    operator = entity.operator;
    needsRemake = entity.needsRemake;
    scanned = entity.scanned;
    date = entity.date;
    index = entity.index;
    itemId = entity.itemId;
    item = entity.item;
    statusId = entity.statusId;
    status = entity.status;
    nextVisitId = entity.nextVisitId;
    nextVisit = entity.nextVisit;
    teeth = entity.teeth;
    single = entity.single;
    bridge = entity.bridge;
    fullArchUpper = entity.fullArchUpper;
    fullArchLower = entity.fullArchLower;
    tryInCheckListId = entity.tryInCheckListId;
    cementRetained = entity.cementRetained;
    screwRetained = entity.screwRetained;
    material = entity.material;
    materialId = entity.materialId;
    technique = entity.technique;
    techniqueId = entity.techniqueId;
  }

  ProstheticStepModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    patientId = data['patientId'];
    patient = data['patient'] == null ? null : BasicNameIdObjectModel.fromJson(data['patient']);
    operatorId = data['operatorId'];
    operator = data['operator'] == null ? null : BasicNameIdObjectModel.fromJson(data['operator']);
    needsRemake = data['needsRemake'] ?? false;
    scanned = data['scanned'] ?? false;
    date = DateTime.tryParse(data['date'] ?? "")?.toLocal();
    index = data['index'];
    teeth = ((data['teeth'] ?? []) as List<dynamic>).map((e) => e as int).toList();
    single = data['single'] ?? false;
    bridge = data['bridge'] ?? false;
    fullArchUpper = data['fullArchUpper'] ?? false;
    fullArchLower = data['fullArchLower'] ?? false;
    tryInCheckListId = data['tryInCheckListId'];
    cementRetained = data['cementRetained'] ?? false;
    screwRetained = data['screwRetained'] ?? false;

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

    if (data['diagnosticMaterialItemId'] != null) {
      materialId = data['diagnosticMaterialItemId'];
    } else if (data['finalMaterialItemId'] != null) {
      materialId = data['finalMaterialItemId'];
    }

    if (data['diagnosticTechniqueItemId'] != null) {
      techniqueId = data['diagnosticTechniqueItemId'];
    } else if (data['finalTechniqueItemId'] != null) {
      techniqueId = data['finalTechniqueItemId'];
    }

    if (data['diagnosticMaterialItem'] != null) {
      material = data['diagnosticMaterialItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['diagnosticMaterialItem']);
    } else if (data['finalMaterialItem'] != null) {
      material = data['finalMaterialItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['finalMaterialItem']);
    }

    if (data['diagnosticTechniqueItem'] != null) {
      technique = data['diagnosticTechniqueItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['diagnosticTechniqueItem']);
    } else if (data['finalTechniqueItem'] != null) {
      technique = data['finalTechniqueItem'] == null ? null : BasicNameIdObjectModel.fromJson(data['finalTechniqueItem']);
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
    data['date'] = date?.toUtc()?.toIso8601String();
    data['index'] = index;
    data['teeth'] = teeth;
    data['single'] = single;
    data['bridge'] = bridge;
    data['fullArchUpper'] = fullArchUpper;
    data['fullArchLower'] = fullArchLower;
    data['diagnosticItemId'] = itemId;
    data['finalItemId'] = itemId;
    data['diagnosticStatusItemId'] = statusId;
    data['finalStatusItemId'] = statusId;
    data['diagnosticTechniqueItemId'] = techniqueId;
    data['finalTechniqueItemId'] = techniqueId;
    data['finalMaterialItemId'] = materialId;
    data['diagnosticMaterialItemId'] = materialId;
    data['diagnosticNextVisitItemId'] = nextVisitId;
    data['finalNextVisitItemId'] = nextVisitId;
    data['tryInCheckListId'] = tryInCheckListId;
    data['screwRetained'] = screwRetained;
    data['cementRetained'] = cementRetained;

    return data;
  }
}
