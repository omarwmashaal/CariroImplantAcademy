import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Widgets/Title.dart';
import '../bloc/patientVisitsBloc.dart';
import '../widgets/visitsTableWidget.dart';

class VisitsPage extends StatelessWidget {
  VisitsPage({Key? key, this.patientId}) : super(key: key);
  static String routeName = "PatientsVisits";
   static String routeNameClinic = "ClinicPatientsVisits";
  static String routePath = "PatientsVisits";
  static String routeNameProfile = "VisitsLogs";
  static String routePathProfile = "Patients/:id/VisitsLogs";
  static String getPathProfile(String id) {
    return "/Patients/$id/VisitsLogs";
  }
  int? patientId;

  @override
  Widget build(BuildContext context) {
    return VisitsTableWidget(patientId: patientId,);
  }
}
