import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';

class BloodPressureEntity extends Equatable {
  String? lastReading;
  DateTime? when;
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
