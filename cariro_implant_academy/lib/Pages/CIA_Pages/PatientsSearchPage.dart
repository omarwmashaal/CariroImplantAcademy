import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/PatientInfo.dart';

class PatientsSearchPage extends StatefulWidget {
  const PatientsSearchPage({Key? key}) : super(key: key);

  @override
  State<PatientsSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientsSearchPage> {
  PatientDataSource dataSource = PatientDataSource();
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        TabsLayout(tabs: [
          "Patients Data",
          "Visits Log"
        ], pages: [
          SearchLayout(
            radioButtons: [
              "Name",
              "Phone",
              "ID",
              "Instructor",
              "Assistant",
              "Candidate",
              "Operation",
            ],
            loadMoreFuntcion: dataSource.addMoreRows,
            dataSource: dataSource,
            columnNames: PatientInfoModel.columns,
            onCellTab: (value) {
              print(dataSource.models[value - 1].ID);
              internalPagesController.setPassedObject(dataSource.models[value - 1]);
              internalPagesController.jumpToPage(1);
            },
          ),
          Container()
        ]),
        ViewPatientPage()
      ],
    );
  }
}
