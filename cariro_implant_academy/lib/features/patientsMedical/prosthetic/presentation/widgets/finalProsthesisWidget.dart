import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesis_DeliveryWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesis_HealingCollarWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/widgets/finalProsthesis_ImpressionsWidget.dart';
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

class FinalProsthesisWidget extends StatefulWidget {
  FinalProsthesisWidget({
    Key? key,
    required this.data,
    required this.patientId,
    this.fullArch = false,
  }) : super(key: key);
  ProstheticTreatmentFinalEntity data;
  bool fullArch;
  int patientId;

  @override
  State<FinalProsthesisWidget> createState() => _FinalProsthesisWidgetState();
}

class _FinalProsthesisWidgetState extends State<FinalProsthesisWidget> {
  List<int> selectedTeeth = [];
  late ProstheticBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ProstheticBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !widget.fullArch,
          child: BlocBuilder<ProstheticBloc, ProstheticBloc_States>(
            buildWhen: (previous, current) => current is ProstheticBloc_UpdateTeethViewState,
            builder: (context, state) {
              return CIA_TeethChart(
                onChange: (selectedTeethList) {
                  selectedTeeth = selectedTeethList;
                },
                selectedTeeth: selectedTeeth,
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: StatefulBuilder(
            builder: (context, _setState) {
              List<FinalProthesisParentEntity> models = <FinalProthesisParentEntity>[
                ...widget.data!.impressions ?? [],
                ...widget.data!.healingCollars ?? [],
                ...widget.data!.tryIns ?? [],
                ...widget.data!.delivery ?? [],
              ];
              models.sort(
                (a, b) => a.date?.compareTo(b.date ?? DateTime.now()) ?? 1,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CIA_SecondaryButton(
                          label: "Healing Collar",
                          icon: Icon(Icons.add),
                          onTab: () {
                            if (selectedTeeth.isEmpty && !widget.fullArch) {
                              ShowSnackBar(context, isSuccess: false, message: "Please select teeth!");
                            } else {
                              _setState(
                                () => widget.data.healingCollars = [
                                  ...widget.data.healingCollars!,
                                  FinalProthesisHealingCollarEntity(
                                    patientId: widget.patientId,
                                    date: DateTime.now(),
                                    finalProthesisTeeth: List.from(selectedTeeth),
                                    operatorId: siteController.getUserId(),
                                    operator: BasicNameIdObjectEntity(name: siteController.getUserName(), id: siteController.getUserId()),
                                  ),
                                ],
                              );
                              selectedTeeth.clear();
                              bloc.emit(ProstheticBloc_UpdateTeethViewState());
                            }
                          },
                        ),
                        SizedBox(width: 10),
                        CIA_SecondaryButton(
                          label: "Impression",
                          icon: Icon(Icons.add),
                          onTab: () {
                            if (selectedTeeth.isEmpty && !widget.fullArch) {
                              ShowSnackBar(context, isSuccess: false, message: "Please select teeth!");
                            } else {
                              _setState(
                                () => widget.data.impressions = [
                                  ...widget.data.impressions!,
                                  FinalProthesisImpressionEntity(
                                    patientId: widget.patientId,
                                    date: DateTime.now(),
                                    finalProthesisTeeth: List.from(selectedTeeth),
                                    operatorId: siteController.getUserId(),
                                    operator: BasicNameIdObjectEntity(name: siteController.getUserName(), id: siteController.getUserId()),
                                  ),
                                ],
                              );
                              selectedTeeth.clear();
                              bloc.emit(ProstheticBloc_UpdateTeethViewState());
                            }
                          },
                        ),
                        SizedBox(width: 10),
                        CIA_SecondaryButton(
                          label: "Try In",
                          icon: Icon(Icons.add),
                          onTab: () {
                            if (selectedTeeth.isEmpty && !widget.fullArch) {
                              ShowSnackBar(context, isSuccess: false, message: "Please select teeth!");
                            } else {
                              _setState(
                                () => widget.data.tryIns = [
                                  ...widget.data.tryIns!,
                                  FinalProthesisTryInEntity(
                                    patientId: widget.patientId,
                                    date: DateTime.now(),
                                    finalProthesisTeeth: List.from(selectedTeeth),
                                    operatorId: siteController.getUserId(),
                                    operator: BasicNameIdObjectEntity(name: siteController.getUserName(), id: siteController.getUserId()),
                                  ),
                                ],
                              );
                              selectedTeeth.clear();
                              bloc.emit(ProstheticBloc_UpdateTeethViewState());
                            }
                          },
                        ),
                        SizedBox(width: 10),
                        CIA_SecondaryButton(
                          label: "Delivery",
                          icon: Icon(Icons.add),
                          onTab: () {
                            if (selectedTeeth.isEmpty && !widget.fullArch) {
                              ShowSnackBar(context, isSuccess: false, message: "Please select teeth!");
                            } else {
                              _setState(
                                () => widget.data.delivery = [
                                  ...widget.data.delivery!,
                                  FinalProthesisDeliveryEntity(
                                    patientId: widget.patientId,
                                    date: DateTime.now(),
                                    finalProthesisTeeth: List.from(selectedTeeth),
                                    operatorId: siteController.getUserId(),
                                    operator: BasicNameIdObjectEntity(name: siteController.getUserName(), id: siteController.getUserId()),
                                  ),
                                ],
                              );
                              selectedTeeth.clear();
                              bloc.emit(ProstheticBloc_UpdateTeethViewState());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                        children: models.mapIndexed((i, e) {
                      if (e is FinalProthesisDeliveryEntity)
                        return FinalProsthesis_DeliveryWidget(
                          fullArch: widget.fullArch,
                          index: i + 1,
                          data: e,
                          onDelete: () => _setState(() => widget.data.delivery!.remove(e)),
                        );
                      else if (e is FinalProthesisTryInEntity)
                        return FinalProsthesis_TryInsWidget(
                          fullArch: widget.fullArch,
                          index: i + 1,
                          data: e,
                          patientId: widget.patientId,
                          onDelete: () => _setState(() => widget.data.tryIns!.remove(e)),
                        );
                      else if (e is FinalProthesisImpressionEntity)
                        return FinalProsthesis_ImpressionWidget(
                          fullArch: widget.fullArch,
                          index: i + 1,
                          patientId: widget.patientId,
                          data: e,
                          onDelete: () => _setState(() => widget.data.impressions!.remove(e)),
                        );
                      else if (e is FinalProthesisHealingCollarEntity)
                        return FinalProsthesis_HealingCollarWidget(
                          fullArch: widget.fullArch,
                          index: i + 1,
                          data: e,
                          onDelete: () => _setState(() => widget.data.healingCollars!.remove(e)),
                        );

                      return Container();
                    }).toList()),
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
