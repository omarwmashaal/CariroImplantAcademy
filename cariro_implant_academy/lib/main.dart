import 'dart:async';

import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/helpers/dialogHelper.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_bloc.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/presentation/bloc/dentalExaminationBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/addOrRemoveMyPatientsBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSearchBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'Controllers/RolesController.dart';
import 'Helpers/Router.dart';
import 'core/features/settings/presentation/bloc/settingsBloc.dart';

import 'core/injection_contianer.dart';

void main() async {
  /*html.window.onUnload.listen((event) async {
  });*/
  //Get.put(NavigationController());
  Get.put(PagesController());
  Get.put(InternalPagesController());
  Get.put(RolesController());
  //Get.put(SiteController());

  /*
  List<String> logData = [];
  Logger.root.level = Level.INFO;
  // Writes the log messages to the console
  Logger.root.onRecord.listen(
    (LogRecord rec) {
      logData.add('${rec.level.name}: ${rec.time}: ${rec.message}');
      //print('${rec.level.name}: ${rec.time}: ${rec.message}');
      //  siteController.logs.add('${rec.level.name}: ${rec.time}: ${rec.message}');
    },
  );

  Timer? timer;
  timer = Timer.periodic(Duration(seconds: 15), (Timer t) async {
    print("timer executed");
    String data = "";
    logData.forEach((element) {
      data += (element) + "\n";
    });
    logData = [];

    UserAPI.SaveLogFile(data);

    print("log exported");
  });*/
  initInjection();
  siteController = sl<SiteController>();
  dialogHelper = sl<DialogHelper>();
  runApp(
    BlocProvider<SiteChangeBloc>(
      create: (context) => sl<SiteChangeBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future(() async => {});
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<PatientSearchBloc>()),
        BlocProvider(create: (context) => sl<AddToMyPatientsRangeBloc>()),
        BlocProvider(create: (context) => sl<CreateOrViewPatientBloc>()),
        BlocProvider(create: (context) => sl<ImageBloc>()),
        BlocProvider(create: (context) => sl<AppBarBloc>()),
        BlocProvider(create: (context) => sl<MedicalInfoShellBloc>()),
        BlocProvider(create: (context) => sl<MedicalHistoryBloc>()),
        BlocProvider(create: (context) => sl<DentalHistoryBloc>()),
        BlocProvider(create: (context) => sl<DentalExaminationBloc>()),
        BlocProvider(create: (context) => sl<MedicalPagesStatesChangesBloc>()),
        BlocProvider(create: (context) => sl<NonSurgicalTreatmentBloc>()),
        BlocProvider(create: (context) => sl<CalendarBloc>()),
        BlocProvider(create: (context) => sl<PatientVisitsBloc>()),
        BlocProvider(create: (context) => sl<TreatmentBloc>()),
        BlocProvider(create: (context) => sl<ProstheticBloc>()),
        BlocProvider(create: (context) => sl<ReceiptBloc>()),
        BlocProvider(create: (context) => sl<ComplainsBloc>()),
        BlocProvider(create: (context) => sl<UsersBloc>()),
        BlocProvider(create: (context) => sl<StockBloc>()),
        BlocProvider(create: (context) => sl<CashFlowBloc>()),
        BlocProvider(create: (context) => sl<SettingsBloc>()),
        BlocProvider(create: (context) => sl<AuthenticationBloc>()),
        BlocProvider(create: (context) => sl<AdvancedSearchBloc>()),
        BlocProvider(create: (context) => sl<LabRequestsBloc>()),
        BlocProvider(create: (context) => sl<ClinicTreatmentBloc>()),
        BlocProvider(create: (context) => sl<ComplicationsBloc>()),
      ],
      child: MaterialApp.router(
        title: 'CIA',
        theme: ThemeData(
          primaryColor: Colors.red,
          //accentColor: Color_Accent,

          primarySwatch: Colors.lightGreen,
        ),
        debugShowCheckedModeBanner: false,
        //routeInformationParser:CIA_Router.routes.routeInformationParser ,
        // routerDelegate: CIA_Router.routes.routerDelegate,
        routerConfig: CIA_Router.routes,
      ),
    );
  }
}
