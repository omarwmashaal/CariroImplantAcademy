import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class LabItemParentEntity extends BasicNameIdObjectEntity {
  int? unitPrice;

  LabItemParentEntity({
    this.unitPrice = 0,
    super.id,
    super.name,
  });

  @override
  List<Object?> get props => super.props..add(this.unitPrice);
}
