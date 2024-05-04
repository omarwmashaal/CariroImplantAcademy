import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';

class TreatmentItemModel extends TreatmentItemEntity {
  TreatmentItemModel({
    super.id,
    super.name,
    super.price,
    super.priceAction,
  });

  factory TreatmentItemModel.fromJson(Map<String, dynamic> data) {
    return TreatmentItemModel(
      id: data['id'],
      name: data['name'],
      price: data['price'],
      priceAction: data['priceAction'],
    );
  }

  factory TreatmentItemModel.fromEntity(TreatmentItemEntity entity) {
    return TreatmentItemModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      priceAction: entity.priceAction,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['priceAction'] = this.priceAction;
    return data;
  }
}
