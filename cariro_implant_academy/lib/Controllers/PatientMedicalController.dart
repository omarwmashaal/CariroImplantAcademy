import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:get/get.dart';

import '../Models/TreatmentPlanModel.dart';

class PatientMedicalController extends GetxController {
  late PatientInfoModel patient;

  PatientMedicalController(this.patient);

  String nonSurgicalTreatment = "";
  Map<String, TreatmentPlanModel> TreatmentPlan =
      Map<String, TreatmentPlanModel>();

  Map<String, List<String>> _DentalExamination = {
    "Carious": [],
    "Filled": [],
    "Missed": [],
    "Not Sure": [],
    "Mobility": [],
    "Hopeless teeth": [],
    "Inter arch space RT": [],
    "Inter arch space LT": [],
    "Implant Placed": [],
    "Implant Failed": [],
  };

  updateDentalExamination(String key, List<String> value) {
    this._DentalExamination[key] = value;
  }

  String getToothStatus(String tooth) {
    List<String> temp = <String>[];
    for (String status in _DentalExamination.keys) {
      temp = _DentalExamination[status]!;
      if (temp.contains(tooth)) {
        return status;
      }
    }
    return "";
  }

  updateToothStatus(String tooth, String status) {
    List<String> temp = <String>[];
    for (String _status in _DentalExamination.keys) {
      temp = _DentalExamination[_status]!;
      if (temp.contains(tooth)) {
        if (_status != status) {
          List<String> ss = List<String>.of(_DentalExamination[_status]!);
          ss.remove(tooth);
          _DentalExamination[_status] = ss!;
        }
      } else {
        if (_status == status) {
          var ss = List<String>.of(_DentalExamination[_status]!);
          ss.add(tooth);
          _DentalExamination[_status] = ss!;
        }
      }
    }
  }

  updateToothTreatmentStatus(String tooth, String status) {
    List<String> temp = <String>[];
    for (String _status in _DentalExamination.keys) {
      temp = _DentalExamination[_status]!;
      if (temp.contains(tooth)) {
        if (_status != status) {
          List<String> ss = List<String>.of(_DentalExamination[_status]!);
          ss.remove(tooth);
          ss.add("strike" + tooth);
          _DentalExamination[_status] = ss!;
        }
      } else {
        if (_status == status) {
          var ss = List<String>.of(_DentalExamination[_status]!);
          ss.add(tooth);
          _DentalExamination[_status] = ss!;
        }
      }
    }
  }

  addTooth(String tooth) {
    this._DetnalExaminationSuggestionTeeth.add(tooth);
    this
        ._DetnalExaminationSuggestionTeeth
        .sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    update();
  }

  removeTooth(String tooth) {
    this._DetnalExaminationSuggestionTeeth.remove(tooth);
    update();
  }

  List<String> getSuggestionTeeth() => this._DetnalExaminationSuggestionTeeth;
  List<String> getTeeth() => this._DetnalExaminationTeeth;

  Map<String, List<String>> getDentalExamindation() => this._DentalExamination;

  List<String> _DetnalExaminationTeeth = [
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49"
  ];
  List<String> _DetnalExaminationSuggestionTeeth = [
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49"
  ];
}
