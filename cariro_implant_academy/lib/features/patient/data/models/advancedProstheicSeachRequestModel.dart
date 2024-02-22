import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterProsthesisModel.dart';

class AdvancedProstheicSearchRequestModel extends AdvancedProstheticSearchRequestEntity {
  AdvancedProstheicSearchRequestModel({
    super.ids,
    super.diagnosticAnd,
    super.singleAndBridgeAnd,
    super.fullArchAnd,
    super.diagnosticOr,
    super.singleAndBridgeOr,
    super.fullArchOr,
    super.complicationsAnd,
    super.complicationsOr,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['ids'] = ids?.map((e) => e as int).toList();
    data['diagnosticAnd'] = diagnosticAnd?.toJson();
    data['singleAndBridgeAnd'] = singleAndBridgeAnd?.toJson();
    data['fullArchAnd'] = fullArchAnd?.toJson();
    data['diagnosticOr'] = diagnosticOr?.toJson();
    data['singleAndBridgeOr'] = singleAndBridgeOr?.toJson();
    data['fullArchOr'] = fullArchOr?.toJson();
    data['complicationsAnd'] = complicationsAnd == null ? null : ComplicationsAfterProsthesisModel.fromEntity(complicationsAnd!).toJson();
    data['complicationsOr'] = complicationsOr == null ? null : ComplicationsAfterProsthesisModel.fromEntity(complicationsOr!).toJson();

    return data;
  }

  factory AdvancedProstheicSearchRequestModel.fromEntity(AdvancedProstheticSearchRequestEntity entity) {
    return AdvancedProstheicSearchRequestModel(
      complicationsAnd: entity.complicationsAnd,
      complicationsOr: entity.complicationsOr,
      diagnosticAnd: entity.diagnosticAnd,
      diagnosticOr: entity.diagnosticOr,
      fullArchAnd: entity.fullArchAnd,
      fullArchOr: entity.fullArchOr,
      ids: entity.ids,
      singleAndBridgeAnd: entity.singleAndBridgeAnd,
      singleAndBridgeOr: entity.singleAndBridgeOr,
    );
  }
}
