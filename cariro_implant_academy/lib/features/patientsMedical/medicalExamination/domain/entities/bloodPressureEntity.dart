import 'package:equatable/equatable.dart';

import '../../../../../Models/Enum.dart';

class BloodPressureEntity extends Equatable {
  String? lastReading;
  String? when;
  String? drug;
  String? readingInClinic;
  BloodPressureEnum? status;

  BloodPressureEntity({
    this.lastReading,
    this.when,
    this.drug,
    this.readingInClinic,
    this.status,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.lastReading,
        this.when,
        this.drug,
        this.readingInClinic,
        this.status,
      ];
}
