import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestItemEntity.dart';
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
        __LabRequestItemConsumeWidget(item: widget.request.zirconUnit, parentItemId: 1, label: "Zircon Unit"),
        __LabRequestItemConsumeWidget(item: widget.request.pfm, parentItemId: 2, label: "PFM"),
        __LabRequestItemConsumeWidget(item: widget.request.compositeInlay, parentItemId: 3, label: "Composite Inlay"),
        __LabRequestItemConsumeWidget(item: widget.request.emaxVeneer, parentItemId: 4, label: "Emax Veneer"),
        __LabRequestItemConsumeWidget(item: widget.request.milledPMMA, parentItemId: 5, label: "Milled PMMA"),
        __LabRequestItemConsumeWidget(item: widget.request.printedPMMA, parentItemId: 6, label: "Printed PMMA"),
        __LabRequestItemConsumeWidget(item: widget.request.tiAbutment, parentItemId: 7, label: "Ti Abutment"),
        __LabRequestItemConsumeWidget(item: widget.request.tiBar, parentItemId: 8, label: "Ti Bar"),
        __LabRequestItemConsumeWidget(item: widget.request.threeDPrinting, parentItemId: 9, label: "3D Printing"),
        __LabRequestItemConsumeWidget(item: widget.request.waxUp, parentItemId: 10, label: "Wax Up"),
      ],
    );
  }
}

class __LabRequestItemConsumeWidget extends StatefulWidget {
  __LabRequestItemConsumeWidget({
    Key? key,
    required this.item,
    required this.parentItemId,
    required this.label,
  }) : super(key: key);
  LabRequestItemEntity? item;

  int parentItemId;
  String label;

  @override
  State<__LabRequestItemConsumeWidget> createState() => __LabRequestItemConsumeWidgetState();
}

class __LabRequestItemConsumeWidgetState extends State<__LabRequestItemConsumeWidget> {
  BasicNameIdObjectEntity? company;

  BasicNameIdObjectEntity? line;

  LabItemEntity? item;

  late LabRequestsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    item = widget.item?.labItem;
    return widget.item == null
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
                  bloc.add(LabRequestsBloc_GetLabItemDetailsEvent(id: item!.id!));
                }
                else if(state is LabRequestsBloc_LoadedLabItemSuccessfullyState && state.data.id==widget.item?.labItemId) {
                  widget.item!.labItem = state.data;
                  item = state.data;
                  setState(() {

                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormTextKeyWidget(text: widget.label),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                          label: "Company",
                          asyncUseCase: sl<GetLabItemsCompaniesUseCase>(),
                          searchParams: widget.parentItemId,
                          selectedItem: company,
                          onSelect: (value) {
                            line = null;
                            item = null;
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
                            item = null;
                            bloc.emit(LabRequestsBloc_LoadingLabItemErrorState(message: "message"));
                            setState(() => line = value);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                          enabled: item?.consumed != true,
                          label: "Size",
                          asyncUseCase: line == null ? null : sl<GetLabItemsUseCase>(),
                          searchParams: line?.id,
                          emptyString: line?.id == null ? "Please Select Shade First!" : "Empty",
                          selectedItem: item,
                          onSelect: (value) {
                            CIA_ShowPopUpYesNo(
                                context: context,
                                title: "Consume ${widget.item?.number ?? 0} from this block?",
                                onSave: () {
                                  bloc.add(LabRequestsBloc_ConsumeLabItemEvent(
                                    params: ConsumeLabItemParams(id: value.id!, consumeWholeBlock: false, number: widget.item?.number!),
                                  ));
                                });
                            item = value as LabItemEntity;
                            widget.item!.labItem = item;
                            widget.item!.labItemId = item?.id;
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
                      if (state is LabRequestsBloc_LoadedLabItemSuccessfullyState && state.data.id == widget.item?.labItemId) {
                        item = state.data;
                        widget.item!.labItem = state.data;
                      }

                      if (item != null) {
                        return Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Item: "),
                                  FormTextValueWidget(text: item!.name!.toString()),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Consumed Count: "),
                                  FormTextValueWidget(text: item!.consumedCount!.toString()),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(text: "Block Consumed: "),
                                  FormTextValueWidget(text: item!.consumed == true ? "Yes" : "No"),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Visibility(
                              visible: item!.consumed != true,
                              child: CIA_SecondaryButton(
                                label: "Consume The Whole Block?",
                                onTab: () {
                                  bloc.add(LabRequestsBloc_ConsumeLabItemEvent(
                                    params: ConsumeLabItemParams(
                                      id: item!.id!,
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
