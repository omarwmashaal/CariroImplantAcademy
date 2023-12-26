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
import '../widgets/labRequestItemConsumeWidget.dart';
import '../widgets/labRequestItemReceiptWidget.dart';
import '../widgets/labRequestItemWidget.dart';

class LAB_ViewTaskPage extends StatefulWidget {
  LAB_ViewTaskPage({Key? key, required this.id}) : super(key: key);
  int id;
  static String routeName = "ViewTask";
  static String routeNameClinic = "ClinicViewTask";
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
            state is LabRequestsBloc_UpdatingLabRequestState ||
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
        } else if (state is LabRequestsBloc_FinishingTaskErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is LabRequestsBloc_UpdatedLabRequestSuccessfullyState) {
          ShowSnackBar(context, isSuccess: true);
          bloc.add(LabRequestsBloc_GetRequestEvent(id: widget.id));
          dialogHelper.dismissAll(context);
        } else if (state is LabRequestsBloc_UpdatingLabRequestErrorState) ShowSnackBar(context, isSuccess: false, message: state.message ?? "");
      },
      buildWhen: (previous, current) =>
          current is LabRequestsBloc_LoadingRequestsState ||
          current is LabRequestsBloc_LoadingSingleRequestErrorState ||
          current is LabRequestsBloc_LoadedSingleRequestsSuccessfullyState,
      builder: (context, state) {
        if (state is LabRequestsBloc_LoadingRequestsState)
          return LoadingWidget();
        else if (state is LabRequestsBloc_LoadingSingleRequestErrorState)
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
                                    text: request.customer?.name ?? "",
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
                                  child: FormTextValueWidget(text: request.steps?.last.step?.name ?? ""),
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
                              context.goNamed(PatientMedicalHistory.getRouteName(), pathParameters: {"id": request.patientId.toString()});
                            }),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      RoundCheckBox(
                        disabledColor: Colors.green,
                        onTap: request.status == EnumLabRequestStatus.Finished
                            ? null
                            : (value) async {
                                await CIA_ShowPopUpYesNo(
                                  context: context,
                                  title: "Mark request as finished?",
                                  onSave: () => CIA_ShowPopUp(
                                    context: context,
                                    onSave: () {
                                      request.status = EnumLabRequestStatus.Finished;
                                      bloc.add(LabRequestsBloc_UpdateLabRequestEvent(request: request));
                                    },
                                    child: CIA_TextFormField(
                                      label: "Notes From Technician",
                                      maxLines: 5,
                                      onChange: (v) => request.notesFromTech = v,
                                      controller: TextEditingController(
                                        text: request.notesFromTech,
                                      ),
                                    ),
                                  ),
                                );
                              },
                      ),
                      FormTextKeyWidget(text: request.status == EnumLabRequestStatus.Finished ? "Request Completed" : "Mark as Completed")
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    request.status==EnumLabRequestStatus.Finished?
                      LabRequestItemReceiptWidget(request: request, onTotalCalculated: (t){},viewOnly: true,)  :
                    Expanded(
                      child: ListView(
                        children: [
                          Visibility(
                            visible: request.waxUp != null,
                            child: LabRequestItemWidget(
                              item: request.waxUp,
                              name: "Wax Up",
                              onChange: (data) => null,
                              viewOnly: true,
                              showConsume: true,
                            ),
                          ),
                          Visibility(
                            visible: request.printedPMMA != null,
                            child: LabRequestItemWidget(
                              item: request.printedPMMA,
                              name: "Printed PMMA",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.zirconUnit != null,
                            child: LabRequestItemWidget(
                              item: request.zirconUnit,
                              name: "Zircon Unit",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.tiAbutment != null,
                            child: LabRequestItemWidget(
                              item: request.tiAbutment,
                              name: "Ti Abutment",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.pfm != null,
                            child: LabRequestItemWidget(
                              item: request.pfm,
                              name: "PFM",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.tiBar != null,
                            child: LabRequestItemWidget(
                              item: request.tiBar,
                              name: "Ti Bar",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.compositeInlay != null,
                            child: LabRequestItemWidget(
                              item: request.compositeInlay,
                              name: "Composite Inlay",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.threeDPrinting != null,
                            child: LabRequestItemWidget(
                              item: request.threeDPrinting,
                              name: "3D Printing",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.emaxVeneer != null,
                            child: LabRequestItemWidget(
                              item: request.emaxVeneer,
                              name: "Emax Veneer",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                          Visibility(
                            visible: request.milledPMMA != null,
                            child: LabRequestItemWidget(
                              item: request.milledPMMA,
                              name: "Milled PMMA",
                              onChange: (data) => null,
                              viewOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormTextKeyWidget(text: "Notes From Customer: "),
                    SizedBox(height: 10),
                    FormTextValueWidget(text: request.notes ?? ""),
                    SizedBox(height: 10),
                    FormTextKeyWidget(text: "Notes From Lab: "),
                    SizedBox(height: 10),
                    FormTextValueWidget(text: request.notesFromTech ?? ""),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: siteController.getRole() == "technician" && siteController.getUserId()==request.assignedToId,
                      child: Container(
                        child: request.status == EnumLabRequestStatus.Finished
                            ? Container()
                            : SizedBox(
                                child: Row(
                                  children: [
                                    CIA_SecondaryButton(
                                        label: "Save Changes",
                                        onTab: () {
                                          CIA_ShowPopUp(
                                            context: context,
                                            onSave: () {
                                              bloc.add(LabRequestsBloc_UpdateLabRequestEvent(request: request));
                                            },
                                            child: CIA_TextFormField(
                                              label: "Notes From Technician",
                                              maxLines: 5,
                                              onChange: (v) => request.notesFromTech = v,
                                              controller: TextEditingController(
                                                text: request.notesFromTech,
                                              ),
                                            ),
                                          );
                                        }),
                                    SizedBox(width: 10),
                                    CIA_PrimaryButton(
                                        label: "Finish Request",
                                        onTab: () {
                                          PageController controller = PageController();
                                          int index = 0;

                                          int total = 0;
                                          CIA_ShowPopUp(
                                              context: context,
                                              hideButton: true,
                                              width: double.maxFinite,
                                              height: 600,
                                              onSave: () {},
                                              child: StatefulBuilder(builder: (context, _setState) {
                                                return Column(
                                                  children: [
                                                    Expanded(
                                                      child: PageView(
                                                        controller: controller,
                                                        onPageChanged: (value) {
                                                          index = value;
                                                          _setState(() {});
                                                        },
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: LabRequestItemConsumeWidget(
                                                              request: request,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: LabRequestItemReceiptWidget(
                                                              request: request,
                                                              onTotalCalculated: (_total) {
                                                                total = _total;
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: CIA_TextFormField(
                                                              label: "Notes From Technician",
                                                              maxLines: 5,
                                                              onChange: (v) => request.notesFromTech = v,
                                                              controller: TextEditingController(
                                                                text: request.notesFromTech,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Visibility(
                                                          visible: index != 0,
                                                          child: CIA_SecondaryButton(
                                                              label: "Previous",
                                                              onTab: () {
                                                                controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                                                              }),
                                                        ),
                                                        SizedBox(width: 10),
                                                        index != 2
                                                            ? CIA_SecondaryButton(
                                                                label: "Next",
                                                                onTab: () {
                                                                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                                                                })
                                                            : CIA_PrimaryButton(
                                                                label: "Finish",
                                                                onTab: () {
                                                                  request.status = EnumLabRequestStatus.Finished;
                                                                  bloc.add(LabRequestsBloc_UpdateLabRequestEvent(request: request));
                                                                }),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              }));
                                        }),
                                  ],
                                ),
                              )
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
                            FormTextKeyWidget(text: "Assigned to ${request.assignedTo?.name ?? "Nobody"}"),
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
                    /* Visibility(
                      visible: request.steps?.last.technicianId == request.customerId && request.customerId == siteController.getUserId(),
                      child: CIA_PrimaryButton(
                        label: "Waiting your action",
                        onTab: () async {
                          if (request.steps != null && request.steps!.isNotEmpty) {
                            if (request.steps!=null && request.steps!.length >= 2)
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
                    ),*/
                    SizedBox(
                      height: 40,
                    ),
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
