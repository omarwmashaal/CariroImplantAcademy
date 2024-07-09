import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addImplantsUseCase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';

import '../../../patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';

class AdvancedTreatmentSearchEntity extends Equatable {
  List<int>? ids;
  int? id;
  BasicNameIdObjectEntity? candidate;
  BasicNameIdObjectEntity? candidateBatch;
  int? tooth;
  String? secondaryId;
  String? patientName;
  bool? noTreatmentPlan;
  bool? sameTooth;
  bool? clearnaceUpper;
  bool? clearnaceLower;
  bool? done;
  List<int>? and_treatmentIds;
  List<int>? or_treatmentIds;
  bool? implantFailed;
  List<int>? complicationsAfterSurgeryIds;
  List<int>? complicationsAfterSurgeryIdsOr;
  String? str_complicationsAfterSurgery;
  String? str_complicationsAfterProsthesis;

  String? str_implantFailed;
  EnumTeethClassification? teethClassification;
  String? treatmentValue;
  String? treatmentName;
  int? treatmentId;
  BasicNameIdObjectEntity? implantLineId;
  BasicNameIdObjectEntity? implantCompanyId;
  BasicNameIdObjectEntity? implantId;
  String? implantLine;
  String? implant;

  AdvancedTreatmentSearchEntity({
    this.id,
    this.ids,
    this.candidate,
    this.sameTooth,
    this.candidateBatch,
    this.secondaryId,
    this.tooth,
    this.complicationsAfterSurgeryIdsOr,
    this.patientName,
    this.done,
    this.implantFailed,
    this.complicationsAfterSurgeryIds,
    this.noTreatmentPlan,
    this.clearnaceLower = false,
    this.clearnaceUpper = false,
    this.str_complicationsAfterSurgery,
    this.str_complicationsAfterProsthesis,
    this.str_implantFailed,
    this.and_treatmentIds,
    this.or_treatmentIds,
    this.teethClassification,
    this.treatmentName,
    this.treatmentValue,
    this.treatmentId,
    this.implantLineId,
    this.implantId,
    this.implantLine,
    this.implant,
  }) {
    and_treatmentIds = and_treatmentIds ?? [];
    or_treatmentIds = or_treatmentIds ?? [];
  }

  @override
  List<Object?> get props => [
        this.id,
        this.tooth,
        this.complicationsAfterSurgeryIdsOr,
        this.secondaryId,
        this.implantFailed,
        this.complicationsAfterSurgeryIds,
        this.patientName,
        this.done,
        this.ids,
        this.noTreatmentPlan,
        this.teethClassification,
        this.str_implantFailed,
        this.str_complicationsAfterSurgery,
        this.str_complicationsAfterProsthesis,
        this.treatmentName,
        this.treatmentValue,
        this.treatmentId,
      ];

  bool isNull() =>
      noTreatmentPlan == null &&
      implantId == null &&
      implantLineId == null &&
      implantLineId == sameTooth &&
      candidate == null &&
      candidateBatch == null &&
      implantFailed == null &&
      complicationsAfterSurgeryIds == null &&
      complicationsAfterSurgeryIdsOr == null &&
      (and_treatmentIds?.isEmpty ?? true) &&
      (or_treatmentIds?.isEmpty ?? true) &&
      clearnaceLower != true &&
      clearnaceUpper != true;

  // AdvancedTreatmentSearchEntity copyWith({
  //   ValueGetter<List<int>?>? ids,
  //   ValueGetter<int?>? id,
  //   ValueGetter<int?>? tooth,
  //   ValueGetter<String?>? secondaryId,
  //   ValueGetter<String?>? patientName,
  //   ValueGetter<bool?>? noTreatmentPlan,
  //   ValueGetter<bool?>? done,
  //   ValueGetter<bool?>? scaling,
  //   ValueGetter<bool?>? crown,
  //   ValueGetter<bool?>? rootCanalTreatment,
  //   ValueGetter<bool?>? restoration,
  //   ValueGetter<bool?>? pontic,
  //   ValueGetter<bool?>? extraction,
  //   ValueGetter<bool?>? simpleImplant,
  //   ValueGetter<bool?>? immediateImplant,
  //   ValueGetter<bool?>? expansionWithImplant,
  //   ValueGetter<bool?>? splittingWithImplant,
  //   ValueGetter<bool?>? gbrWithImplant,
  //   ValueGetter<bool?>? openSinusWithImplant,
  //   ValueGetter<bool?>? closedSinusWithImplant,
  //   ValueGetter<bool?>? guidedImplant,
  //   ValueGetter<bool?>? expansionWithoutImplant,
  //   ValueGetter<bool?>? splittingWithoutImplant,
  //   ValueGetter<bool?>? gbrWithoutImplant,
  //   ValueGetter<bool?>? openSinusWithoutImplant,
  //   ValueGetter<bool?>? closedSinusWithoutImplant,
  //   ValueGetter<bool?>? implantFailed,
  //   ValueGetter<ComplicationsAfterProsthesisEntity?>? complicationsAfterProsthesis,
  //   ValueGetter<ComplicationsAfterProsthesisEntity?>? complicationsAfterProsthesisOr,
  //   ValueGetter<ComplicationsAfterSurgeryEntity?>? complicationsAfterSurgery,
  //   ValueGetter<ComplicationsAfterSurgeryEntity?>? complicationsAfterSurgeryOr,
  //   ValueGetter<EnumTeethClassification?>? teethClassification,
  // }) {
  //   return AdvancedTreatmentSearchEntity(
  //     ids: ids != null ? ids() : this.ids,
  //     id: id != null ? id() : this.id,
  //     tooth: tooth != null ? tooth() : this.tooth,
  //     secondaryId: secondaryId != null ? secondaryId() : this.secondaryId,
  //     patientName: patientName != null ? patientName() : this.patientName,
  //     noTreatmentPlan: noTreatmentPlan != null ? noTreatmentPlan() : this.noTreatmentPlan,
  //     done: done != null ? done() : this.done,implantFailed: implantFailed != null ? implantFailed() : this.implantFailed,
  //     complicationsAfterSurgery: complicationsAfterSurgery != null ? complicationsAfterSurgery() : this.complicationsAfterSurgery,
  //     complicationsAfterSurgeryOr: complicationsAfterSurgeryOr != null ? complicationsAfterSurgeryOr() : this.complicationsAfterSurgeryOr,
  //     str_complicationsAfterProsthesis:
  //     teethClassification: teethClassification != null ? teethClassification() : this.teethClassification,
  //   );
  // }
}
