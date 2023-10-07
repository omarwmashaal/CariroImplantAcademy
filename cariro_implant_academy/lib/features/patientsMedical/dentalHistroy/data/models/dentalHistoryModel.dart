import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';

import '../../../../../core/constants/enums/enums.dart';

class DentalHistoryModel extends DentalHistoryEntity {
  DentalHistoryModel({
    sensitiveHotCold,
    sensitiveSweets,
    bitingChewing,
    clench,
    smoke,
    smokingStatus,
    patientId,
    seriousInjury,
    satisfied,
    cooperationScore,
    willingForImplantScore,
  }) : super(
          bittingCheweing: bitingChewing,
          clench: clench,
          cooperationScore: cooperationScore,
    patientId: patientId,
          satisfied: satisfied,
          senstiveHotCold: sensitiveHotCold,
          senstiveSweets: sensitiveSweets,
          seriousInjury: seriousInjury,
          smoke: smoke,
          smokingStatus: smokingStatus,
          willingForImplantScore: willingForImplantScore,
        );

  factory DentalHistoryModel.fromJson(Map<String, dynamic> json) {
    return DentalHistoryModel(
      sensitiveHotCold: json['senstiveHotCold'] ?? false,
      sensitiveSweets: json['senstiveSweets'] ?? false,
      bitingChewing: json['bittingCheweing'] ?? false,
      clench: json['clench'] ?? "",
      patientId: json['patientId'],
      smoke: json['smoke'] ?? 0,
      smokingStatus: SmokingStatus.values[json['smokingStatus'] ?? 0],
      seriousInjury: json['seriousInjury'] ?? "",
      satisfied: json['satisfied'] ?? "",
      cooperationScore: json['cooperationScore'] ?? 0,
      willingForImplantScore: json['willingForImplantScore'] ?? 0,
    );
  }

  factory DentalHistoryModel.fromEntity(DentalHistoryEntity entity) {
    return DentalHistoryModel(
      bitingChewing: entity.bittingCheweing,
      clench: entity.clench,
      cooperationScore: entity.cooperationScore,
      satisfied: entity.satisfied,
      sensitiveHotCold: entity.senstiveHotCold,
      sensitiveSweets: entity.senstiveSweets,
      patientId: entity.patientId,
      seriousInjury: entity.seriousInjury,
      smoke: entity.smoke,
      smokingStatus: entity.smokingStatus,
      willingForImplantScore: entity.willingForImplantScore,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senstiveHotCold'] = this.senstiveHotCold;
    data['senstiveSweets'] = this.senstiveSweets;
    data['bittingCheweing'] = this.bittingCheweing;
    data['clench'] = this.clench;
    data['smoke'] = this.smoke;
    data['smokingStatus'] = this.smokingStatus!.index;
    data['seriousInjury'] = this.seriousInjury;
    data['patientId'] = this.patientId;
    data['satisfied'] = this.satisfied;
    data['cooperationScore'] = this.cooperationScore;
    data['willingForImplantScore'] = this.willingForImplantScore;
    return data;
  }
}
