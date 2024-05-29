import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/consumeLabItemUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../core/features/settings/domain/useCases/getLabItemsCompaniesUseCase.dart';
import '../../../../core/injection_contianer.dart';
import '../../domain/entities/labItemEntity.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../blocs/labRequestBloc.dart';

class LabRequestItemConsumeWidget extends StatefulWidget {
  LabRequestItemConsumeWidget({
    Key? key,
    required this.request,
  }) : super(key: key);
  LabRequestEntity request;

  @override
  State<LabRequestItemConsumeWidget> createState() => _LabRequestItemConsumeWidgetState();
}

class _LabRequestItemConsumeWidgetState extends State<LabRequestItemConsumeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTextKeyWidget(text: "Consume Item Details"),
        SizedBox(height: 10),
      ]..addAll((widget.request.labRequestStepItems!)
          .map(
            (e) => __LabRequestItemConsumeWidget(stepItem: e, parentItemId: 1),
          )
          .toList()),
    );
  }
}

class __LabRequestItemConsumeWidget extends StatefulWidget {
  __LabRequestItemConsumeWidget({
    Key? key,
    required this.stepItem,
    required this.parentItemId,
  }) : super(key: key);
  LabStepItemEntity stepItem;

  int parentItemId;

  @override
  State<__LabRequestItemConsumeWidget> createState() => __LabRequestItemConsumeWidgetState();
}

class __LabRequestItemConsumeWidgetState extends State<__LabRequestItemConsumeWidget> {
  BasicNameIdObjectEntity? company;

  BasicNameIdObjectEntity? line;

  LabStepItemEntity? stepItem;

  late LabRequestsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.stepItem == null
        ? Container()
        : BlocListener<LabRequestsBloc, LabRequestsBloc_States>(
            listener: (context, state) {
              if (state is LabRequestsBloc_ConsumingLabItemState)
                CustomLoader.show(context);
              else {
                CustomLoader.hide();
                if (state is LabRequestsBloc_ConsumingLabItemErrorState)
                  ShowSnackBar(context, isSuccess: false, message: state.message);
                else if (state is LabRequestsBloc_ConsumedLabItemSuccessfullyState) {
                  ShowSnackBar(context, isSuccess: true);
                  bloc.add(LabRequestsBloc_GetLabItemDetailsEvent(id: stepItem!.id!));
                } else if (state is LabRequestsBloc_LoadedLabItemSuccessfullyState && state.data.id == widget.stepItem?.labItemFromSettingsId) {
                  widget.stepItem!.consumedLabItem = state.data;
                  setState(() {});
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormTextKeyWidget(text: "Tooth: ${widget.stepItem.tooth==0?"All":widget.stepItem.tooth} || ${widget.stepItem.labItemFromSettings?.name ?? ""}"),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                          label: "Company",
                          asyncUseCase: sl<GetLabItemsCompaniesUseCase>(),
                          searchParams: widget.stepItem.labItemFromSettingsId,
                          selectedItem: company,
                          onSelect: (value) {
                            line = null;
                            stepItem = null;
                            bloc.emit(LabRequestsBloc_LoadingLabItemErrorState(message: "message"));
                            setState(() => company = value);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                          label: "Shade",
                          asyncUseCase: company == null ? null : sl<GetLabItemsLinesUseCase>(),
                          searchParams: company?.id,
                          emptyString: company?.id == null ? "Please Select Company First!" : "Empty",
                          selectedItem: line,
                          onSelect: (value) {
                            stepItem = null;
                            bloc.emit(LabRequestsBloc_LoadingLabItemErrorState(message: "message"));
                            setState(() => line = value);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                          enabled: stepItem?.consumedLabItem?.consumed != true,
                          label: "Size",
                          asyncUseCase: line == null ? null : sl<GetLabItemsUseCase>(),
                          searchParams: line?.id,
                          emptyString: line?.id == null ? "Please Select Shade First!" : "Empty",
                          selectedItem: widget.stepItem.consumedLabItem,
                          onSelect: (value) {
                            CIA_ShowPopUpYesNo(
                                context: context,
                                title: "Consume 1 from ${value.name} block?",
                                onSave: () {
                                  bloc.add(LabRequestsBloc_ConsumeLabItemEvent(
                                    params: ConsumeLabItemParams(id: value.id!, consumeWholeBlock: false, number: 1),
                                  ));
                                });
                            widget.stepItem!.consumedLabItemId = value.id;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                    buildWhen: (previous, current) =>
                        current is LabRequestsBloc_LoadedLabItemSuccessfullyState || current is LabRequestsBloc_LoadingLabItemErrorState,
                    builder: (context, state) {
                      if (state is LabRequestsBloc_LoadedLabItemSuccessfullyState && state.data.id == widget.stepItem?.labItemFromSettingsId) {
                        widget.stepItem!.consumedLabItem = state.data;
                      }

                      if (widget.stepItem.consumedLabItem != null) {
                        return Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Item: "),
                                  FormTextValueWidget(text: stepItem!.consumedLabItem?.name?.toString() ?? ""),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Consumed Count: "),
                                  FormTextValueWidget(text: "1"),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Block Consumed: "),
                                  FormTextValueWidget(text: stepItem!.consumedLabItem!.consumed == true ? "Yes" : "No"),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Visibility(
                              visible: stepItem!.consumedLabItem!.consumed != true,
                              child: CIA_SecondaryButton(
                                label: "Consume The Whole Block?",
                                onTab: () {
                                  bloc.add(LabRequestsBloc_ConsumeLabItemEvent(
                                    params: ConsumeLabItemParams(
                                      id: stepItem!.id!,
                                      consumeWholeBlock: true,
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          );
  }
}
