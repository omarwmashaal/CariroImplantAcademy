import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/finishTaskUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LAB_ViewTask.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LabRequestsSearchPage.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/widgets/labRequestItemReceiptWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/Controllers.dart';
import '../widgets/CIA_LAB_StepTimelineWidget.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/SnackBar.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/injection_contianer.dart';
import '../../../patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';
import '../../domain/entities/labRequestEntityl.dart';

class LAB_ViewRequestPage extends StatefulWidget {
  LAB_ViewRequestPage({Key? key, required this.id}) : super(key: key);
  int id;
  static String routeName = "ViewRequest";
  static String routeNameClinic = "ClinicViewRequest";
  static String routePath = "ViewRequest";
  static String routeCIAName = "ViewLabRequest";
  static String routeCIAPath = "ViewLabRequest/:id";

  @override
  State<LAB_ViewRequestPage> createState() => _LAB_ViewRequestPageState();
}

class _LAB_ViewRequestPageState extends State<LAB_ViewRequestPage> {
  late LabRequestEntity request;
  int? nextAssignId;
  int? nextTaskId;
  String? thisStepNotes = "";
  late LabRequestsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //siteController.setAppBarWidget();

    return BlocConsumer<LabRequestsBloc, LabRequestsBloc_States>(
      bloc: bloc,
      listener: (context, state) {
        if (state is LabRequestsBloc_FinishedTaskSuccessfullyState) {
          thisStepNotes = null;
          nextAssignId = null;
          nextTaskId = null;
          ShowSnackBar(context, isSuccess: true);
          dialogHelper.dismissSingle(context);
        } else if (state is LabRequestsBloc_DeletingRequestErrorState) {
          ShowSnackBar(context, isSuccess: false, message: state.message);
        } else if (state is LabRequestsBloc_DeletedRequestsSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
          context.goNamed(LabRequestsSearchPage.routeAllName);
        } else if (state is LabRequestsBloc_FinishingTaskErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is LabRequestsBloc_PayingRequestErrorState) {
          ShowSnackBar(context, isSuccess: false, message: state.message);
        } else if (state is LabRequestsBloc_PaidRequestSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
          dialogHelper.dismissAll(context);
          bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
        }
        if (state is LabRequestsBloc_FinishingTaskState ||
            state is LabRequestsBloc_PayingRequestState ||
            state is LabRequestsBloc_DeletingRequestState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
      },
      buildWhen: (previous, current) =>
          current is LabRequestsBloc_LoadedSingleRequestsSuccessfullyState ||
          current is LabRequestsBloc_LoadingRequestsState ||
          current is LabRequestsBloc_LoadingSingleRequestErrorState,
      builder: (context, state) {
        if (state is LabRequestsBloc_LoadedSingleRequestsSuccessfullyState) {
          request = state.request;
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    TitleWidget(
                      title: "Request Details",
                      showBackButton: true,
                    ),
                    SizedBox(width: 10),
                    CIA_SecondaryButton(
                        label: "Medical Info",
                        onTab: () {
                          context.goNamed(LAB_ViewTaskPage.routeName, pathParameters: {"id": widget.id.toString()});
                          /*
                          var medicalInfo = request.getMedicalInfoList();
                          CIA_ShowPopUp(
                            context: context,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    FormTextKeyWidget(text: "Teeth: "),
                                    FormTextValueWidget(text: () {
                                      var r = "";
                                      (request.teeth ?? []).forEach((e) => r += "${e.toString()}, ");
                                      return r;
                                    }()),
                                  ],
                                ),
                                Container(alignment: AlignmentDirectional.centerStart, child: FormTextKeyWidget(text: "Required: ")),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: medicalInfo.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(medicalInfo[index]),
                                      );
                                    },
                                  ),
                                ),
                                Container(alignment: AlignmentDirectional.centerStart, child: FormTextKeyWidget(text: "Notes: ")),
                                Expanded(child: FormTextValueWidget(text: request.notes ?? ""))
                              ],
                            ),
                          );*/
                        }),
                    SizedBox(width: 10),
                    Visibility(
                      visible: request.patientId != null && siteController.getSite() == Website.CIA,
                      child: CIA_SecondaryButton(
                          label: "Go To Patient",
                          onTab: () {
                            context.goNamed(PatientMedicalHistory.getRouteName(), pathParameters: {"id": request.patientId.toString()});
                          }),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        FormTextValueWidget(text: request.status2?.name ?? ""),
                        SizedBox(width: 10),
                        FormTextValueWidget(text: (request.free ?? false) ? "Free" : "Not Free"),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    CIA_PrimaryButton(
                      label: "Delete Request",
                      onTab: () {
                        CIA_ShowPopUpYesNo(
                            context: context,
                            title: "Deleting request might not work if items used or receipt created!",
                            onSave: () {
                              bloc.add(LabRequestsBloc_DeleteRequestEvent(id: widget.id));
                            });
                      },
                      color: Colors.red,
                      isLong: true,
                      icon: Icon(Icons.delete),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "ID",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.id.toString(),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Date Added",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(request.date!),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Source",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.source?.name ?? "",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Requester Name",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.customer?.name ?? "",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Requester Phone",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.customer == null ? "" : request.customer!.phoneNumber,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Patient Name",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.patient == null ? "" : request.patient!.name,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Designer",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.designer?.name ?? "",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Assigend To",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.assignedTo?.name ?? "",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Current Status",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.status?.name ?? "",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Payment Status",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.paid! ? "Paid" : "Not paid",
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Cost",
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      FormTextValueWidget(
                                        text: request.cost == null ? "0" : request.cost.toString(),
                                        suffix: "EGP",
                                      ),
                                      Visibility(
                                        visible: (request.status == EnumLabRequestStatus.Finished),
                                        child: request.paid == true || (request.free ?? false)
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  ),
                                                  (request.free ?? false) ? FormTextValueWidget(text: " Free Request") : SizedBox()
                                                ],
                                              )
                                            : CIA_SecondaryButton(
                                                label: "Pay",
                                                onTab: () {
                                                  int amountToPay = (request.cost ?? 0) - (request.paidAmount ?? 0);
                                                  CIA_ShowPopUp(
                                                      width: 700,
                                                      height: 500,
                                                      context: context,
                                                      child: StatefulBuilder(builder: (context, __setState) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            TitleWidget(title: "Reciept"),
                                                            Expanded(
                                                              child: LabRequestItemReceiptWidget(
                                                                request: request,
                                                                viewOnly: true,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: CIA_TextFormField(
                                                                label: "Amount to pay",
                                                                controller: TextEditingController(text: amountToPay.toString()),
                                                                onChange: (value) {
                                                                  if ((request.paidAmount ?? 0) + (int.tryParse(value) ?? 0) <= (request.cost ?? 0)) {
                                                                    amountToPay = (int.tryParse(value) ?? 0);
                                                                  } else {
                                                                    __setState(() => null);
                                                                  }
                                                                },
                                                                isNumber: true,
                                                              ),
                                                            ),
                                                            CIA_PrimaryButton(
                                                                label: "Pay",
                                                                onTab: () {
                                                                  CIA_ShowPopUpYesNo(
                                                                    context: context,
                                                                    title: "Pay Request for ${amountToPay}?",
                                                                    onSave: () async {
                                                                      bloc.add(LabRequestsBloc_PayRequestEvent(id: request.id!, amount: amountToPay));
                                                                    },
                                                                  );
                                                                }),
                                                          ],
                                                        );
                                                      }));
                                                },
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Payed Amount",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    suffix: "EGP",
                                    text: request.paidAmount == null ? "0" : request.paidAmount.toString(),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: !(request.designerId == siteController.getUserId() ?? false),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: FormTextKeyWidget(
                                      text: "Delivery Date",
                                    ),
                                  ),
                                  Expanded(
                                    child: FormTextValueWidget(
                                      text: request.deliveryDate == null ? "" : DateFormat("dd-MM-yyyy").format(request.deliveryDate!),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CIA_SecondaryButton(
                                width: 300,
                                label: "Click to View Notes From Tech",
                                icon: Icon(Icons.notes),
                                onTab: () => CIA_ShowPopUp(context: context, child: FormTextValueWidget(text: request.notesFromTech)),
                              ),
                              SizedBox(height: 10),
                              CIA_SecondaryButton(
                                width: 300,
                                label: "Click to View Notes From Customer",
                                icon: Icon(Icons.notes),
                                onTab: () => CIA_ShowPopUp(context: context, child: FormTextValueWidget(text: request.notes)),
                              ),
                              SizedBox(height: 10),
                              Visibility(
                                visible: request.status == EnumLabRequestStatus.Finished,
                                child: CIA_SecondaryButton(
                                  width: 300,
                                  label: "Receipt",
                                  icon: Icon(Icons.attach_money),
                                  onTab: () => CIA_ShowPopUp(
                                    height: 600,
                                    width: double.maxFinite,
                                    context: context,
                                    child: LabRequestItemReceiptWidget(
                                      request: request,
                                      viewOnly: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is LabRequestsBloc_LoadingRequestsState)
          return LoadingWidget();
        else if (state is LabRequestsBloc_LoadingSingleRequestErrorState) return BigErrorPageWidget(message: state.message);
        return Container();
      },
    );
  }
}
