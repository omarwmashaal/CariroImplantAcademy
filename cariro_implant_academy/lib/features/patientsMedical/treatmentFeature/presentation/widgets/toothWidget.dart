import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentDetailsModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/toothStatusWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Constants/Fonts.dart';
import '../../../../../../Widgets/FormTextWidget.dart';
import '../../domain/entities/requestChangeEntity.dart';

class ToothWidget extends StatelessWidget {
  ToothWidget({
    Key? key,
    required this.toothID,
    required this.onChange,
    this.viewOnlyMode = false,
    required this.teethData,
    required this.isSurgical,
    required this.patientId,
    required this.acceptChanges,
    required this.bloc,
  }) : super(key: key);
  bool viewOnlyMode;
  int toothID;
  Function onChange;
  List<TreatmentDetailsEntity> teethData;
  bool isSurgical;
  int patientId;
  TreatmentBloc bloc;
  Function(RequestChangeEntity request) acceptChanges;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 10,
            color: teethData
                    .where(
                      (element) => element.tooth == toothID,
                    )
                    .any(
                      (element) => element.bridge == true,
                    )
                ? Colors.orange
                : Colors.transparent,
          ),
          Expanded(
            child: Column(
              children: _buildWidgets(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWidgets() {
    List<Widget> returnValue = <Widget>[];
    List<Widget> title = [];
    var currentToothData = teethData.where((element) => element.tooth == toothID).toList();
    if (currentToothData.isNotEmpty) {
      for (var data in currentToothData) {
        try {
          if (!(data.treatmentItem!.showInSurgical) && isSurgical) continue;
        } catch (e) {
          print("Debug: if condition ${TreatmentDetailsModel.fromEntity(data).toJson()}");
        }
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));

        try {
          returnValue.add(ToothStatusWidget(
            bloc: bloc,
            isSurgical: isSurgical,
            viewOnlyMode: viewOnlyMode,
            acceptChanges: (request) => acceptChanges(request),
            patientId: patientId,
            data: data,
            onDelete: () {
              teethData.remove(data);
              onChange();
            },
          ));
        } catch (e) {
          print("Debug: Return Value ${TreatmentDetailsModel.fromEntity(data).toJson()}");
        }
        title = <Widget>[
          Visibility(
            visible: isSurgical || !viewOnlyMode || (viewOnlyMode && data.planPrice != 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider()),
                Text(
                  "Tooth",
                  style: TextStyle(fontFamily: Inter_Bold, fontSize: viewOnlyMode ? 12 : 12),
                ),
                SizedBox(width: 10),
                FormTextValueWidget(text: toothID == 0 ? "All" : toothID.toString()),
                FormTextKeyWidget(
                  text: currentToothData.any((element) => element.failedImplant == true) ? "Implant Failed" : "",
                  color: Colors.red,
                ),
                FormTextValueWidget(
                  text: currentToothData.any((element) => element.bridge == true) ? "Bridge" : "Single",
                ),
                Expanded(child: Divider()),
              ],
            ),
          ),
          SizedBox(height: viewOnlyMode ? 1 : 2),
        ];
      }
    }
    if (returnValue.isNotEmpty) {
      title.addAll(returnValue);
      returnValue = title;
    }

    return returnValue;
  }
}
