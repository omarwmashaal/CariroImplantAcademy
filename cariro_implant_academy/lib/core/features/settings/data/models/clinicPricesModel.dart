import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';

class ClinicPricesModel extends ClinicPriceEntity {
  ClinicPricesModel({
    super.category,
    super.id,
    super.price,
    super.tooth,
  });

  factory ClinicPricesModel.fromJson(Map<String,dynamic> json)
  {
    return ClinicPricesModel(
      id: json['id'],
      tooth: json['tooth'],
      category: json['category']==null?null:EnumClinicPrices.values[json['category']],
      price: json['price']
    );
  }
  factory ClinicPricesModel.fromEntity(ClinicPriceEntity entity)
  {
    return ClinicPricesModel(
      price: entity.price,
      category: entity.category,
      tooth: entity.tooth,
      id: entity.id,
    );
  }

  Map<String,dynamic> toJson()
  {
    Map<String,dynamic> data = Map<String,dynamic>();

    data['id'] = this.id;
    data['tooth'] = this.tooth;
    data['price'] = this.price;
    data['category'] = this.category?.index;
    return data;
  }
}
