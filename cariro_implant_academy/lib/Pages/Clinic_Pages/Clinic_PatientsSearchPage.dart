import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Models/PatientInfo.dart';

class Clinic_PatientsSearchPage extends StatefulWidget {
  const Clinic_PatientsSearchPage({Key? key}) : super(key: key);

  @override
  State<Clinic_PatientsSearchPage> createState() =>
      _Clinic_PatientsSearchPageState();
}

class _Clinic_PatientsSearchPageState extends State<Clinic_PatientsSearchPage> {
  PatientDataSource dataSource = PatientDataSource();
  int patientID = 0;

  @override
  Widget build(BuildContext context) {
    return Container();/*
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
              "ID",
              "Name",
              "Phone",
              "Operation",
            ],
            loadMoreFuntcion: dataSource.loadData,
            dataSource: dataSource,
            columnNames: dataSource.columns,
            onCellTab: (value) {

              setState(() {
                patientID = dataSource.models[value - 1].id!;
              });
              internalPagesController.jumpToPage(1);
            },
          ),
          Container()
        ]),
        Obx(() => (siteController.getRole() == "Secretary")
            ? ViewPatientPage(
                patientID: patientID,
              )
            : Clinic_PatientMedicalPage(
                patientID: patientID,
              )),
        ViewPatientPage(
          patientID: patientID,
        )
      ],
    );*/
  }
}
