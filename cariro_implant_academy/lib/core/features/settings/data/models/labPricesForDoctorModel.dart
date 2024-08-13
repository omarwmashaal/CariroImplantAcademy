import 'package:cariro_implant_academy/core/features/settings/domain/entities/labPricesForDoctorEntity.dart';

class LabPriceForDoctorModel extends LabPriceForDoctorEntity {
  LabPriceForDoctorModel({
    required super.doctorId,
    required super.optionId,
    required super.price,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data['doctorId'] = this.doctorId;
    data['price'] = this.price;
    data['labOptionId'] = this.optionId;
    return data;
  }

  factory LabPriceForDoctorModel.fromEntity(LabPriceForDoctorEntity entity) {
    return LabPriceForDoctorModel(
      doctorId: entity.doctorId,
      optionId: entity.optionId,
      price: entity.price,
    );
  }
}
