import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/treatmentWidget.dart';
import 'package:flutter/cupertino.dart';

class TreatmentPage extends StatefulWidget {
  TreatmentPage({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "TreatmentPlan";
   static String routeNameClinic = "ClinicTreatmentPlan";
  static String routePath = ":id/TreatmentPlan";
  int patientId;

  @override
  State<TreatmentPage> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<TreatmentPage> {
  @override
  Widget build(BuildContext context) {
    return TreatmentWidget(
      patientId: widget.patientId,
      surgical: false,
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
