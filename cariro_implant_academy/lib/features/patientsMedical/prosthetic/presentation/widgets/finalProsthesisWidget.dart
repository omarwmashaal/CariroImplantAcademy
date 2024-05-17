import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesis_StepWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesis_TryInsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../../../labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';
import '../../domain/entities/finalProsthesisParentEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';
import '../../domain/entities/prostheticFinalEntity.dart';
import '../../domain/enums/enum.dart';

class FinalProsthesisStepWidget extends StatelessWidget {
  FinalProsthesisStepWidget({
    Key? key,
    required this.data,
    required this.patientId,
    this.fullArch = false,
  }) : super(key: key);
  List<ProstheticStepEntity> data;
  bool fullArch;
  int patientId;

  List<int> selectedTeeth = [];

  bool upperArch = false;

  bool lowerArch = false;

  bool screwRetained = false;

  bool cementRetained = false;

  late ProstheticBloc bloc;

  List<BasicNameIdObjectEntity> finalItems = [];

  late SettingsBloc settingsBloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProstheticBloc>(context);
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.add(SettingsBloc_GetProstheticItemsEvent(type: EnumProstheticType.Final));

    return Column(
      children: [
        BlocBuilder<ProstheticBloc, ProstheticBloc_States>(
          buildWhen: (previous, current) => current is ProstheticBloc_UpdateTeethViewState,
          builder: (context, state) {
            return fullArch
                ? Row(
                    children: [
                      FormTextValueWidget(text: "Arch: "),
                      CIA_MultiSelectChipWidget(
                        labels: [
                          CIA_MultiSelectChipWidgeModel(label: "Upper"),
                          CIA_MultiSelectChipWidgeModel(label: "Lower"),
                        ],
                        onChangeList: (data) {
                          upperArch = false;
                          lowerArch = false;
                          if (data.contains("Upper")) upperArch = true;
                          if (data.contains("Lower")) lowerArch = true;
                        },
                      ),
                      SizedBox(width: 10),
                      VerticalDivider(
                        width: 2,
                      ),
                      SizedBox(width: 10),
                      FormTextValueWidget(text: "Type: "),
                      CIA_MultiSelectChipWidget(
                        labels: [
                          CIA_MultiSelectChipWidgeModel(label: "Screw Retained"),
                          CIA_MultiSelectChipWidgeModel(label: "Cement Retaind"),
                        ],
                        singleSelect: true,
                        onChange: (item, isSelected) {
                          screwRetained = false;
                          cementRetained = false;
                          screwRetained = isSelected & item.contains("Screw");
                          cementRetained = isSelected & item.contains("Cement");
                        },
                      ),
                    ],
                  )
                : CIA_TeethChart(
                    onChange: (selectedTeethList) {
                      selectedTeeth = selectedTeethList;
                    },
                    selectedTeeth: selectedTeeth,
                  );
          },
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: StatefulBuilder(
            builder: (context, _setState) {
              data.sort(
                (a, b) => a.date?.compareTo(b.date ?? DateTime.now()) ?? 1,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<SettingsBloc, SettingsBloc_States>(
                    buildWhen: (previous, current) => current is SettingsBloc_LoadedProstheticItemsSuccessfullyState,
                    builder: (context, state) {
                      if (state is SettingsBloc_LoadedProstheticItemsSuccessfullyState) {
                        finalItems = state.data;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              children: finalItems
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CIA_SecondaryButton(
                                        label: e.name ?? "",
                                        icon: Icon(Icons.add),
                                        onTab: () {
                                          if (selectedTeeth.isEmpty && !fullArch) {
                                            ShowSnackBar(context, isSuccess: false, message: "Please select teeth!");
                                          } else if (upperArch == false && lowerArch == false && fullArch) {
                                            ShowSnackBar(context, isSuccess: false, message: "Please select Arch!");
                                          } else if (screwRetained == false && cementRetained == false && fullArch) {
                                            ShowSnackBar(context, isSuccess: false, message: "Please Choose Arch Type!");
                                          } else if (fullArch) {
                                            _setState(
                                              () => data = [
                                                ...data,
                                                ProstheticStepEntity(
                                                  date: DateTime.now(),
                                                  item: e,
                                                  itemId: e.id,
                                                  patientId: patientId,
                                                  operator: BasicNameIdObjectEntity(
                                                    name: siteController.getUserName(),
                                                    id: siteController.getUserId(),
                                                  ),
                                                  operatorId: siteController.getUserId(),
                                                  fullArchLower: lowerArch,
                                                  fullArchUpper: upperArch,
                                                  screwRetained: screwRetained,
                                                  cementRetained: cementRetained,
                                                ),
                                              ],
                                            );
                                          } else if (!fullArch) {
                                            _setState(
                                              () => data = [
                                                ...data,
                                                ProstheticStepEntity(
                                                  date: DateTime.now(),
                                                  item: e,
                                                  itemId: e.id,
                                                  patientId: patientId,
                                                  operator: BasicNameIdObjectEntity(
                                                    name: siteController.getUserName(),
                                                    id: siteController.getUserId(),
                                                  ),
                                                  operatorId: siteController.getUserId(),
                                                  single: selectedTeeth.length == 1,
                                                  bridge: selectedTeeth.length > 1,
                                                  teeth: selectedTeeth,
                                                ),
                                              ],
                                            );
                                          }

                                          selectedTeeth.clear();
                                          upperArch = false;
                                          lowerArch = false;
                                          bloc.emit(ProstheticBloc_UpdateTeethViewState());
                                        },
                                      ),
                                    ),
                                  )
                                  .toList()),
                        );
                      }
                      return Container();
                    },
                  ),
                  Expanded(
                    child: ListView(
                        children: data
                            .mapIndexed((i, e) => FinalProsthesis_StepWidget(
                                  fullArch: fullArch,
                                  index: i + 1,
                                  data: e,
                                  onDelete: () => _setState(() => data.remove(e)),
                                ))
                            .toList()),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
