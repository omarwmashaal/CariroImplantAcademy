import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/ComplainsModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Patient_ViewPatientPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';

import '../../Controllers/PatientMedicalController.dart';
import '../../Models/PatientInfo.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import '../../Widgets/Title.dart';
import '../SharedPages/PatientSharedPages.dart';
import 'Patient_MedicalInfo.dart';

int selectedPatientID = 0;

class _getXController extends GetxController {
  static RxString search = "".obs;
  static RxString searchFilter = "Name".obs;
}

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

class _PatientsMainPage extends StatefulWidget {
  _PatientsMainPage({Key? key}) : super(key: key);



  @override
  State<_PatientsMainPage> createState() => _PatientsMainPageState();
}

class _PatientsMainPageState extends State<_PatientsMainPage> {
  @override
  void initState() {
    if (siteController.getRole() == "secretary")
      siteController.setAppBarWidget(tabs: ["Patients Data", "Visits Log","Complains"]);
    else
      siteController.setAppBarWidget(width:500,tabs: ["Patients Data", "My Patients", "Visits Log","Complains"]);
  }

  ComplainsDataSource complainsDataSource = ComplainsDataSource();
  bool? resolved;
  String? complainSearch;
  @override
  Widget build(BuildContext context) {
    return PageView(
      key: GlobalKey(),
      controller: tabsController,
      children:
      (){
        List<Widget> r = [_PatientsSearch()];
        if (siteController.getRole() == "secretary")
          {
            //todo: VISITS LOG PAGE
            r.add(Container());
            //todo: Complains Page
            r.add(Column(
              children: [
                Obx(
                      () => TitleWidget(
                    title: siteController.title.value,
                    showBackButton: false,
                  ),
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
                                  onChange: (value) async{
                                    complainSearch = value;
                                    await complainsDataSource.loadData(resolved: resolved,search: complainSearch);
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
                                        names: ["All", "Resolved", "Unresolved"],
                                        onChange: (value) async{
                                          resolved = value=="All"?null:value=="Resolved";
                                          await complainsDataSource.loadData(resolved: resolved,search: complainSearch);

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
                            internalPagesController.jumpToPage(1);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
          }
        else
          {
            //todo: My Patients
            r.add(_PatientsSearch(myPatients: true,));
            //todo: VISITS LOG PAGE
            r.add(Container());
            //todo: Complains Page
            r.add(Column(
              children: [
                Obx(
                      () => TitleWidget(
                    title: siteController.title.value,
                    showBackButton: false,
                  ),
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
                                  onChange: (value) async{
                                    complainSearch = value;
                                      await complainsDataSource.loadData(resolved: resolved,search: complainSearch);
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
                                        names: ["All", "Resolved", "Unresolved"],
                                        onChange: (value) async{
                                          resolved = value=="All"?null:value=="Resolved";
                                          await complainsDataSource.loadData(resolved: resolved,search: complainSearch);

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
                            internalPagesController.jumpToPage(2);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
          }
        return r;
      }()

    );
  }
}

class _PatientsSearch extends StatefulWidget {
  _PatientsSearch({Key? key, this.myPatients=false}) : super(key: key);

  bool myPatients;
  @override
  State<_PatientsSearch> createState() => _PatientsSearchState();
}

class _PatientsSearchState extends State<_PatientsSearch> {
  PatientDataSource dataSource = PatientDataSource();
  @override
  Widget build(BuildContext context) {
    return Column(
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
            CIA_PrimaryButton(
                label: "Add Patient",
                onTab: () {
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
                            dataSource.loadData(search: value, filter: _getXController.searchFilter.value,myPatients: widget.myPatients);
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
                  loadFunction: ()async{
                    return await dataSource.loadData(myPatients: widget.myPatients);
                  },
                  dataSource: dataSource,
                  onCellClick: (value) {
                    //print(dataSource.models[value - 1].id);
                    setState(() {
                      selectedPatientID = dataSource.models[value - 1].id!;
                      print("");
                    });
                    //internalPagesController.jumpToPage(1);
                    context.goNamed(CIA_Router.routeConst_PatientInfo,pathParameters: {"id":dataSource.models[value - 1].id!.toString()});
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


