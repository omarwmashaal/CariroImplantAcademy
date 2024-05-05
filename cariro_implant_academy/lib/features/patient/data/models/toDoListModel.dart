import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';

class ToDoListModel extends ToDoListEntity {
  ToDoListModel({
    super.createDate,
    super.data,
    super.done,
    super.dueDate,
    super.operator,
    super.operatorId,
    super.patientId,
    super.id,
  });

  factory ToDoListModel.fromJson(Map<String, dynamic> data) {
    return ToDoListModel(
        createDate: DateTime.tryParse(data['createDate'] ?? "")?.toLocal(),
        dueDate: DateTime.tryParse(data['dueDate'] ?? "")?.toLocal(),
        data: data['data'],
        done: data['done'],
        operator: data['operator'] == null ? null : BasicNameIdObjectModel.fromJson(data['operator']),
        operatorId: data['operatorId'],
        patientId: data['patientId'],
        id: data['id']);
  }

  factory ToDoListModel.fromEntity(ToDoListEntity entity) {
    return ToDoListModel(
      createDate: entity.createDate,
      dueDate: entity.dueDate,
      data: entity.data,
      done: entity.done,
      operator: entity.operator,
      operatorId: entity.operatorId,
      patientId: entity.patientId,
      id: entity.id,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data;
    data['id'] = this.id;
    data['done'] = this.done;
    data['operatorId'] = this.operatorId;
    data['patientId'] = this.patientId;
    data['dueDate'] = this.dueDate?.toUtc().toIso8601String();
    data['createDate'] = this.createDate?.toUtc().toIso8601String();
    return data;
  }
}
