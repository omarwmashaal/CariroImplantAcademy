import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class MembraneCompanyEntity extends BasicNameIdObjectEntity {


  MembraneCompanyEntity({super.id, super.name = ""});

  @override
  List<Object?> get props => [name, id];
}
