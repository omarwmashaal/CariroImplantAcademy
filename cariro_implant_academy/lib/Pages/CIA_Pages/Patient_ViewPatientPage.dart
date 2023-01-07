import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/TabsLayout.dart';
import '../SharedPages/PatientSharedPages.dart';

class ViewPatientPage extends StatelessWidget {
  ViewPatientPage({Key? key, required this.patient}) : super(key: key);

  PatientInfoModel patient;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabsLayout(
            showBackButton: true,
            tabs: ["Patient Data", "Patient Visits"],
            pages: [
              PatientInfo_SharedPage(
                patient: patient,
              ),
              PatientVisits_SharedPage(patient: patient),
            ],
          ),
        ),
      ],
    );
  }
}
