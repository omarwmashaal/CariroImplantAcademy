import 'package:cariro_implant_academy/Models/Enum.dart';

class DentalHistoryModel {
  bool? senstiveHotCold;
  bool? senstiveSweets;
  bool? bittingCheweing;
  String? clench;
  int? smoke;
  SmokingStatus? smokingStatus;
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
    senstiveHotCold = json['senstiveHotCold']??false;
    senstiveSweets = json['senstiveSweets']??false;
    bittingCheweing = json['bittingCheweing']??false;
    clench = json['clench']??"";
    smoke = json['smoke']??0;
    smokingStatus = SmokingStatus.values[json['smokingStatus']??0];
    seriousInjury = json['seriousInjury']??"";
    satisfied = json['satisfied']??"";
    cooperationScore = json['cooperationScore']??0;
    willingForImplantScore = json['willingForImplantScore']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senstiveHotCold'] = this.senstiveHotCold;
    data['senstiveSweets'] = this.senstiveSweets;
    data['bittingCheweing'] = this.bittingCheweing;
    data['clench'] = this.clench;
    data['smoke'] = this.smoke;
    data['smokingStatus'] = this.smokingStatus!.index;
    data['seriousInjury'] = this.seriousInjury;
    data['satisfied'] = this.satisfied;
    data['cooperationScore'] = this.cooperationScore;
    data['willingForImplantScore'] = this.willingForImplantScore;
    return data;
  }

  Compare(DentalHistoryModel model)
  {
    return this.toJson()==model.toJson();
  }
}
