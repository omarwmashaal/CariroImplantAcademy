class TreatmentPlanModel {
  String tooth = "";
  String? extraction = null;
  String? flap = null;
  String? simpleImplant = null;
  String? immediateImplant = null;
  String? expansion = null;
  String? splitting = null;
  String? gbr = null;
  String? openSinus = null;
  String? closedSinus = null;
  String? guidedImplant = null;
  String? implantDiameter = null;
  String? implantType = null;

  fromJson(Map<String, dynamic> json) {
    extraction = json['extraction'];
    tooth = json['tooth'];
    flap = json['flap'];
    simpleImplant = json['simpleImplant'];
    immediateImplant = json['immediateImplant'];
    expansion = json['expansion'];
    splitting = json['splitting'];
    gbr = json['gbr'];
    openSinus = json['openSinus'];
    closedSinus = json['closedSinus'];
    guidedImplant = json['guidedImplant'];
    implantDiameter = json['implantDiameter'];
    implantType = json['implantType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tooth'] = tooth;
    data['extraction'] = extraction;
    data['flap'] = flap;
    data['simpleImplant'] = simpleImplant;
    data['immediateImplant'] = immediateImplant;
    data['expansion'] = expansion;
    data['splitting'] = splitting;
    data['gbr'] = gbr;
    data['openSinus'] = openSinus;
    data['closedSinus'] = closedSinus;
    data['guidedImplant'] = guidedImplant;
    data['implantDiameter'] = implantDiameter;
    data['implantType'] = implantType;
    return data;
  }
}
