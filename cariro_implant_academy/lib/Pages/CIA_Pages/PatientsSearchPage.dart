import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_MedicalInfo.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/Title.dart';

class PatientsSearchPage extends StatefulWidget {
  const PatientsSearchPage({Key? key}) : super(key: key);

  @override
  State<PatientsSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientsSearchPage> {
  PatientDataSource dataSource = PatientDataSource();
  late PatientInfoModel selectedPatient =
      PatientInfoModel(1, "Name", "Phone", "MaritalStatus");
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
            return myPages[i];
          },
        );
      },
    );

    PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      onPageChanged: (value) {},
      children: [
        PageView(
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
              ],
            ),
            Container(),
            Container()
          ],
        ),
        (siteController.getRole() == "Admin" ||
                siteController.getRole() == "Instructor")
            ? PatientMedicalInfoPage(
                key: GlobalKey(),
                patientMedicalController:
                    PatientMedicalController(selectedPatient),
              )
            : ViewPatientPage(
                key: GlobalKey(),
                patient: selectedPatient,
              ),
        ViewPatientPage(
          key: GlobalKey(),
          patient: selectedPatient,
        )
      ],
    );
  }

  @override
  void initState() {
    siteController
        .setAppBarWidget(tabs: ["Patients Data", "My Patients", "Visits Log"]);
    myPages = [
      PageView(
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
            ],
          ),
          Container(),
          Container()
        ],
      ),
      (siteController.getRole() == "Admin" ||
              siteController.getRole() == "Instructor")
          ? PatientMedicalInfoPage(
              key: GlobalKey(),
              patientMedicalController:
                  PatientMedicalController(selectedPatient),
            )
          : ViewPatientPage(
              key: GlobalKey(),
              patient: selectedPatient,
            ),
      ViewPatientPage(
        key: GlobalKey(),
        patient: selectedPatient,
      )
    ];
  }
}
