import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Pages/SharedPages/PatientSharedPages.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class PatientVisits extends StatelessWidget {
  const PatientVisits({Key? key}) : super(key: key);
  static String routeName = "PatientsVisits";
  static String routePath = "PatientsVisits";
  @override
  Widget build(BuildContext context) {
    VisitDataSource dataSource = VisitDataSource();
    return Column(
      children: [
        TitleWidget(title: "Visits"),
        Expanded(
          child: CIA_Table(
            columnNames: dataSource.columns,
            loadFunction:()=> dataSource.loadData(),
            dataSource: dataSource,
            onCellClick: (index) {
              context.goNamed(CIA_Router.routeConst_PatientInfo,pathParameters: {'id':dataSource.models[index-1].id.toString()});
            },

          ),
        ),
      ],
    );
  }
}
