import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class LabItemParentEntity extends BasicNameIdObjectEntity {
  bool? hasCompanies;
  bool? hasShades;
  bool? hasSize;
  bool? hasCode;
  bool? isStock;
  LabItemParentEntity({
    this.hasCode = true,
    this.hasCompanies = true,
    this.hasShades = true,
    this.hasSize = true,
    this.isStock = true,
    super.id,
    super.name,
  });

  @override
  List<Object?> get props => [];
}
