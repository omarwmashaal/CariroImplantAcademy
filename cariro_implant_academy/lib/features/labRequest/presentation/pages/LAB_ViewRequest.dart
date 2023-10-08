import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/finishTaskUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        } else if (state is LabRequestsBloc_FinishingTaskErrorState) ShowSnackBar(context, isSuccess: false, message: state.message);
        if (state is LabRequestsBloc_FinishingTaskState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
      },
      buildWhen: (previous, current) =>
          current is LabRequestsBloc_LoadedSingleRequestsSuccessfullyState ||
          current is LabRequestsBloc_LoadingRequestsState ||
          current is LabRequestsBloc_LoadingRequestsErrorState,
      builder: (context, state) {
        if (state is LabRequestsBloc_LoadedSingleRequestsSuccessfullyState)
        {
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
                          );
                        }),
                    SizedBox(width: 10),
                    Visibility(
                      visible: request.steps!.last.technicianId == request.customerId && request.customerId == siteController.getUserId(),
                      child: CIA_PrimaryButton(
                        label: "Waiting your action",
                        onTab: () async {
                          if (request.steps != null && request.steps!.isNotEmpty) {
                            if (request.steps!.length >= 2)
                              nextAssignId = request.steps![request.steps!.length - 2].technicianId;
                            else
                              nextAssignId = null;
                          }
                          await CIA_ShowPopUp(
                              context: context,
                              onSave: () async {
                                bloc.add(LabRequestsBloc_FinishTaskEvent(
                                  params: FinishTaskParams(
                                    id: widget.id,
                                    nextTaskId: nextTaskId,
                                    assignToId: nextAssignId,
                                    notes: thisStepNotes,
                                  ),
                                ));
                                return false;
                                //setState(() {});
                              },
                              child: Column(
                                children: [
                                  CIA_TextFormField(
                                    label: "Notes",
                                    maxLines: 5,
                                    onChange: (v) => thisStepNotes = v,
                                    controller: TextEditingController(
                                      text: thisStepNotes,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CIA_DropDownSearchBasicIdName(
                                    asyncUseCase: sl<GetDefaultStepsUseCase>(),
                                    label: "Next Step",
                                    onSelect: (value) {
                                      nextTaskId = value.id!;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ));
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Visibility(
                      visible: request.patientId != null && siteController.getSite() == Website.CIA,
                      child: CIA_SecondaryButton(
                          label: "Go To Patient",
                          onTab: () {
                            context.goNamed(PatientMedicalHistory.routeName, pathParameters: {"id": request.patientId.toString()});
                          }),
                    ),
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
                                    text:  request.source?.name??"",
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
                                    text:  request.customer?.name??"",
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
                                    text: "Assigend To",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(
                                    text: request.assignedTo?.name??"",
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
                                    text:  request.status?.name??"",
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
                                        visible: request.paid == false &&
                                            (request.status == EnumLabRequestStatus.FinishedAndHandeled ||
                                                request.status == EnumLabRequestStatus.FinishedNotHandeled),
                                        child: CIA_SecondaryButton(
                                          label: "Pay",
                                          onTab: () {
                                            CIA_ShowPopUp(
                                                width: 700,
                                                height: 500,
                                                context: context,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    TitleWidget(title: "Reciept"),
                                                    Expanded(
                                                      child: Column(
                                                        children: request.steps!
                                                            .map(
                                                              (e) => Padding(
                                                                padding: EdgeInsets.only(bottom: 5),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: FormTextValueWidget(
                                                                            text: e.date == null ? "" : DateFormat("dd-MM-yyyy").format(e.date!))),
                                                                    Expanded(
                                                                        child:
                                                                            FormTextValueWidget(text: "by: ${ e.technician?.name??""}")),
                                                                    Expanded(
                                                                      child: FormTextValueWidget(text: "${e.step?.name??""}"),
                                                                    ),
                                                                    Expanded(
                                                                        child: FormTextValueWidget(
                                                                      text: " ${(e.price ?? 0).toString()}",
                                                                      suffix: "EGP",
                                                                    ))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                    CIA_PrimaryButton(
                                                        label: "Pay",
                                                        onTab: () {
                                                          CIA_ShowPopUpYesNo(
                                                            context: context,
                                                            onSave: () async {
                                                             // var res = await LAB_RequestsAPI.PayForRequest(widget.id);
                                                            //  if (res.statusCode == 200) dialogHelper.dismissSingle(context);
                                                            //  ShowSnackBar(context, isSuccess: res.statusCode == 200);
                                                            //  setState(() {});
                                                            },
                                                          );
                                                        }),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        FormTextKeyWidget(text: "Total "),
                                                        FormTextValueWidget(text: (request.cost ?? 0).toString()),
                                                      ],
                                                    ),
                                                  ],
                                                ));
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 50),
                          child: SingleChildScrollView(
                              child: CIA_LAB_StepTimelineWidget(
                            steps: request.steps!,
                            customerId: request.customerId!,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        else if (state is LabRequestsBloc_LoadingRequestsState)
          return LoadingWidget();
        else if (state is LabRequestsBloc_LoadingRequestsErrorState) return BigErrorPageWidget(message: state.message);
        return Container();
      },
    );
  }
}
