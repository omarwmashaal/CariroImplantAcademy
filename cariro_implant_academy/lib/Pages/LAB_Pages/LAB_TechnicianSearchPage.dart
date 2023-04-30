import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Controllers.dart';
import '../../Models/ApplicationUserModel.dart';
import '../../Models/Enum.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/CIA_TextFormField.dart';
import '../../Widgets/MultiSelectChipWidget.dart';
import '../../Widgets/SnackBar.dart';
import '../../Widgets/Title.dart';

class LAB_TechnicianSearchPage extends StatefulWidget {
  const LAB_TechnicianSearchPage({Key? key}) : super(key: key);

  @override
  State<LAB_TechnicianSearchPage> createState() => _LAB_TechnicianSearchPageState();
}

class _LAB_TechnicianSearchPageState extends State<LAB_TechnicianSearchPage> {
  ApplicationUserDataSource dataSource = ApplicationUserDataSource(type: UserDataSourceType.Technician);


  @override
  void initState() {
    siteController.setAppBarWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TitleWidget(
                title: "Technicians",
                showBackButton: false,
              ),
            ),
            CIA_PrimaryButton(
              label: "Add New Technician",
              onTab: () {
                ApplicationUserModel newTechnician = ApplicationUserModel(gender: "Male", role: "technician");
                bool newWorkPlace = false;
                Alert(
                  context: context,
                  title: "Add new Technician",
                  content: StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: [
                        CIA_TextFormField(
                          label: "Name",
                          controller: TextEditingController(text: newTechnician.name ?? ""),
                          onChange: (v) => newTechnician.name = v,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Email",
                          controller: TextEditingController(text: newTechnician.email ?? ""),
                          onChange: (v) => newTechnician.email = v,
                        ),
                        FormTextKeyWidget(
                          text: r"Default password: Pa$$word1",
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorizontalRadioButtons(
                          groupValue: "Male",
                          names: ["Male", "Female"],
                          onChange: (p0) {
                            newTechnician.gender = p0;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Date of birth",
                          enabled: false,
                          controller: TextEditingController(text: newTechnician.dateOfBirth ?? ""),
                          onChange: (v) => newTechnician.dateOfBirth = v,
                          onTap: () {
                            CIA_PopupDialog_DateOnlyPicker(context, "Date of birth", (v) {
                              setState(() {
                                newTechnician.dateOfBirth = v;
                              });
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Phone Number 1",
                          isNumber: true,
                          controller: TextEditingController(text: newTechnician.phoneNumber ?? ""),
                          onChange: (v) => newTechnician.phoneNumber = v,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Phone Number 2",
                          isNumber: true,
                          controller: TextEditingController(text: newTechnician.phoneNumber2 ?? ""),
                          onChange: (v) => newTechnician.phoneNumber2 = v,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
                  buttons: [
                    DialogButton(
                      color: Color_Accent,
                      width: 150,
                      onPressed: () async {
                        var res = await AuthenticationAPI.Register(newTechnician);
                        if (res.statusCode == 200) {
                          ShowSnackBar(isSuccess: true, title: "Success", message: "Customer Added!");
                          Navigator.pop(context);
                          dataSource.loadData();
                        } else
                          ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ).show();
              },
            ),
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
                            // _getXController.search.value = value;
                            // widget.dataSource.loadData(search: value, filter: _getXController.searchFilter.value);
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
                                  // _getXController.searchFilter.value = value;
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
                  loadFunction: dataSource.loadData,
                  dataSource: dataSource,
                  onCellClick: (value) {
                    setState(() {
                      // selectedPatientID = widget.dataSource.models[value - 1].id!;
                      // print("");
                    });
                    internalPagesController.jumpToPage(1);
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
