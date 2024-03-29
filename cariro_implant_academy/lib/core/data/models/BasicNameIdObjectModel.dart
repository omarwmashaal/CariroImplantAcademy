import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class BasicNameIdObjectModel extends BasicNameIdObjectEntity {
  BasicNameIdObjectModel({
    name="",
     id,
    secondaryId,
  }) : super(name: name, id: id,secondaryId: secondaryId);

  Map<String,dynamic> toJson()
  {
    Map<String,dynamic> data = Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['secondaryId'] = this.secondaryId;
    return data;
  }
  factory BasicNameIdObjectModel.fromJson(Map<String, dynamic> map) {
    print(map['secondaryId']);
    return BasicNameIdObjectModel(
      name: map['name'] as String?,
     // secondaryId:  int.tryParse(map['secondaryId']),
      id: (){
        try{
          return map['id'] as int?;
        }catch(e){
          return map['idInt'] as int?;
        }
      }(),
    );
  }
  factory BasicNameIdObjectModel.fromEntity(BasicNameIdObjectEntity entity) {
    return BasicNameIdObjectModel(
        name:entity. name, id:entity. id,
    );
  }
}
