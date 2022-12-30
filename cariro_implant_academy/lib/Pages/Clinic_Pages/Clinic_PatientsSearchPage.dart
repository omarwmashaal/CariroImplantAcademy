import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Models/PatientInfo.dart';
import 'Clinic_PatientMedicalPage.dart';

class Clinic_PatientsSearchPage extends StatefulWidget {
  const Clinic_PatientsSearchPage({Key? key}) : super(key: key);

  @override
  State<Clinic_PatientsSearchPage> createState() =>
      _Clinic_PatientsSearchPageState();
}

class _Clinic_PatientsSearchPageState extends State<Clinic_PatientsSearchPage> {
  PatientDataSource dataSource = PatientDataSource();
  late PatientInfoModel selectedPatient =
      PatientInfoModel(1, "Name", "Phone", "MaritalStatus");

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
              "ID",
              "Name",
              "Phone",
              "Operation",
            ],
            loadMoreFuntcion: dataSource.addMoreRows,
            dataSource: dataSource,
            columnNames: PatientInfoModel.columns,
            onCellTab: (value) {
              print(dataSource.models[value - 1].ID);
              setState(() {
                selectedPatient = dataSource.models[value - 1];
              });
              internalPagesController.jumpToPage(1);
            },
          ),
          Container()
        ]),
        Obx(() => (siteController.getRole() == "Secretary")
            ? ViewPatientPage(
                patient: selectedPatient,
              )
            : Clinic_PatientMedicalPage(
                patient: selectedPatient,
              )),
        ViewPatientPage(
          patient: selectedPatient,
        )
      ],
    );
  }
}
