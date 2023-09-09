import 'package:equatable/equatable.dart';

class TreatmentPricesEntity extends Equatable {
  int? extraction;
  int? scaling;
  int? crown;
  int? restoration;
  int? rootCanalTreatment;
  int? other;

  TreatmentPricesEntity({
    this.crown = 0,
    this.scaling = 0,
    this.rootCanalTreatment = 0,
    this.restoration = 0,
    this.extraction = 0,
    this.other = 0,
  });



  @override
  // TODO: implement props
  List<Object?> get props => [
        crown,
        scaling,
        rootCanalTreatment,
        restoration,
        extraction,
        other,
      ];
}
