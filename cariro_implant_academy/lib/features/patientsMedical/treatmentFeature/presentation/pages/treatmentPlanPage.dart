import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/treatmentWidget.dart';
import 'package:flutter/cupertino.dart';

class TreatmentPlanPage extends StatefulWidget {
  TreatmentPlanPage({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "TreatmentPlan";
  static String routePath = "Patient/:id/TreatmentPlan";
  int patientId;

  @override
  State<TreatmentPlanPage> createState() => _PatientTreatmentPlanState();
}

class _PatientTreatmentPlanState extends State<TreatmentPlanPage> {
  @override
  Widget build(BuildContext context) {
    return TreatmentWidget(
      patientId: widget.patientId,
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
