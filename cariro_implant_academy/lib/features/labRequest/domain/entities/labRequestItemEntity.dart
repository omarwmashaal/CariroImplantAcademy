import 'package:equatable/equatable.dart';

class LabRequestItemEntity extends Equatable {
  String? name;
  String? description;
  int? number;

  LabRequestItemEntity({
    this.name,
    this.description,
    this.number,
  });

  @override
  List<Object?> get props => [name, description, number];

  bool isNull() => this.description?.isEmpty??true && (this.number==null || this.number==0);
}
