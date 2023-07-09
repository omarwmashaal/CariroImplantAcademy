import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class BasicNameIdObjectModel extends BasicNameIdObjectEntity {
  BasicNameIdObjectModel({
    required name,
    required id,
  }) : super(name: name, id: id);

  factory BasicNameIdObjectModel.fromJson(Map<String, dynamic> map) {
    return BasicNameIdObjectModel(
      name: map['name'] as String,
      id: map['id'] as int,
    );
  }
}
