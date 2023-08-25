import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/ComplainsModel.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';

import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_SecondaryButton.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/SnackBar.dart';
import '../../Widgets/Title.dart';
import '../../presentation/patients/pages/createOrViewPatientPage.dart';
import '../SharedPages/PatientSharedPages.dart';
import 'Patient_MedicalInfo.dart';

int selectedPatientID = 0;

class _getXController extends GetxController {
  static RxString search = "".obs;
  static RxString searchFilter = "Name".obs;
}
/*
class PatientsSearchPage extends StatefulWidget {
  const PatientsSearchPage({Key? key}) : super(key: key);
  static String routeName = "Patients";
  @override
  State<PatientsSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientsSearchPage> {
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
            if (siteController.getRole() == "admin" || siteController.getRole() == "instructor" || siteController.getRole() == "assistant")
              myPages = [
                _PatientsMainPage(
                  key: GlobalKey(),
                ),
                 PatientMedicalInfoPage(
                  key: GlobalKey(),
                  child: Container(),
                  patientId: selectedPatientID,
                ),
                 ViewPatientPage(
                  key: GlobalKey(),
                  patientID: selectedPatientID,
                ),

              ];
             else
              myPages = [
                _PatientsMainPage(
                  key: GlobalKey(),
                ),

                ViewPatientPage(
                  key: GlobalKey(),
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
    if (siteController.getRole() == "admin" || siteController.getRole() == "instructor" || siteController.getRole() == "assistant")
      myPages = [
        _PatientsMainPage(
          key: GlobalKey(),
        ),
        PatientMedicalInfoPage(
          child: Container(),
          key: GlobalKey(),
          patientId: selectedPatientID,
        ),
        ViewPatientPage(
          key: GlobalKey(),
          patientID: selectedPatientID,
        ),

      ];
    else
      myPages = [
        _PatientsMainPage(
          key: GlobalKey(),
        ),

        ViewPatientPage(
          key: GlobalKey(),
          patientID: selectedPatientID,
        ),

      ];
  }
}
*/

class PatientsSearchPagess extends StatefulWidget {
  PatientsSearchPagess({Key? key, this.myPatients = false}) : super(key: key);
  static String routeName = "Patientsss";
  static String myPatientsRouteName = "MyPatientsss";
  bool myPatients;

  @override
  State<PatientsSearchPagess> createState() => _PatientsSearchPagessState();
}

class _PatientsSearchPagessState extends State<PatientsSearchPagess> {
  PatientDataSource dataSource = PatientDataSource();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TitleWidget(
                title: "Patients Search",
                showBackButton: false,
              ),
            ),
            CIA_SecondaryButton(
                label: "Add Range to my patients",
                onTab: () {
                  int fromId = 0;
                  int toId = 0;
                  CIA_ShowPopUp(
                    context: context,
                    onSave: () async {
                      var res = await PatientAPI.AddRangeToMyPatients(fromId, toId);
                      ShowSnackBar(context, isSuccess: res.statusCode == 200);
                      dataSource.loadData(myPatients: widget.myPatients);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: CIA_TextFormField(
                            label: "From Id",
                            isNumber: true,
                            controller: TextEditingController(),
                            onChange: (v) => fromId = int.parse(v),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CIA_TextFormField(
                            label: "To Id",
                            isNumber: true,
                            controller: TextEditingController(),
                            onChange: (v) => toId = int.parse(v),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(width: 10),
            CIA_PrimaryButton(
                label: "Add Patient",
                onTab: () {
                  context.goNamed(CreateOrViewPatientPage.addPatientRouteName);
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
                            dataSource.loadData(search: value, filter: _getXController.searchFilter.value, myPatients: widget.myPatients);
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
                                onChange: (value) {
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
                  columnNames: dataSource.columns,
                  loadFunction: () async {
                    return await dataSource.loadData(myPatients: widget.myPatients);
                  },
                  dataSource: dataSource,
                  onCellClick: (value) {
                    setState(() {
                      selectedPatientID = dataSource.models[value - 1].id!;
                    });
                    //internalPagesController.jumpToPage(1);
                    context.goNamed(CIA_Router.routeConst_PatientInfo, pathParameters: {"id": dataSource.models[value - 1].id!.toString()});
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PatientsComplainsPage extends StatefulWidget {
  const PatientsComplainsPage({Key? key}) : super(key: key);
  static String routeName = "PatientsComplains";

  @override
  State<PatientsComplainsPage> createState() => _PatientsComplainsPageState();
}

class _PatientsComplainsPageState extends State<PatientsComplainsPage> {
  ComplainsDataSource complainsDataSource = ComplainsDataSource();
  EnumComplainStatus? status;
  String? complainSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          title: "Complains",
          showBackButton: false,
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
                          onChange: (value) async {
                            complainSearch = value;
                            await complainsDataSource.loadData(status: status, search: complainSearch);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: HorizontalRadioButtons(
                                groupValue: "All",
                                names: ["All", "Untouched", "In Queue", "Resolved"],
                                onChange: (value) async {
                                  if (value == "Untouched")
                                    status = EnumComplainStatus.Untouched;
                                  else if (value == "In Queue")
                                    status = EnumComplainStatus.InQueue;
                                  else if (value == "Resolved")
                                    status = EnumComplainStatus.Resolved;
                                  else
                                    status = null;
                                  await complainsDataSource.loadData(status: status, search: complainSearch);
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
                  columnNames: complainsDataSource.columns,
                  loadFunction: complainsDataSource.loadData,
                  dataSource: complainsDataSource,
                  onCellClick: (value) {
                    setState(() {
                      selectedPatientID = complainsDataSource.models[value - 1].patientID!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
