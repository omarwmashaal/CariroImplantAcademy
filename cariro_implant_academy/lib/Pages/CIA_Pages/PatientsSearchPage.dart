import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/Title.dart';
import 'Patient_MedicalInfo.dart';

int selectedPatientID = 0;

class PatientsSearchPage extends StatefulWidget {
  const PatientsSearchPage({Key? key}) : super(key: key);

  @override
  State<PatientsSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientsSearchPage> {
  PatientDataSource dataSource = PatientDataSource();
  List<Widget> myPages = [];
  ValueNotifier<int> buildCount = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: internalPagesController,
      itemCount: myPages.length,
      itemBuilder: (context, i) {
        return ValueListenableBuilder(
          valueListenable: buildCount,
          builder: (context, bldcnt, child) {
            myPages = [
              _PatientSearch(
                key: GlobalKey(),
                dataSource: dataSource,
              ),
              (siteController.getRole() == "Admin" ||
                      siteController.getRole() == "Instructor")
                  ? PatientMedicalInfoPage(
                      key: GlobalKey(),
                      patientMedicalController: PatientMedicalController(
                          PatientInfoModel(1, "", "", "")),
                      patientID: selectedPatientID,
                    )
                  : ViewPatientPage(
                      key: GlobalKey(),
                      patientID: selectedPatientID,
                    ),
              ViewPatientPage(
                key: GlobalKey(),
                patientID: selectedPatientID,
              )
            ];
            return myPages[i];
          },
        );
      },
    );


  }

  @override
  void initState() {
    myPages = [
      _PatientSearch(
        key: GlobalKey(),
        dataSource: dataSource,
      ),
      (siteController.getRole() == "Admin" ||
              siteController.getRole() == "Instructor")
          ? PatientMedicalInfoPage(
              key: GlobalKey(),
              patientMedicalController:
                  PatientMedicalController(PatientInfoModel(1, "", "", "")),
              patientID: selectedPatientID,
            )
          : ViewPatientPage(
              key: GlobalKey(),
              patientID: selectedPatientID,
            ),
      ViewPatientPage(
        key: GlobalKey(),
        patientID: selectedPatientID,
      )
    ];
  }
}

class _PatientSearch extends StatefulWidget {
  _PatientSearch({Key? key, required this.dataSource}) : super(key: key);

  PatientDataSource dataSource;

  @override
  State<_PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<_PatientSearch> {
  @override
  void initState() {
    siteController
        .setAppBarWidget(tabs: ["Patients Data", "My Patients", "Visits Log"]);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      key: GlobalKey(),
      controller: tabsController,
      children: [
        Column(
          children: [
            Obx(
              () => TitleWidget(
                title: siteController.title.value,
                showBackButton: false,
              ),
            ),
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
              loadMoreFuntcion: widget.dataSource.addMoreRows,
              dataSource: widget.dataSource,
              columnNames: PatientInfoModel.columns,
              onCellTab: (value) {
                print(widget.dataSource.models[value - 1].id);
                setState(() {
                  selectedPatientID = widget.dataSource.models[value - 1].id!;
                  print("");
                });

                internalPagesController.jumpToPage(1);
              },
            ),
          ],
        ),
        Container(),
        Container()
      ],
    );
  }
}
