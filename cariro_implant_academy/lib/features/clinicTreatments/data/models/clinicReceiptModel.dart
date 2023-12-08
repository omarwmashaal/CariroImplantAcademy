import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicReceiptEntity.dart';

class ClinicReceiptModel extends ClinicReceiptEntity {
  ClinicReceiptModel({
    super.id,
    super.patientId,
    super.patient,
    super.prices,
    super.total,
    super.paid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'patientId': this.patientId,
      'patient': this.patient,
      'prices': this.prices,
      'total': this.total,
      'paid': this.paid,
    };
  }

  factory ClinicReceiptModel.fromMap(Map<String, dynamic> map) {
    return ClinicReceiptModel(
      id: map['id'] as int?,
      patientId: map['patientId'] as int?,
      patient: map['patient'] == null ? null : BasicNameIdObjectModel.fromJson(map['patient']),
      prices: map['prices'] == null
          ? null
          : (map['prices'] as List<dynamic>)
              .map(
                (e) => BasicNameIdObjectModel.fromJson(e),
              )
              .toList(),
      total: map['total'] as int?,
      paid: map['paid'] as bool?,
    );
  }
}
