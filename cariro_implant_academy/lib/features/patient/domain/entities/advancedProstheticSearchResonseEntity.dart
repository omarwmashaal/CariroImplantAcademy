import 'package:equatable/equatable.dart';

import 'package:cariro_implant_academy/Models/MedicalModels/ProstheticTreatmentModel.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisDeliveryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisHealingCollarEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisTryInEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticFinalEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';

import '../../../patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';

class AdvancedProstheticSearchResponseEntity extends Equatable {
  int? id;
  String? secondaryId;
  String? patientName;
  ProstheticStepEntity ?step;
  String? str_complicationsAfterProsthesis;

  AdvancedProstheticSearchResponseEntity({
    this.id,
    this.secondaryId,
    this.patientName,
    this.step,
    this.str_complicationsAfterProsthesis,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.secondaryId,
        this.patientName,
        this.step,
        this.str_complicationsAfterProsthesis,
      ];
}
