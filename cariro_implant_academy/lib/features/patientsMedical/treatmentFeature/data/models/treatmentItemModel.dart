import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';

class TreatmentItemModel extends TreatmentItemEntity {
  TreatmentItemModel({
    super.id,
    super.name,
    super.price,
    super.priceAction,
    super.website,
    super.allowAssign,
    super.showInSurgical,
  });

  factory TreatmentItemModel.fromJson(Map<String, dynamic> data) {
    return TreatmentItemModel(
      id: data['id'],
      name: data['name'],
      price: data['price'],
      priceAction: data['priceAction'],
      website: Website.values[data['website']],
      allowAssign: data['allowAssign'],
      showInSurgical: data['showInSurgical'],
    );
  }

  factory TreatmentItemModel.fromEntity(TreatmentItemEntity entity) {
    return TreatmentItemModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      priceAction: entity.priceAction,
      website: entity.website,
      allowAssign: entity.allowAssign,
      showInSurgical: entity.showInSurgical,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['website'] = this.website.index;
    data['allowAssign'] = this.allowAssign;
    data['showInSurgical'] = this.showInSurgical;
    return data;
  }
}
