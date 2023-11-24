import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';
import '../bloc/patientVisitsBloc.dart';
import '../widgets/visitsTableWidget.dart';

class VisitsPage extends StatelessWidget {
  VisitsPage({Key? key, this.patientId}) : super(key: key);
  static String routePath = "PatientsVisits";
  static String routePathProfile = ":id/VisitsLogs";

  static String getSearchRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicPatientsVisits";
      default:
        return "PatientsVisits";
    }
  }
  static String getProfileRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "VisitsLogsClinic";
      default:
        return "VisitsLogs";
    }
  }
  int? patientId;

  @override
  Widget build(BuildContext context) {
    return VisitsTableWidget(patientId: patientId,);
  }
}
