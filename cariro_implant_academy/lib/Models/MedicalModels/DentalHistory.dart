class DentalHistoryModel {
  bool? senstiveHotCold;
  bool? senstiveSweets;
  bool? bittingCheweing;
  String? clench;
  int? smoke;
  String? smokingStatus;
  String? seriousInjury;
  String? satisfied;
  int? cooperationScore;
  int? willingForImplantScore;

  DentalHistoryModel(
      {this.senstiveHotCold,
      this.senstiveSweets,
      this.bittingCheweing,
      this.clench,
      this.smoke,
      this.smokingStatus,
      this.seriousInjury,
      this.satisfied,
      this.cooperationScore,
      this.willingForImplantScore});

  DentalHistoryModel.fromJson(Map<String, dynamic> json) {
    senstiveHotCold = json['senstiveHotCold'];
    senstiveSweets = json['senstiveSweets'];
    bittingCheweing = json['bittingCheweing'];
    clench = json['clench'];
    smoke = json['smoke'];
    smokingStatus = json['smokingStatus'];
    seriousInjury = json['seriousInjury'];
    satisfied = json['satisfied'];
    cooperationScore = json['cooperationScore'];
    willingForImplantScore = json['willingForImplantScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senstiveHotCold'] = this.senstiveHotCold;
    data['senstiveSweets'] = this.senstiveSweets;
    data['bittingCheweing'] = this.bittingCheweing;
    data['clench'] = this.clench;
    data['smoke'] = this.smoke;
    data['smokingStatus'] = this.smokingStatus;
    data['seriousInjury'] = this.seriousInjury;
    data['satisfied'] = this.satisfied;
    data['cooperationScore'] = this.cooperationScore;
    data['willingForImplantScore'] = this.willingForImplantScore;
    return data;
  }
}
