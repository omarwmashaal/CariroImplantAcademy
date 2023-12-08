import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class ClinicReceiptEntity extends Equatable {
  int? id;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  List<BasicNameIdObjectEntity>? prices;
  int? total;
  bool? paid;

  ClinicReceiptEntity({
    this.id,
    this.patientId,
    this.patient,
    this.prices,
    this.total,
    this.paid,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.id,
        this.patientId,
        this.patient,
        this.prices,
        this.total,
        this.paid,
      ];

}
