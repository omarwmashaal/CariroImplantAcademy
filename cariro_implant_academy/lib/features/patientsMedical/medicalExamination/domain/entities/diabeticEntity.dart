import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';


class DiabeticEntity extends Equatable {
  int? lastReading;
  DateTime? when;
  int? randomInClinic;
  DiabetesEnum? status;
  DiabetesMeasureType? type;

  DiabeticEntity({this.lastReading, this.when, this.randomInClinic, this.status, this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.lastReading,
        this.when,
        this.randomInClinic,
        this.status,
        this.type,
      ];


}
