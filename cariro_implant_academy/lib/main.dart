import 'dart:async';
import 'dart:io';

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/NavigationController.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Controllers/PatientMedicalController.dart';
import 'package:cariro_implant_academy/Controllers/SiteController.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/CashFlowSummaryModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/StockModel.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Pages/Authentication/AuthenticationPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/CIA_SettingsPage.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/Pages/UsersSearchPage.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MedicalSlidingBar.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_bloc.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/siteChange/siteChange_blocStates.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientVisitsBloc.dart';
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
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'API/TempPatientAPI.dart';
import 'Controllers/RolesController.dart';
import 'Helpers/Router.dart';
import 'Models/Enum.dart';
import 'Pages/CIA_Pages/CashFlowPage.dart';
import 'Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'Pages/CIA_Pages/PatientsSearchPage.dart';
import 'Pages/LAB_Pages/LAB_LabRequestsSearch.dart';
import 'Pages/SharedPages/CashFlowSharedPage.dart';
import 'Pages/SharedPages/LapCreateNewRequestSharedPage.dart';
import 'Pages/SharedPages/PatientSharedPages.dart';
import 'Pages/SharedPages/StocksSharedPage.dart';
import 'SignalR/Config.dart';
import 'Widgets/CIA_PopUp.dart';
import 'Widgets/CIA_TeethTreatmentWidget.dart';
import 'Widgets/LargeScreen.dart';
import 'Widgets/SiteLayout.dart';
import 'package:logging/logging.dart';

import 'core/injection_contianer.dart';
import 'core/presentation/widgets/LoadingWidget.dart';

void main() async {
  /*html.window.onUnload.listen((event) async {
  });*/
  //Get.put(NavigationController());
  Get.put(PagesController());
  Get.put(InternalPagesController());
  Get.put(RolesController());
  Get.put(SiteController());

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
  init();
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body: DashBoardPage(),

        backgroundColor: Color_Background,
        body: AuthenticationPage());
  }
}
