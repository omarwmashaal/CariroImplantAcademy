import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/addOrUpdateRequestReceiptUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/assignTaskToTechnicianUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/finishTaskUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/markRequestAsDoneUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/injection_contianer.dart';
import '../../../../core/presentation/widgets/LoadingWidget.dart';
import '../../../patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../blocs/labRequestBloc.dart';
import '../blocs/labRequestsBloc_Events.dart';
import '../widgets/CIA_LAB_StepTimelineWidget.dart';

class LAB_ViewTaskPage extends StatefulWidget {
  LAB_ViewTaskPage({Key? key, required this.id}) : super(key: key);
  int id;
  static String routeName = "ViewTask";
  static String routePath = "ViewTask";

  @override
  State<LAB_ViewTaskPage> createState() => _LAB_ViewTaskPageState();
}

class _LAB_ViewTaskPageState extends State<LAB_ViewTaskPage> {
  late LabRequestEntity request;

  int? nextAssignId;
  int? nextTaskId;
  String? thisStepNotes = "";
  late LabRequestsBloc bloc;
  bool editMode = true;
  int totalPrice = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
    //siteController.setAppBarWidget();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LabRequestsBloc, LabRequestsBloc_States>(
      listener: (context, state) {
        if (state is LabRequestsBloc_MarkingRequestAsDoneState ||
            state is LabRequestsBloc_UpdatingRequestReceiptState ||
            state is LabRequestsBloc_AssigningTaskToATechnicianState ||
            state is LabRequestsBloc_FinishingTaskState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
        if (state is LabRequestsBloc_UpdateReceiptTotalPriceState) {
          totalPrice = state.totalPrice;
        } else if (state is LabRequestsBloc_MarkedRequestAsDoneSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
        } else if (state is LabRequestsBloc_MarkingRequestAsDoneErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is LabRequestsBloc_UpdatedRequestReceiptSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
          bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
        } else if (state is LabRequestsBloc_UpdatingRequestErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is LabRequestsBloc_AssignedTaskToATechnicianSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
          bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
        } else if (state is LabRequestsBloc_AssigningTaskToATechnicianErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is LabRequestsBloc_FinishedTaskSuccessfullyState) {
          thisStepNotes = null;
          nextAssignId = null;
          nextTaskId = null;
          ShowSnackBar(context, isSuccess: true);
          dialogHelper.dismissSingle(context);
          bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
        } else if (state is LabRequestsBloc_FinishingTaskErrorState) ShowSnackBar(context, isSuccess: false, message: state.message);
      },
      builder: (context, state) {
        if (state is LabRequestsBloc_LoadingRequestsState)
          return LoadingWidget();
        else if (state is LabRequestsBloc_LoadingRequestsErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is LabRequestsBloc_LoadedSingleRequestsSuccessfullyState) {
          request = state.request;
          int t = 0;
          request.steps!.forEach((element) {
            t += element.price ?? 0;
          });
          totalPrice = t;
          return Column(
            children: [
              Row(
                children: [
                  TitleWidget(
                    title: siteController.getRole() == "technician" ? "Task Details" : "Request Details",
                    showBackButton: true,
                  ),
                  SizedBox(width: 10),
                  CIA_SecondaryButton(
                      label: "Request Info",
                      onTab: () {
                        CIA_ShowPopUp(
                          context: context,
                          title: "Non-Medical Details",
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                                    text: request.source == null ? "" : EnumLabRequestSources.values[request.source!.index].name,
                                  ),
                                )
                              ],
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
                                    text: request.customer == null ? "" : request.customer!.name,
                                  ),
                                )
                              ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FormTextKeyWidget(
                                    text: "Current Step",
                                  ),
                                ),
                                Expanded(
                                  child: FormTextValueWidget(text: request.steps!.last.step!.name),
                                )
                              ],
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
                                    text: request.status == null ? "" : EnumLabRequestStatus.values[request.status!.index].name,
                                  ),
                                )
                              ],
                            ),
                          ]),
                        );
                      }),
                  Visibility(
                    visible: request.patientId != null && siteController.getSite() == Website.CIA,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        CIA_SecondaryButton(
                            label: "Go To Patient",
                            onTab: () {
                              context.goNamed(PatientMedicalHistory.routeName, pathParameters: {"id": request.patientId.toString()});
                            }),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      RoundCheckBox(
                        disabledColor: Colors.green,
                        onTap: request.status == EnumLabRequestStatus.FinishedAndHandeled || request.status == EnumLabRequestStatus.FinishedNotHandeled
                            ? null
                            : (value) async {
                                await CIA_ShowPopUpYesNo(
                                  context: context,
                                  title: "Mark request as finished?",
                                  onSave: () => bloc.add(LabRequestsBloc_MarkRequestAsDoneEvent(
                                    params: MarkRequestAsDoneParams(
                                      requestId: widget.id,
                                      notes: thisStepNotes,
                                    ),
                                  )),
                                );
                              },
                      ),
                      FormTextKeyWidget(
                          text: request.status == EnumLabRequestStatus.FinishedAndHandeled || request.status == EnumLabRequestStatus.FinishedNotHandeled
                              ? "Request Completed"
                              : "Mark as Completed")
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                          SizedBox(
                            height: 10,
                          ),
                          FormTextKeyWidget(text: "Required: "),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: request.getMedicalInfoList().length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(request.getMedicalInfoList()[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormTextKeyWidget(text: "Notes: "),
                          FormTextValueWidget(text: request.notes ?? ""),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: siteController.getRole() == "technician",
                            child: Container(
                              child: request.status == EnumLabRequestStatus.FinishedAndHandeled || request.status == EnumLabRequestStatus.FinishedNotHandeled
                                  ? Expanded(
                                      flex: 10,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Receipt",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                                ),
                                                BlocBuilder(
                                                  buildWhen: (previous, current) => current is LabRequestsBloc_SwitchEditViewReceiptModeState,
                                                  builder: (context, state) => CIA_SecondaryButton(
                                                      label: editMode ? "View Mode" : "Edit Mode",
                                                      onTab: () {
                                                        editMode = !editMode;
                                                        bloc.emit(LabRequestsBloc_SwitchEditViewReceiptModeState());
                                                      }),
                                                ),
                                                CIA_PrimaryButton(
                                                    label: "Save Receipt",
                                                    onTab: () => bloc.add(LabRequestsBloc_AddOrUpdateRequestReceiptEvent(
                                                          params: AddOrUpdateRequestReceiptParams(
                                                            id: widget.id,
                                                            steps: request.steps ?? [],
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                              buildWhen: (previous, current) => current is LabRequestsBloc_SwitchEditViewReceiptModeState,
                                              builder: (context, state) {
                                                return Column(
                                                  children: request.steps!
                                                      .map(
                                                        (e) => Padding(
                                                          padding: EdgeInsets.only(bottom: editMode ? 10 : 5),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  child: FormTextValueWidget(
                                                                      text: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!))),
                                                              Expanded(
                                                                  child: FormTextValueWidget(text: "by: ${e.technician == null ? "" : e.technician!.name}")),
                                                              Expanded(
                                                                child: editMode
                                                                    ? CIA_TextFormField(
                                                                        isNumber: true,
                                                                        label: e.step!.name!,
                                                                        suffix: "EGP",
                                                                        controller: TextEditingController(text: (e.price ?? 0).toString()),
                                                                        onChange: (v) {
                                                                          e.price = int.parse(v);
                                                                          int total = 0;
                                                                          request.steps!.forEach((element) {
                                                                            total += element.price ?? 0;
                                                                          });
                                                                          totalPrice = total;
                                                                          bloc.emit(LabRequestsBloc_UpdateReceiptTotalPriceState(totalPrice: total));
                                                                        },
                                                                      )
                                                                    : FormTextValueWidget(text: "${e.step!.name!}"),
                                                              ),
                                                              editMode
                                                                  ? Container()
                                                                  : Expanded(
                                                                      child: FormTextValueWidget(
                                                                      text: " ${(e.price ?? 0).toString()}",
                                                                      suffix: "EGP",
                                                                    ))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(flex: 3, child: SizedBox()),
                                                BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                                  buildWhen: (previous, current) => current is LabRequestsBloc_UpdateReceiptTotalPriceState,
                                                  builder: (context, state) {
                                                    if (state is LabRequestsBloc_UpdateReceiptTotalPriceState) totalPrice = state.totalPrice;
                                                    return Expanded(
                                                        child: FormTextValueWidget(
                                                      text: totalPrice.toString(),
                                                      suffix: "EGP",
                                                    ));
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : request.steps!.last.technicianId == request.customerId
                                      ? Row(
                                          children: [
                                            Text("Waiting for Customer Action!"),
                                            SizedBox(width: 10),
                                            CIA_PrimaryButton(
                                              label: "Customer Approved?",
                                              onTab: () async {
                                                CIA_ShowPopUp(
                                                    context: context,
                                                    onSave: () {
                                                      bloc.add(LabRequestsBloc_FinishTaskEvent(
                                                        params: FinishTaskParams(
                                                          id: widget.id,
                                                          nextTaskId: nextTaskId,
                                                          assignToId: null,
                                                          notes: null,
                                                        ),
                                                      ));
                                                    },
                                                    child: Column(
                                                      children: [
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
                                              },
                                            ),
                                          ],
                                        )
                                      : request.assignedToId == siteController.getUserId()
                                          ? Column(
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                                        asyncUseCase: sl<LoadUsersUseCase>(),
                                                        searchParams: LoadUsersEnum.technicians,
                                                        label: "Assign next step to another one",
                                                        onSelect: (value) {
                                                          nextAssignId = value.id!;
                                                          // setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    FormTextKeyWidget(text: "Or Assign to customer?"),
                                                    SizedBox(width: 10),
                                                    RoundCheckBox(
                                                      isChecked: nextAssignId == request.customerId,
                                                      onTap: (isSelected) {
                                                        if (isSelected == true)
                                                          nextAssignId = request.customerId;
                                                        else
                                                          nextAssignId = null;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                CIA_PrimaryButton(
                                                  label: "Finish Task",
                                                  onTab: () async {
                                                    bloc.add(LabRequestsBloc_FinishTaskEvent(
                                                      params: FinishTaskParams(
                                                        id: widget.id,
                                                        nextTaskId: nextTaskId,
                                                        assignToId: nextAssignId ?? siteController.getUserId(),
                                                        notes: thisStepNotes,
                                                      ),
                                                    ));
                                                  },
                                                ),
                                              ],
                                            )
                                          : FormTextKeyWidget(text: "Assigned to ${(request.assignedTo) != null ? request.assignedTo!.name! : "Nobody"}")
                              /*
                            CIA_PrimaryButton(
                                            icon: Icon(
                                              Icons.play_circle,
                                              color: Colors.white,
                                            ),
                                            label: "Assign next step to you?",
                                            onTab: () async {
                                              await LAB_RequestsAPI.AddToMyTasks(widget.id);
                                              setState(() {});
                                            },
                                          )*/
                              ,
                            ),
                          ),
                          Visibility(
                            visible: siteController.getRole() == "labmoderator",
                            child: Expanded(
                              child: Column(
                                children: [
                                  FormTextKeyWidget(text: "Assigned to ${(request.assignedTo) != null ? request.assignedTo!.name! : "Nobody"}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                    searchParams: LoadUsersEnum.technicians,
                                    asyncUseCase: sl<LoadUsersUseCase>(),
                                    label: "Assign next step to technician",
                                    onSelect: (value) {
                                      nextAssignId = value.id!;
                                      //setState(() {});
                                    },
                                    selectedItem: request.assignedTo,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CIA_PrimaryButton(
                                    label: 'Assign to technician',
                                    onTab: () async {
                                      if (nextAssignId == null)
                                        ShowSnackBar(context, isSuccess: false, message: "Please choose a technician!");
                                      else {
                                        bloc.add(LabRequestsBloc_AssignTaskToATechnicianEvent(
                                          params: AssignTaskToTechnicianParams(
                                            taskId: request.id!,
                                            technicianId: nextAssignId!,
                                          ),
                                        ));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: CIA_LAB_StepTimelineWidget(
                          steps: request!.steps ?? [],
                          isTask: true,
                          customerId: request.customerId!,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
