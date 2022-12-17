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
    return TabsLayout(tabs: [
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
      ),
      SearchLayout(
        radioButtons: [
          "Name",
          "Phone",
          "ID",
          "Instructor",
          "Assistant",
        ],
        loadMoreFuntcion: dataSource.addMoreRows,
        dataSource: dataSource,
        columnNames: PatientInfoModel.columns,
      )
    ]);
  }
}
