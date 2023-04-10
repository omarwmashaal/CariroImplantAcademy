import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepModel {
  String name;
  StepStatus_ stepStatus = StepStatus_.NotYet;
  DateTime? date;
  StepModel({required this.name, this.date, required this.stepStatus});
}

enum StepStatus_ {
  Done,
  InProgress,
  NotYet,
}

class CIA_StepTimelineWidget extends StatelessWidget {
  CIA_StepTimelineWidget({Key? key, required this.steps, this.activeIndex_})
      : super(key: key);
  List<StepModel> steps;
  int? activeIndex_;

  List<StepperData> _stepperData = <StepperData>[];

  @override
  Widget build(BuildContext context) {
    _stepperData.clear();
    int activeIndex = 0;
    int index = 0;
    for (StepModel step in steps) {
      if (step.stepStatus == StepStatus_.InProgress)
        activeIndex = activeIndex_ == null ? index : activeIndex_ as int;
      _stepperData.add(
        StepperData(
          title: StepperText(step.name,
              textStyle: TextStyle(fontWeight: FontWeight.normal)),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: step.stepStatus == StepStatus_.Done
                    ? Colors.green
                    : (step.stepStatus == StepStatus_.InProgress
                        ? Colors.orange
                        : Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
      );
      index++;
    }
    return AnotherStepper(
     // gap: 20,
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
