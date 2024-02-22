import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:cariro_implant_academy/features/patient/presentation/widgets/advancedSearchProstheticFiltersWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticTreatmentFinalModel.dart';

import '../../../patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';

enum EnumProstheticSearchType {
  Diagnostic,
  SingleAndBridge,
  FullArch,
}

class AdvancedProstheticSearchRequestEntity extends Equatable {
  List<int>? ids;
  ProstheticTreatmentModel? diagnosticAnd;
  ProstheticTreatmentFinalModel? singleAndBridgeAnd;
  ProstheticTreatmentFinalModel? fullArchAnd;
  ProstheticTreatmentModel? diagnosticOr;
  ProstheticTreatmentFinalModel? singleAndBridgeOr;
  ProstheticTreatmentFinalModel? fullArchOr;
  ComplicationsAfterProsthesisEntity? complicationsAnd;
  ComplicationsAfterProsthesisEntity? complicationsOr;
  EnumProstheticSearchType? searchType;
  EnumProstheticType prostheticType = EnumProstheticType.Diagnostic;

  AdvancedProstheticSearchRequestEntity({
    this.ids,
    this.diagnosticAnd,
    this.singleAndBridgeAnd,
    this.fullArchAnd,
    this.diagnosticOr,
    this.singleAndBridgeOr,
    this.fullArchOr,
    this.complicationsAnd,
    this.complicationsOr,
    this.searchType,
    prostheticType = EnumProstheticType.Diagnostic,
  });

  @override
  List<Object?> get props => [
        ids,
        diagnosticAnd,
        singleAndBridgeAnd,
        fullArchAnd,
        diagnosticOr,
        singleAndBridgeOr,
        fullArchOr,
        complicationsAnd,
        complicationsOr,
        searchType,
      ];

  bool isNull() =>
      (diagnosticAnd?.isNull() ?? true) &&
      (singleAndBridgeAnd?.isNull() ?? true) &&
      (fullArchAnd?.isNull() ?? true) &&
      (diagnosticOr?.isNull() ?? true) &&
      (singleAndBridgeOr?.isNull() ?? true) &&
      (fullArchOr?.isNull() ?? true) &&
      (complicationsAnd?.isNull() ?? true) &&
      (complicationsOr?.isNull() ?? true);

  setNull() {
    diagnosticAnd = null;
    singleAndBridgeAnd = null;
    fullArchAnd = null;
    diagnosticOr = null;
    singleAndBridgeOr = null;
    fullArchOr = null;
    complicationsAnd = null;
    complicationsOr = null;
    searchType = null;
  }

  AdvancedProstheticSearchRequestEntity copyWith({
    ValueGetter<List<int>?>? ids,
    ValueGetter<ProstheticTreatmentModel?>? diagnosticAnd,
    ValueGetter<ProstheticTreatmentFinalModel?>? singleAndBridgeAnd,
    ValueGetter<ProstheticTreatmentFinalModel?>? fullArchAnd,
    ValueGetter<ProstheticTreatmentModel?>? diagnosticOr,
    ValueGetter<ProstheticTreatmentFinalModel?>? singleAndBridgeOr,
    ValueGetter<ProstheticTreatmentFinalModel?>? fullArchOr,
    ValueGetter<ComplicationsAfterProsthesisEntity?>? complicationsAnd,
    ValueGetter<ComplicationsAfterProsthesisEntity?>? complicationsOr,
    ValueGetter<EnumProstheticSearchType?>? searchType,
    EnumProstheticType? prostheticType,
  }) {
    return AdvancedProstheticSearchRequestEntity(
      ids: ids != null ? ids() : this.ids,
      diagnosticAnd: diagnosticAnd != null ? diagnosticAnd() : this.diagnosticAnd,
      singleAndBridgeAnd: singleAndBridgeAnd != null ? singleAndBridgeAnd() : this.singleAndBridgeAnd,
      fullArchAnd: fullArchAnd != null ? fullArchAnd() : this.fullArchAnd,
      diagnosticOr: diagnosticOr != null ? diagnosticOr() : this.diagnosticOr,
      singleAndBridgeOr: singleAndBridgeOr != null ? singleAndBridgeOr() : this.singleAndBridgeOr,
      fullArchOr: fullArchOr != null ? fullArchOr() : this.fullArchOr,
      complicationsAnd: complicationsAnd != null ? complicationsAnd() : this.complicationsAnd,
      complicationsOr: complicationsOr != null ? complicationsOr() : this.complicationsOr,
      searchType: searchType != null ? searchType() : this.searchType,
      prostheticType: prostheticType ?? this.prostheticType,
    );
  }
}
