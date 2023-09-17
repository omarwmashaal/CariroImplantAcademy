import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/patient/presentation/presentation/visitsPage.dart';
import '../SharedPages/PatientSharedPages.dart';

class ViewPatientPage extends StatefulWidget {
  ViewPatientPage({Key? key, required this.patientID}) : super(key: key);

  int patientID;

  @override
  State<ViewPatientPage> createState() => _ViewPatientPageState();
}

class _ViewPatientPageState extends State<ViewPatientPage> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        PatientInfo_SharedPage(
          loadFunction: PatientAPI.GetPatientData,
          patientID: widget.patientID,
        ),
        VisitsPage(
          patientId: widget.patientID,
          //loadFunction: PatientAPI.GetVisitsLogs,
        ),
        PatientComplains(patientId: widget.patientID,

        )
      ],
    );
    /*Column(
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
    );*/
  }

  @override
  void initState() {
  //  siteController.setAppBarWidget(tabs: ["Patient Data", "Patient Visits","Complains"]);
  }
}
