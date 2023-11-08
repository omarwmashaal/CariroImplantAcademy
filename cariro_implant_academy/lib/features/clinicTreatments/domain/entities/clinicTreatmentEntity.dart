import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/scalingEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';
import 'package:equatable/equatable.dart';

import 'clinicImplantEntity.dart';
import 'orthoTreatmentEntity.dart';

class ClinicTreatmentEntity extends Equatable {
  int? patientId;
  List<RestorationEntity>? restorations;
  List<ClinicImplantEntity>? clinicImplants;
  List<OrthoTreatmentEntity>? orthoTreatments;
  List<TMDEntity>? tmds;
  List<PedoEntity>? pedos;
  List<RootCanalTreatmentEntity>? rootCanalTreatments;
  List<ScalingEntity>? scalings;

  ClinicTreatmentEntity({
    this.patientId,
    this.restorations,
    this.clinicImplants,
    this.orthoTreatments,
    this.tmds,
    this.pedos,
    this.rootCanalTreatments,
    this.scalings,
  });

  @override
  List<Object?> get props => [
        this.patientId,
        this.restorations,
        this.clinicImplants,
        this.orthoTreatments,
        this.tmds,
        this.pedos,
        this.rootCanalTreatments,
        this.scalings,
      ];
}
