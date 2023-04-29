import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/Lab_StepModel.dart';

class CIA_LAB_StepTimelineWidget extends StatelessWidget {
  CIA_LAB_StepTimelineWidget({Key? key, required this.steps, this.isTask = false})
      : super(key: key);
  List<LAB_StepModel> steps;
  bool isTask;

  List<StepperData> _stepperData = <StepperData>[];

  @override
  Widget build(BuildContext context) {
    _stepperData.clear();
    int activeIndex = 0;
    int index = 0;
    for (LAB_StepModel step in steps) {
      if (step.status == LabStepStatus.InProgress) activeIndex = index;
      _stepperData.add(
        StepperData(
          title: StepperText(
            step.status == LabStepStatus.Done
                ? step.name! + " by: " + (step.technician!.name!)
                : (step.status == LabStepStatus.InProgress
                    ? step.name! +
                        " assigned to" +
                        (isTask ? " you" : ": " + (step.technician!.name!))
                    : step.name!),
          ),
          subtitle: StepperText(step.status == LabStepStatus.Done
              ? (step.date??"")
              : (step.status == LabStepStatus.InProgress
                  ? "In Progress"
                  : "Not Yet")),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: step.status == LabStepStatus.Done
                    ? Colors.green
                    : (step.status == LabStepStatus.InProgress
                        ? Colors.orange
                        : Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
      );
      index++;
    }
    return AnotherStepper(
      //gap: 20,
      stepperList: _stepperData,
      stepperDirection: Axis.horizontal,
      activeIndex: activeIndex,
      barThickness: 8,
      activeBarColor: Colors.green,
      iconWidth: 40,
      // Height that will be applied to all the stepper icons
      iconHeight: 40, // Width that will be applied to all the stepper icons
    );
  }
}
