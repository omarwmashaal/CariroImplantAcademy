import 'package:equatable/equatable.dart';

class DentalExaminationEntity extends Equatable{
  int? tooth;
  bool? carious;
  bool? filled;
  bool? missed;
  bool? notSure;
  bool? mobilityI;
  bool? mobilityII;
  bool? mobilityIII;
  bool? hopelessTeeth;
  bool? implantPlaced;
  bool? implantFailed;
  String? previousState;
  @override
  // TODO: implement props
  List<Object?> get props => [
    tooth,
    carious,
    filled,
    missed,
    notSure,
    mobilityI,
    mobilityII,
    mobilityIII,
    hopelessTeeth,
    implantPlaced,
    implantFailed,
    previousState,
  ];

  DentalExaminationEntity({
    this.tooth,
    this.carious=false,
    this.filled = false,
    this.missed = false,
    this.notSure = false,
    this.mobilityI = false,
    this.mobilityII = false,
    this.mobilityIII = false,
    this.hopelessTeeth = false,
    this.implantPlaced = false,
    this.implantFailed = false,
    this.previousState,
  });

  updateToothStatus(String value)  {
    switch (value) {
      case "Carious":
        {
          carious = true;
          missed = false;
          filled = false;
          implantPlaced = false;

          break;
        }
      case "Filled":
        {
          carious = false;
          missed = false;
          filled = true;
          implantPlaced = false;

          break;
        }
      case "Missed":
        {
          carious = false;
          implantPlaced = false;
          carious = false;
          missed = true;
          filled = false;
          notSure = false;
          mobilityII = false;
          mobilityI = false;
          mobilityIII = false;
          implantFailed = false;
          hopelessTeeth = false;

          break;
        }
      case "Not Sure":
        {
          notSure = true;
          missed = false;
          implantPlaced = false;

          break;
        }

      case "Mobility I":
        {
          mobilityI = true;
          mobilityII = false;
          mobilityIII = false;
          missed = false;
          implantPlaced = false;

          break;
        }

      case "Mobility II":
        {
          mobilityII = true;
          mobilityI = false;
          mobilityIII = false;
          missed = false;
          implantPlaced = false;
          break;
        }

      case "Mobility III":
        {
          mobilityIII = true;
          mobilityII = false;
          mobilityI = false;
          missed = false;
          implantPlaced = false;
          break;
        }

      case "Hopeless teeth":
        {
          hopelessTeeth = true;
          missed = false;
          break;
        }
      case "Implant Placed":
        {
          implantPlaced = true;
          carious = false;
          missed = false;
          filled = false;
          notSure = false;
          mobilityII = false;
          mobilityI = false;
          mobilityIII = false;
          implantFailed = false;
          hopelessTeeth = false;

          break;
        }
      case "Implant Failed":
        {
          implantFailed = true;
          implantPlaced = false;
          carious = false;
          missed = true;
          filled = false;
          notSure = false;
          mobilityII = false;
          mobilityI = false;
          mobilityIII = false;
          hopelessTeeth = false;

          break;
        }
    }
  }


}