import 'dart:ui';

class TreatmentPrices {
  int? extraction;
  int? scaling;
  int? crown;
  int? restoration;
  int? rootCanalTreatment;

  TreatmentPrices({
    this.crown = 0,
    this.scaling = 0,
    this.rootCanalTreatment = 0,
    this.restoration = 0,
    this.extraction = 0,
  });

  TreatmentPrices.fromJson(Map<String, dynamic> json) {
    crown = json['crown'];
    scaling = json['scaling'];
    rootCanalTreatment = json['rootCanalTreatment'];
    restoration = json['restoration'];
    extraction = json['extraction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crown'] = this.crown ?? 0;
    data['scaling'] = this.scaling ?? 0;
    data['rootCanalTreatment'] = this.rootCanalTreatment ?? 0;
    data['restoration'] = this.restoration ?? 0;
    data['extraction'] = this.extraction ?? 0;
    return data;
  }
}
