import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/labRequest/domain/entities/labStepEntity.dart';

class CIA_LAB_StepTimelineWidget extends StatelessWidget {
  CIA_LAB_StepTimelineWidget({Key? key, required this.steps,required this.customerId, this.isTask = false}) : super(key: key);
  List<LabStepEntity> steps;
  bool isTask;
  int customerId;

  List<StepperData> _stepperData = <StepperData>[];

  @override
  Widget build(BuildContext context) {
    return Container();
    /*_stepperData.clear();
    int activeIndex = 0;
    int index = 0;
    for (LAB_StepModel step in steps) {
      if (step.status == LabStepStatus.InProgress || step.status == LabStepStatus.Done) activeIndex = index;
      _stepperData.add(
        StepperData(
          title: StepperText(
            step.status == LabStepStatus.Done
                ? step.step!.name! + " by: " + (step.technician!.name!)
                : (step.status == LabStepStatus.InProgress
                    ? step.step!.name! +
                        " assigned to" +
                        (step.technicianId==customerId
                            ? " Customer"
                            : step.step!.id == 11
                                ? " Lab"
                                : (isTask && step.technicianId == siteController.getUserId() ? " you" : ": " + (step.technician!.name!)))
                    : step.step!.name!),
          ),
          subtitle: StepperText(step.status == LabStepStatus.Done
              ? (step.date ?? "") + " || Notes: ${step.notes ?? ""}"
              : (step.status == LabStepStatus.InProgress ? "In Progress" : "Not Yet") + " || Notes: ${step.notes ?? ""}"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: step.status == LabStepStatus.Done ? Colors.green : (step.status == LabStepStatus.InProgress ? Colors.orange : Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
      );
      index++;
    }
    return AnotherStepper(
      //gap: 20,
      stepperList: _stepperData,
      stepperDirection: Axis.vertical,
      scrollPhysics: ScrollPhysics(),
      activeIndex: activeIndex,
      barThickness: 8,
      activeBarColor: Colors.green,
      iconWidth: 40,
      // Height that will be applied to all the stepper icons
      iconHeight: 40, // Width that will be applied to all the stepper icons
    );*/
  }
}
