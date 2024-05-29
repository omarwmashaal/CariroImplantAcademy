import 'package:cariro_implant_academy/Models/MedicalModels/ProstheticTreatmentModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchResonseEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/models/complicationsAfterProsthesisModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisDeliveryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisHeallingCollarModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisImporessionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisTryInModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticStepModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';

class AdvancedProstheicSeachResponseModel extends AdvancedProstheticSearchResponseEntity {
  AdvancedProstheicSeachResponseModel({
    super.id,
    super.secondaryId,
    super.patientName,
    super.step,
    super.str_complicationsAfterProsthesis,
  });

  factory AdvancedProstheicSeachResponseModel.fromJson(Map<String, dynamic> data) {
    return AdvancedProstheicSeachResponseModel(
      id: data['id'],
      secondaryId: data['secondaryId'],
      patientName: data['patientName'],
      step: data['finalStep'] == null && data['diagnosticStep'] == null
          ? null
          : ProstheticStepModel.fromJson(data['finalStep'] ?? data['diagnosticStep']),
      str_complicationsAfterProsthesis: data['str_ComplicationsAfterProsthesis'],
    );
  }
}
