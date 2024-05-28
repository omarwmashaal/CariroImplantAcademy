import 'package:cariro_implant_academy/features/patient/data/models/complainModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterProsthesisModel.dart';

class AdvancedProstheicSearchRequestModel extends AdvancedProstheticSearchRequestEntity {
  AdvancedProstheicSearchRequestModel({
    super.ids,
    super.fullArch,
    super.itemId,
    super.nextId,
    super.statusId,
    super.type,
    super.complicationsAnd,
    super.complicationsOr,
    super.cementRetained,
    super.screwRetained,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['ids'] = ids?.map((e) => e as int).toList();
    data['fullArch'] = this.fullArch??false;
    data['itemId'] = this.itemId;
    data['nextId'] = this.nextId;
    data['statusId'] = this.statusId;
    data['cementRetained'] = this.cementRetained??false;
    data['screwRetained'] = this.screwRetained??false;
    data['complicationsAnd'] = this.complicationsAnd==null?null:ComplicationsAfterProsthesisModel.fromEntity(complicationsAnd!).toJson();
    data['complicationsOr'] = this.complicationsOr==null?null:ComplicationsAfterProsthesisModel.fromEntity(complicationsOr!).toJson();
    data['type'] = this.type?.index;
    return data;
  }

  factory AdvancedProstheicSearchRequestModel.fromEntity(AdvancedProstheticSearchRequestEntity entity) {
    return AdvancedProstheicSearchRequestModel(
      fullArch: entity.fullArch,
      itemId: entity.itemId,
      nextId: entity.nextId,
      statusId: entity.statusId,
      type: entity.type,
      ids: entity.ids,
      complicationsAnd: entity.complicationsAnd,
      complicationsOr: entity.complicationsOr,
      cementRetained: entity.cementRetained,
      screwRetained: entity.screwRetained,
    );
  }
}
