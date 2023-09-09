import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';

class TreatmentPricesModel extends TreatmentPricesEntity {
  TreatmentPricesModel({
    super.crown,
    super.extraction,
    super.other,
    super.restoration,
    super.rootCanalTreatment,
    super.scaling,
  });

  TreatmentPricesModel.fromJson(Map<String, dynamic> json) {
    crown = json['crown'];
    other = json['other'];
    scaling = json['scaling'];
    rootCanalTreatment = json['rootCanalTreatment'];
    restoration = json['restoration'];
    extraction = json['extraction'];
  }

  factory TreatmentPricesModel.fromEntity(TreatmentPricesEntity entity) {
    return TreatmentPricesModel(
      crown: entity.crown,
      extraction: entity.extraction,
      other: entity.other,
      restoration: entity.restoration,
      rootCanalTreatment: entity.rootCanalTreatment,
      scaling: entity.scaling,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crown'] = this.crown ?? 0;
    data['scaling'] = this.scaling ?? 0;
    data['rootCanalTreatment'] = this.rootCanalTreatment ?? 0;
    data['restoration'] = this.restoration ?? 0;
    data['extraction'] = this.extraction ?? 0;
    data['other'] = this.other ?? 0;
    return data;
  }
}
