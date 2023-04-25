import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/Title.dart';
import '../SharedPages/PatientSharedPages.dart';
import 'Patient_MedicalInfo.dart';

int selectedPatientID = 0;

class _getXController extends GetxController{
  static RxString search = "".obs;
  static RxString searchFilter = "Name".obs;
}
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
              (siteController.getRole() == "admin" ||
                      siteController.getRole() == "instructor"||
                      siteController.getRole() == "assistant"
              )
                  ? PatientMedicalInfoPage(
                      key: GlobalKey(),
                      patientMedicalController: PatientMedicalController(
                          PatientInfoModel()),
                      patientID: selectedPatientID,
                    )
                  : ViewPatientPage(
                      key: GlobalKey(),
                      patientID: selectedPatientID,
                    ),
              ViewPatientPage(
                key: GlobalKey(),
                patientID: selectedPatientID,
              ),
              PatientInfo_SharedPage(
                patientID: selectedPatientID,
              ),
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
      (siteController.getRole() == "admin" ||
              siteController.getRole() == "instructor" ||
              siteController.getRole() == "assistant"
      )
          ? PatientMedicalInfoPage(
              key: GlobalKey(),
              patientMedicalController:
                  PatientMedicalController(PatientInfoModel()),
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
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => TitleWidget(
                      title: siteController.title.value,
                      showBackButton: false,
                    ),
                  ),
                ),
                CIA_PrimaryButton(label: "Add Patient", onTab: (){
                    selectedPatientID = 0;
                    internalPagesController.jumpToPage(2);
                })
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: CIA_TextField(
                              label: "Search",
                              icon: Icons.search,
                              onChange: (value) {
                                _getXController.search.value = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: HorizontalRadioButtons(
                                    groupValue: "Name",
                                    names: ["Name", "Phone", "All"],
                                    onChange: (value){
                                      _getXController.searchFilter.value = value;
                                    },
                                  ),
                                ),
                                Expanded(child: SizedBox())
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: CIA_Table(
                      columnNames: PatientInfoModel.columns,
                      loadFunction: widget.dataSource.addMoreRows,
                      dataSource: widget.dataSource,
                      onCellClick:  (value) {
                        print(widget.dataSource.models[value - 1].id);
                        setState(() {
                          selectedPatientID = widget.dataSource.models[value - 1].id!;
                          print("");
                        });

                        internalPagesController.jumpToPage(1);
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
        Container(),
        Container()
      ],
    );
  }
}
