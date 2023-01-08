class TreatmentPlanModel {
  Extraction? extraction;
  Flap? flap;
  SimpleImplant? simpleImplant;
  ImmediateImplant? immediateImplant;
  Expansion? expansion;
  Splitting? splitting;
  Gbr? gbr;
  OpenSinus? openSinus;
  ClosedSinus? closedSinus;
  GuidedImplant? guidedImplant;
  Bontic? bontic;

  TreatmentPlanModel(
      {this.extraction,
      this.flap,
      this.simpleImplant,
      this.immediateImplant,
      this.expansion,
      this.splitting,
      this.gbr,
      this.openSinus,
      this.closedSinus,
      this.guidedImplant,
      this.bontic});

  TreatmentPlanModel.fromJson(Map<String, dynamic> json) {
    extraction = json['extraction'] != null
        ? Extraction?.fromJson(json['extraction'])
        : null;
    flap = json['flap'] != null ? Flap?.fromJson(json['flap']) : null;
    simpleImplant = json['simpleImplant'] != null
        ? SimpleImplant?.fromJson(json['simpleImplant'])
        : null;
    immediateImplant = json['immediateImplant'] != null
        ? ImmediateImplant?.fromJson(json['immediateImplant'])
        : null;
    expansion = json['expansion'] != null
        ? Expansion?.fromJson(json['expansion'])
        : null;
    splitting = json['splitting'] != null
        ? Splitting?.fromJson(json['splitting'])
        : null;
    gbr = json['gbr'] != null ? Gbr?.fromJson(json['gbr']) : null;
    openSinus = json['openSinus'] != null
        ? OpenSinus?.fromJson(json['openSinus'])
        : null;
    closedSinus = json['closedSinus'] != null
        ? ClosedSinus?.fromJson(json['closedSinus'])
        : null;
    guidedImplant = json['guidedImplant'] != null
        ? GuidedImplant?.fromJson(json['guidedImplant'])
        : null;
    bontic = json['bontic'] != null ? Bontic?.fromJson(json['bontic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (extraction != null) data['extraction'] = extraction!.toJson();
    if (flap != null) data['flap'] = flap!.toJson();
    if (simpleImplant != null) data['simpleImplant'] = simpleImplant!.toJson();
    if (immediateImplant != null)
      data['immediateImplant'] = immediateImplant!.toJson();
    if (expansion != null) data['expansion'] = expansion!.toJson();
    if (splitting != null) data['splitting'] = splitting!.toJson();
    if (gbr != null) data['gbr'] = gbr!.toJson();
    if (openSinus != null) data['openSinus'] = openSinus!.toJson();
    if (closedSinus != null) data['closedSinus'] = closedSinus!.toJson();
    if (guidedImplant != null) data['guidedImplant'] = guidedImplant!.toJson();
    if (bontic != null) data['bontic'] = bontic!.toJson();
    return data;
  }
}

class Bontic {
  String? value = "";
  bool? status = false;

  Bontic({this.value = "", this.status = false});

  Bontic.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class ClosedSinus {
  String? value = "";
  bool? status = false;

  ClosedSinus({this.value = "", this.status = false});

  ClosedSinus.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class Expansion {
  String? value = "";
  bool? status = false;

  Expansion({this.value = "", this.status = false});

  Expansion.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class Extraction {
  String? value = "";
  bool? status = false;

  Extraction({this.value = "", this.status = false});

  Extraction.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class Flap {
  String? value = "";
  bool? status = false;

  Flap({this.value = "", this.status = false});

  Flap.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class Gbr {
  String? value = "";
  bool? status = false;

  Gbr({this.value = "", this.status = false});

  Gbr.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class GuidedImplant {
  String? value = "";
  bool? status = false;

  GuidedImplant({this.value = "", this.status = false});

  GuidedImplant.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class ImmediateImplant {
  String? value = "";
  bool? status = false;

  ImmediateImplant({this.value = "", this.status = false});

  ImmediateImplant.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class OpenSinus {
  String? value = "";
  bool? status = false;

  OpenSinus({this.value = "", this.status = false});

  OpenSinus.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class SimpleImplant {
  String? value = "";
  bool? status = false;

  SimpleImplant({this.value = "", this.status = false});

  SimpleImplant.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}

class Splitting {
  String? value = "";
  bool? status = false;

  Splitting({this.value = "", this.status = false});

  Splitting.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}
