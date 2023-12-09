import 'package:equatable/equatable.dart';

class ToothReceiptEntity extends Equatable {
  int? tooth;
  int? crown;
  int? scaling;
  int? restoration;
  int? rootCanalTreatment;
  int? extraction;
  int? implant;

  ToothReceiptEntity({
    this.extraction = 0,
    this.restoration = 0,
    this.rootCanalTreatment = 0,
    this.scaling = 0,
    this.crown = 0,
    this.implant = 0,
    this.tooth,
  });



  @override
  List<Object?> get props => [
        this.extraction,
        this.restoration,
        this.rootCanalTreatment,
        this.scaling,
        this.implant,
        this.crown,
        this.tooth,
      ];
}
