import 'package:cariro_implant_academy/features/clinicTreatments/presentation/pages/clinicTreeatmentPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/treatmentWidget.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../core/constants/enums/enums.dart';

class SurgicalTreatmentPage extends StatefulWidget {
  SurgicalTreatmentPage({Key? key, required this.patientId}) : super(key: key);

  static String routePath = ":id/SurgicalTreatment";
  int patientId;
  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return ClinicTreatmentPage.routeName;
      default:
        return "SurgicalTreatment";
    }
  }
  @override
  State<SurgicalTreatmentPage> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<SurgicalTreatmentPage> {
  @override
  Widget build(BuildContext context) {
    return TreatmentWidget(
      patientId: widget.patientId,
      surgical: true,
    );
  }

  @override
  void dispose() {
    /*if (!siteController.disableMedicalEdit.value) {
      siteController.disableMedicalEdit.value = true;
      MedicalAPI.UpdatePatientTreatmentPlan(widget.patientId, treatmentPlanEntity!.treatmentPlan!);
    }*/

    super.dispose();
  }
}
