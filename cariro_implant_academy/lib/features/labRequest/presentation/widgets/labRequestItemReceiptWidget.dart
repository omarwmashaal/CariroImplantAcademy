import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/consumeLabItemUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../core/features/settings/domain/useCases/getLabItemsCompaniesUseCase.dart';
import '../../../../core/injection_contianer.dart';
import '../../domain/entities/OmarEntity.dart';
import '../../domain/entities/labItemEntity.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../blocs/labRequestBloc.dart';

class LabRequestItemReceiptWidget extends StatefulWidget {
  LabRequestItemReceiptWidget({
    Key? key,
    required this.request,
    required this.onTotalCalculated,
    this.viewOnly = false,
  }) : super(key: key);
  LabRequestEntity request;
  Function(int total) onTotalCalculated;
  bool viewOnly;

  @override
  State<LabRequestItemReceiptWidget> createState() => _LabRequestItemReceiptWidgetState();
}

class _LabRequestItemReceiptWidgetState extends State<LabRequestItemReceiptWidget> {
  int tempTotal = 0;

  var overAllTotal = 0.obs;
  late LabRequestsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.onTotalCalculated(overAllTotal.value);
      print("Total Function called");
    });

    bloc.add(LabRequestsBloc_GetLabRequestReceiptEvent(id: widget.request.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
      buildWhen: (previous, current) =>
          current is LabRequestsBloc_LoadedLabReceiptuccessfullyState ||
          current is LabRequestsBloc_LoadingLabReceiptErrorState ||
          current is LabRequestsBloc_LoadingLabReceiptState,
      builder: (context, state) {
        if (state is LabRequestsBloc_LoadedLabReceiptuccessfullyState) {
          ReceiptEntity? receipt;
          receipt = state.data;
          if (receipt == null) {
            tempTotal = 0;
            overAllTotal.value = 0;
            if (!(widget.request.free ?? false)) {
              tempTotal += widget.request.zirconUnit?.totalPrice ?? 0;
              tempTotal += widget.request.pfm?.totalPrice ?? 0;
              tempTotal += widget.request.compositeInlay?.totalPrice ?? 0;
              tempTotal += widget.request.emaxVeneer?.totalPrice ?? 0;
              tempTotal += widget.request.milledPMMA?.totalPrice ?? 0;
              tempTotal += widget.request.printedPMMA?.totalPrice ?? 0;
              tempTotal += widget.request.tiAbutment?.totalPrice ?? 0;
              tempTotal += widget.request.tiBar?.totalPrice ?? 0;
              tempTotal += widget.request.threeDPrinting?.totalPrice ?? 0;
              tempTotal += widget.request.waxUp?.totalPrice ?? 0;
            }
            overAllTotal.value = tempTotal + (widget.request.labFees ?? 0);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormTextKeyWidget(text: "Receipt Details"),
              SizedBox(height: 10),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.zirconUnit : widget.request.zirconUnit,
                  parentItemId: 1,
                  label: "Zircon Unit"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false), item: receipt != null ? receipt.pfm : widget.request.pfm, parentItemId: 2, label: "PFM"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.compositeInlay : widget.request.compositeInlay,
                  parentItemId: 3,
                  label: "Composite Inlay"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.emaxVeneer : widget.request.emaxVeneer,
                  parentItemId: 4,
                  label: "Emax Veneer"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.milledPMMA : widget.request.milledPMMA,
                  parentItemId: 5,
                  label: "Milled PMMA"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.printedPMMA : widget.request.printedPMMA,
                  parentItemId: 6,
                  label: "Printed PMMA"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.tiAbutment : widget.request.tiAbutment,
                  parentItemId: 7,
                  label: "Ti Abutment"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.tiBar : widget.request.tiBar,
                  parentItemId: 8,
                  label: "Ti Bar"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.threeDPrinting : widget.request.threeDPrinting,
                  parentItemId: 9,
                  label: "3D Printing"),
              __LabRequestItemReceiptWidget(
                  free: (widget.request.free ?? false),
                  item: receipt != null ? receipt.waxUp : widget.request.waxUp,
                  parentItemId: 10,
                  label: "Wax Up"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 300,
                  child: widget.viewOnly
                      ? Row(
                          children: [
                            Expanded(child: FormTextKeyWidget(text: "Lab Fees ")),
                            Expanded(flex: 2, child: SizedBox()),
                            Expanded(
                                child: FormTextValueWidget(
                                    text: "total price: EGP ${receipt != null ? receipt.labFees : widget.request.labFees?.toString()}")),
                          ],
                        )
                      : CIA_TextFormField(
                          label: "Add Lab Price",
                          isNumber: true,
                          controller: TextEditingController(text: (widget.request.labFees ?? 0).toString()),
                          onChange: (value) {
                            widget.request.labFees = int.parse(value);

                            overAllTotal.value = (widget.request.labFees ?? 0) + tempTotal;
                            widget.onTotalCalculated(overAllTotal.value);
                            //setState(() {});
                          },
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () {
                      overAllTotal.value;
                      return Text(
                        "Total: EGP ${receipt != null ? receipt.total : overAllTotal}",
                        style: TextStyle(fontSize: 20),
                      );
                    },
                  )
                ],
              )
            ],
          );
        } else if (state is LabRequestsBloc_LoadingLabReceiptErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is LabRequestsBloc_LoadingLabReceiptState) return LoadingWidget();
        return Container();
      },
    );
  }
}

class __LabRequestItemReceiptWidget extends StatefulWidget {
  __LabRequestItemReceiptWidget({
    Key? key,
    required this.item,
    required this.parentItemId,
    required this.label,
    this.free = false,
  }) : super(key: key);
  OmarEntity? item;

  int parentItemId;
  String label;
  bool free;

  @override
  State<__LabRequestItemReceiptWidget> createState() => __LabRequestItemReceiptWidgetState();
}

class __LabRequestItemReceiptWidgetState extends State<__LabRequestItemReceiptWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      widget.item!.totalPrice = widget.free ? 0 : widget.item!.price! * widget.item!.number!;
    }
    return widget.item == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(child: FormTextKeyWidget(text: widget.label)),
                Expanded(child: FormTextValueWidget(text: "unit price: EGP ${widget.item!.price ?? 0}")),
                Expanded(child: FormTextValueWidget(text: "number used: ${widget.item!.number ?? 0}")),
                Expanded(child: FormTextValueWidget(text: "total price: EGP ${widget.item!.totalPrice ?? 0}")),
              ],
            ),
          );
  }
}
