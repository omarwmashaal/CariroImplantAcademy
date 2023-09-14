import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class TacCompanyEntity extends BasicNameIdObjectEntity {
  int? count;

  TacCompanyEntity({super.id, super.name = "", this.count = 0});

  @override
  List<Object?> get props => [name, id, count];
}
