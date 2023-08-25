
import '../../domain/entities/dentalExaminationEntity.dart';

class DentalExaminationModel extends DentalExaminationEntity {
  DentalExaminationModel({
    tooth,
    carious,
    filled,
    missed,
    notSure,
    mobilityI,
    mobilityII,
    mobilityIII,
    hopelessTeeth,
    implantPlaced,
    implantFailed,
    previousState,
  }) : super(
          carious: carious,
          filled: filled,
          hopelessTeeth: hopelessTeeth,
          implantFailed: implantFailed,
          implantPlaced: implantPlaced,
          missed: missed,
          mobilityI: mobilityI,
          mobilityII: mobilityII,
          mobilityIII: mobilityIII,
          notSure: notSure,
          previousState: previousState,
          tooth: tooth,
        );

  Map<String, dynamic> toMap() {
    return {
      'tooth': this.tooth,
      'carious': this.carious,
      'filled': this.filled,
      'missed': this.missed,
      'notSure': this.notSure,
      'mobilityI': this.mobilityI,
      'mobilityII': this.mobilityII,
      'mobilityIII': this.mobilityIII,
      'hopelessteeth': this.hopelessTeeth,
      'implantPlaced': this.implantPlaced,
      'implantFailed': this.implantFailed,
      'previousState': this.previousState,
    };
  }

  factory DentalExaminationModel.fromMap(Map<String, dynamic> map) {
    return DentalExaminationModel(
      tooth: map['tooth'] as int?,
      carious: map['carious'] as bool?,
      filled: map['filled'] as bool?,
      missed: map['missed'] as bool?,
      notSure: map['notSure'] as bool?,
      mobilityI: map['mobilityI'] as bool?,
      mobilityII: map['mobilityII'] as bool?,
      mobilityIII: map['mobilityIII'] as bool?,
      hopelessTeeth: map['hopelessteeth'] as bool?,
      implantPlaced: map['implantPlaced'] as bool?,
      implantFailed: map['implantFailed'] as bool?,
      previousState: map['previousState'] as String?,
    );
  }

  factory DentalExaminationModel.fromEntity(DentalExaminationEntity entity) {
    return DentalExaminationModel(
      carious: entity.carious,
      filled: entity.filled,
      hopelessTeeth: entity.hopelessTeeth,
      implantFailed: entity.implantFailed,
      implantPlaced: entity.implantPlaced,
      missed: entity.missed,
      mobilityI: entity.mobilityI,
      mobilityII: entity.mobilityII,
      mobilityIII: entity.mobilityIII,
      notSure: entity.notSure,
      previousState: entity.previousState,
      tooth: entity.tooth,
    );
  }
}
