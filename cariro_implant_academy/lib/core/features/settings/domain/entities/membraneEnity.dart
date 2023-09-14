import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class MembraneEntity extends BasicNameIdObjectEntity {
  String? size;

  MembraneEntity({super.id, super.name = "", this.size});

  @override
  List<Object?> get props => [name, id, size];
}
