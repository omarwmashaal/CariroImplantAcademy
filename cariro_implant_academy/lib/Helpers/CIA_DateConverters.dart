import 'package:intl/intl.dart';

class CIA_DateConverters {
  static fromBackendToDateTime(String? dateTime) {
    if (dateTime == null || dateTime == "") return null;
    late DateTime formatedDateTime;
    if (dateTime!.contains("T"))
      formatedDateTime = DateFormat("yyyy-MM-ddTH:mm:SS").parse(dateTime!);
    else
      formatedDateTime = DateFormat("yyyy-MM-dd").parse(dateTime!);
    final DateFormat formatter = DateFormat('dd-MM-yyy hh:mm a');
    final String formatted = formatter.format(formatedDateTime);
    return formatted; // something like 2013-04-20
  }

  static fromBackendToDateOnly(String? dateTime) {
    if (dateTime == null || dateTime == "") return null;
    late DateTime formatedDateTime;
    if (dateTime!.contains("T"))
      formatedDateTime = DateFormat("yyyy-MM-ddTH:mm:SS").parse(dateTime!);
    else
      formatedDateTime = DateFormat("yyyy-MM-dd").parse(dateTime!);
    final DateFormat formatter = DateFormat('dd-MM-yyy');
    final String formatted = formatter.format(formatedDateTime);
    return formatted;
  }

  static fromBackendToTimeOnly(String? dateTime) {
    if (dateTime == null || dateTime == "") return null;
    final DateTime formatedDateTime =
        DateFormat("yyyy-MM-ddTH:mm:SS").parse(dateTime!);
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(formatedDateTime);
    return formatted;
  }

  static fromDateTimeToBackend(String? dateTime) {
    if (dateTime == null || dateTime == "") return null;
    late DateTime formatedDateTime;
    try{
      formatedDateTime =  DateFormat("dd-MM-yyyy hh:mm a").parse(dateTime!);
    }catch(e){
      formatedDateTime =  DateFormat("yyyy-MM-dd H:mm:SS").parse(dateTime!);
    }
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm');
    final String formatted = formatter.format(formatedDateTime);
    return formatted;
  }

  static fromDateOnlyToBackend(String? dateTime) {
    if (dateTime == null || dateTime == "") return null;
    late DateTime formatedDateTime;
    try{
      formatedDateTime =  DateFormat("dd-MM-yyyy hh:mm a").parse(dateTime!);
    }catch(e){
      formatedDateTime =  DateFormat("yyyy-MM-dd H:mm:SS").parse(dateTime!);
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(formatedDateTime);
    return formatted;
  }

  static fromTimeOnlyToBackend(String? dateTime) {
    if (dateTime == null || dateTime == "") return null;
    late DateTime formatedDateTime;
    try{
      formatedDateTime =  DateFormat("dd-MM-yyyy hh:mm a").parse(dateTime!);
    }catch(e){
      formatedDateTime =  DateFormat("yyyy-MM-dd H:mm:SS").parse(dateTime!);
    }    final DateFormat formatter = DateFormat('yyyy-MM-ddTH:mm');
    final String formatted = formatter.format(formatedDateTime);
    return formatted;
  }

  static simpleFormatDateTime(dynamic dateTime) {
    if (dateTime is String) {
      return DateFormat("dd-MM-yyyy hh:mm a")
          .parse(dateTime as String)
          .toString();
    } else if (dateTime is DateTime) {
      return DateFormat("dd-MM-yyyy hh:mm a")
          .format(dateTime as DateTime)
          .toString();
    }
    return dateTime.toString();
  }

  static simpleFormatTimeOnly(dynamic dateTime) {
    if (dateTime is String) {

       return DateFormat("hh:mm a").format(DateFormat("yyyy-MM-dd H:mm:SS").parse(dateTime as String)).toString();


    } else if (dateTime is DateTime) {
      return DateFormat("hh:mm a").format(dateTime as DateTime).toString();
    }
    return dateTime.toString();
  }

  static simpleFormatDateOnly(dynamic dateTime) {
    if (dateTime is String) {
      return DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd H:mm:SS").parse(dateTime as String)).toString();
    } else if (dateTime is DateTime) {
      return DateFormat("dd-MM-yyyy").format(dateTime as DateTime).toString();
    }
    return dateTime.toString();
  }
}
