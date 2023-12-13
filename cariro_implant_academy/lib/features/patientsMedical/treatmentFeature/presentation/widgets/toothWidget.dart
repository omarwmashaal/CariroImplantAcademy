import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
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
    required this.prices,
    required this.isSurgical,
    required this.patientId,
    required this.acceptChanges,
    required this.bloc,
  }) : super(key: key);
  bool viewOnlyMode;
  int toothID;
  Function onChange;
  List<TeethTreatmentPlanEntity> teethData;
  TreatmentPricesEntity prices;
  bool isSurgical;
  int patientId;
  TreatmentBloc bloc;
  Function(RequestChangeEntity request) acceptChanges;

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildWidgets());
  }

  List<Widget> _buildWidgets() {
    List<Widget> returnValue = <Widget>[];
    var currentTooth = teethData.firstWhereOrNull((element) => element.tooth == toothID);
    if (currentTooth != null) {
      if (currentTooth!.simpleImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.simpleImplant!,
          title: "Simple Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.simpleImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.immediateImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.immediateImplant!,
          title: "Immediate Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.immediateImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.guidedImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.guidedImplant!,
          title: "Guided Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.guidedImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.expansionWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.expansionWithImplant!,
          title: "Expansion With Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.expansionWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.splittingWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.splittingWithImplant!,
          title: "Splitting With Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.splittingWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.gbrWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.gbrWithImplant!,
          title: "GBR With Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.gbrWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.openSinusWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.openSinusWithImplant!,
          title: "Open Sinus Wit Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.openSinusWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.closedSinusWithImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.closedSinusWithImplant!,
          title: "Closed Sinus With Implant",
          settingsPrice: prices.implant,
          price: true,
          onDelete: () {
            currentTooth!.closedSinusWithImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.expansionWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.expansionWithoutImplant!,
          title: "Expansion Without Implant",
          onDelete: () {
            currentTooth!.expansionWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.splittingWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.splittingWithoutImplant!,
          title: "Splitting Without Implant",
          onDelete: () {
            currentTooth!.splittingWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.gbrWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.gbrWithoutImplant!,
          title: "GBR Without Implant",
          onDelete: () {
            currentTooth!.gbrWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.openSinusWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.openSinusWithoutImplant!,
          title: "Open Sinus Without Implant",
          onDelete: () {
            currentTooth!.openSinusWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.closedSinusWithoutImplant != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.closedSinusWithoutImplant!,
          title: "Closed Sinus Without Implant",
          onDelete: () {
            currentTooth!.closedSinusWithoutImplant = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.extraction != null ) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.extraction!,
          title: "Extraction",
          settingsPrice: prices.extraction,
          assignButton: true,
          price: true,
          onDelete: () {
            currentTooth!.extraction = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.restoration != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.restoration!,
          title: "Restoration",
          settingsPrice: prices.restoration,
          assignButton: true,
          price: true,
          onDelete: () {
            currentTooth!.restoration = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.rootCanalTreatment != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.rootCanalTreatment!,
          title: "Root Canal Treatment",
          assignButton: true,
          settingsPrice: prices.rootCanalTreatment,
          price: true,
          onDelete: () {
            currentTooth!.rootCanalTreatment = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.scaling != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.scaling!,
          title: "Scaling",
          price: true,
          settingsPrice: prices.scaling,
          onDelete: () {
            currentTooth!.scaling = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.crown != null && !isSurgical) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          price: true,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.crown!,
          title: "Crown",
          settingsPrice: prices.crown,
          onDelete: () {
            currentTooth!.crown = null;
            onChange();
          },
        ));
      }
      if (currentTooth!.pontic != null) {
        returnValue.add(SizedBox(height: viewOnlyMode ? 1 : 10));
        returnValue.add(ToothStatusWidget( bloc:bloc,
          isSurgical: isSurgical, tooth: currentTooth.tooth!,
          viewOnlyMode: viewOnlyMode,
          acceptChanges: (request) => acceptChanges(request),
          patientId: patientId,
          fieldModel: currentTooth!.pontic!,
          title: "Pontic",
          onDelete: () {
            currentTooth!.pontic = null;
            onChange();
          },
        ));
      }
    }
    var title = <Widget>[
      Visibility(
        visible: isSurgical ||
            !viewOnlyMode ||
            (viewOnlyMode &&
                ((currentTooth!.expansionWithoutImplant != null && currentTooth!.expansionWithoutImplant!.planPrice != 0) ||
                    (currentTooth!.splittingWithoutImplant != null && currentTooth!.splittingWithoutImplant!.planPrice != 0) ||
                    (currentTooth!.gbrWithoutImplant != null &&
                        currentTooth!.gbrWithoutImplant!.planPrice != 0 &&
                        currentTooth!.gbrWithoutImplant!.planPrice != 0) ||
                    (currentTooth!.openSinusWithoutImplant != null &&
                        currentTooth!.openSinusWithoutImplant!.planPrice != 0 &&
                        currentTooth!.openSinusWithoutImplant!.planPrice != 0) ||
                    (currentTooth!.closedSinusWithoutImplant != null &&
                        currentTooth!.closedSinusWithoutImplant!.planPrice != 0 &&
                        currentTooth!.closedSinusWithoutImplant!.planPrice != 0) ||
                    (currentTooth!.simpleImplant != null && currentTooth!.simpleImplant!.planPrice != 0 && currentTooth!.simpleImplant!.planPrice != 0) ||
                    (currentTooth!.immediateImplant != null &&
                        currentTooth!.immediateImplant!.planPrice != 0 &&
                        currentTooth!.immediateImplant!.planPrice != 0) ||
                    (currentTooth!.guidedImplant != null && currentTooth!.guidedImplant!.planPrice != 0 && currentTooth!.guidedImplant!.planPrice != 0) ||
                    (currentTooth!.expansionWithImplant != null &&
                        currentTooth!.expansionWithImplant!.planPrice != 0 &&
                        currentTooth!.expansionWithImplant!.planPrice != 0) ||
                    (currentTooth!.splittingWithImplant != null &&
                        currentTooth!.splittingWithImplant!.planPrice != 0 &&
                        currentTooth!.splittingWithImplant!.planPrice != 0) ||
                    (currentTooth!.gbrWithImplant != null && currentTooth!.gbrWithImplant!.planPrice != 0 && currentTooth!.gbrWithImplant!.planPrice != 0) ||
                    (currentTooth!.openSinusWithImplant != null &&
                        currentTooth!.openSinusWithImplant!.planPrice != 0 &&
                        currentTooth!.openSinusWithImplant!.planPrice != 0) ||
                    (currentTooth!.closedSinusWithImplant != null &&
                        currentTooth!.closedSinusWithImplant!.planPrice != 0 &&
                        currentTooth!.closedSinusWithImplant!.planPrice != 0) ||
                    (currentTooth!.extraction != null && currentTooth!.extraction!.planPrice != 0 && currentTooth!.extraction!.planPrice != 0) ||
                    (currentTooth!.restoration != null && currentTooth!.restoration!.planPrice != 0 && currentTooth!.restoration!.planPrice != 0) ||
                    (currentTooth!.rootCanalTreatment != null &&
                        currentTooth!.rootCanalTreatment!.planPrice != 0 &&
                        currentTooth!.rootCanalTreatment!.planPrice != 0) ||
                    (currentTooth!.scaling != null && currentTooth!.scaling!.planPrice != 0 && currentTooth!.scaling!.planPrice != 0) ||
                    (currentTooth!.crown != null && currentTooth!.crown!.planPrice != 0 && currentTooth!.crown!.planPrice != 0) ||
                    (currentTooth!.pontic != null && currentTooth!.pontic!.planPrice != 0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider()),
            Text(
              "Tooth",
              style: TextStyle(fontFamily: Inter_Bold, fontSize: viewOnlyMode ? 12 : 12),
            ),
            SizedBox(width: 10),
            FormTextValueWidget(text:toothID==0?"All": toothID.toString()),
            Expanded(child: Divider()),
          ],
        ),
      ),
      SizedBox(height: viewOnlyMode ? 1 : 2),
    ];
    if (returnValue.isNotEmpty) {
      title.addAll(returnValue);
      returnValue = title;
    }

    return returnValue;
  }
}
