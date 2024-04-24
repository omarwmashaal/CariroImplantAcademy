import 'package:equatable/equatable.dart';

import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class ToDoListEntity extends Equatable {
  int? id;
  int? patientId;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  String data;
  bool done;
  DateTime? createDate;
  DateTime? dueDate;
  ToDoListEntity({
    this.patientId,
    this.id,
    this.operatorId,
    this.operator,
    this.data = "",
    this.done =false,
    this.createDate,
    this.dueDate,}
  );

  @override
  List<Object?> get props {
    return [
      id,
      patientId,
      operatorId,
      operator,
      data,
      done,
      createDate,
      dueDate,
    ];
  }
}
