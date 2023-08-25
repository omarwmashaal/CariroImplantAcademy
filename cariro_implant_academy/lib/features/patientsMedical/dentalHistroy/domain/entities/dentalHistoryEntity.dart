import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:equatable/equatable.dart';

class DentalHistoryEntity extends Equatable {
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
  int? patientId;

  DentalHistoryEntity(
      {this.senstiveHotCold,
      this.senstiveSweets,
      this.bittingCheweing,
      this.clench,
      this.smoke,
      this.smokingStatus,
      this.seriousInjury,
      this.satisfied,
      this.cooperationScore,
      this.patientId,
      this.willingForImplantScore});



  @override
  // TODO: implement props
  List<Object?> get props => [
        this.senstiveHotCold,
        this.senstiveSweets,
        this.bittingCheweing,
        this.clench,
        this.patientId,
        this.smoke,
        this.smokingStatus,
        this.seriousInjury,
        this.satisfied,
        this.cooperationScore,
        this.willingForImplantScore,
      ];
}
