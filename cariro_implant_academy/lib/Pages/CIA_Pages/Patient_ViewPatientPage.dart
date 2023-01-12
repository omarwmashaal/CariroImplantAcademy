import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/TabsLayout.dart';
import '../SharedPages/PatientSharedPages.dart';

class ViewPatientPage extends StatefulWidget {
  ViewPatientPage({Key? key, required this.patient}) : super(key: key);

  PatientInfoModel patient;

  @override
  State<ViewPatientPage> createState() => _ViewPatientPageState();
}

class _ViewPatientPageState extends State<ViewPatientPage> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: tabsController,
      children: [
        PatientInfo_SharedPage(
          patient: widget.patient,
        ),
        PatientVisits_SharedPage(patient: widget.patient),
      ],
    );
    Column(
      children: [
        Expanded(
          child: TabsLayout(
            showBackButton: true,
            tabs: ["Patient Data", "Patient Visits"],
            pages: [
              PatientInfo_SharedPage(
                patient: widget.patient,
              ),
              PatientVisits_SharedPage(patient: widget.patient),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget(tabs: ["Patient Data", "Patient Visits"]);
  }
}
