import 'package:get/get.dart';

T? mapToEnum<T extends Enum>(List<T> values, dynamic? value) {
  if (value is String) return values.firstWhereOrNull((element) => (element as Enum).name.toLowerCase() == value.toLowerCase());
  if (value == null || value is! int) {
    return null;
  }
  return values[value];
}

int? getEnumIndex<T extends Enum>(List<T> values, dynamic? value) {
  if (value is String) {
    var found = values.firstWhereOrNull((element) => element.name.toLowerCase() == value.toLowerCase());
    if (found == null) return null;
    return values.indexWhere((element) => element.name.toLowerCase() == value);
  }
  if (value is Enum) return value.index;
  return null;
}

String? getEnumName(Enum? value) {
  if (value == null) return null;
  return value.name;
}

T getEnumFromName<T extends Enum>(List<T> values, String name) {
  name = name.toLowerCase().replaceAll(" ", "");
  var result = values.firstWhereOrNull((element) => element.name.toLowerCase() == name);
  if (result == null) throw Exception();
  return result;
}

enum EnumGender {
  Male,
  Female;
}

enum EnumMaritalStatus { Married, Single }

enum EnumImageType { PatientProfile, IdBack, IdFront, UserProfile, Pros }

enum EnumOralHygieneRating {
  BadHygiene,
  FairHygiene,
  GoodHygiene,
  ExcellentHygiene,
}

enum EnumComplainStatus { InQueue, Untouched, Resolved }

enum EnumSummaryFilter {
  ThisWeek,
  LastMonth,
  ThisMonth,
  ThisYear,
}
