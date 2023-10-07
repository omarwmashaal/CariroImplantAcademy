import 'package:cariro_implant_academy/API/LAB_RequestsAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Models/LAB_TaskModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../features/labRequest/domain/entities/labRequestEntityl.dart';
import '../../Widgets/CIA_DropDown.dart';
import '../../Widgets/CIA_LAB_StepTimelineWidget.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/FormTextWidget.dart';
import '../../Widgets/Title.dart';
import '../../features/patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';
import '../../features/user/domain/entities/enum.dart';

class _getx extends GetxController {
  static RxInt totalPrice = 0.obs;
  static RxBool editReceipt = false.obs;
}

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

  @override
  void initState() {
    //siteController.setAppBarWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return CIA_FutureBuilder(
      loadFunction: LAB_RequestsAPI.GetRequest(widget.id),
      onSuccess: (data) {
        request = data as LabRequestEntity;
        int t = 0;
        request.steps!.forEach((element) {
          t += element.price ?? 0;
        });
        _getx.totalPrice.value = t;
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
                                  text: request.date == null ? "" : request.date,
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
                                onSave: () async {
                                  var res = await LAB_RequestsAPI.MarkRequestAsDone(widget.id, thisStepNotes);
                                  ShowSnackBar(context, isSuccess: res.statusCode == 200);
                                  setState(() {});
                                },
                                onDontSave: () => setState(() {}),
                                onCancel: () => setState(() {}),
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
                                              Obx(
                                                () => CIA_SecondaryButton(
                                                    label: _getx.editReceipt.value ? "View Mode" : "Edit Mode",
                                                    onTab: () {
                                                      _getx.editReceipt.value = !_getx.editReceipt.value;
                                                    }),
                                              ),
                                              CIA_PrimaryButton(
                                                  label: "Save Receipt",
                                                  onTab: () async {
                                                    var res = await LAB_RequestsAPI.AddOrUpdateRequestReceipt(widget.id, request.steps ?? []);
                                                    ShowSnackBar(context, isSuccess: res.statusCode == 200, message: res.errorMessage ?? "");
                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children: request.steps!
                                                .map(
                                                  (e) => Obx(() => Padding(
                                                        padding: EdgeInsets.only(bottom: _getx.editReceipt.value ? 10 : 5),
                                                        child: Row(
                                                          children: [
                                                            Expanded(child: FormTextValueWidget(text: e.date ?? "")),
                                                            Expanded(child: FormTextValueWidget(text: "by: ${e.technician == null ? "" : e.technician!.name}")),
                                                            Expanded(
                                                              child: _getx.editReceipt.value
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
                                                                        _getx.totalPrice.value = total;
                                                                      },
                                                                    )
                                                                  : FormTextValueWidget(text: "${e.step!.name!}"),
                                                            ),
                                                            _getx.editReceipt.value
                                                                ? Container()
                                                                : Expanded(
                                                                    child: FormTextValueWidget(
                                                                    text: " ${(e.price ?? 0).toString()}",
                                                                    suffix: "EGP",
                                                                  ))
                                                          ],
                                                        ),
                                                      )),
                                                )
                                                .toList(),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(flex: 3, child: SizedBox()),
                                              Obx(() => Expanded(
                                                      child: FormTextValueWidget(
                                                    text: _getx.totalPrice.value.toString(),
                                                    suffix: "EGP",
                                                  )))
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
                                                  onSave: () async {
                                                    var res =
                                                        await LAB_RequestsAPI.FinishTask(id: widget.id, nextTaskId: nextTaskId, assignToId: null, notes: null);
                                                    thisStepNotes = null;
                                                    nextAssignId = null;
                                                    nextTaskId = null;
                                                    ShowSnackBar(context, isSuccess: res.statusCode == 200);
                                                    setState(() {});
                                                  },
                                                  child: Column(
                                                    children: [
                                                      CIA_DropDownSearch(
                                                        asyncItems: LAB_RequestsAPI.GetDefaultSteps,
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
                                              CIA_DropDownSearch(
                                                asyncItems: LAB_RequestsAPI.GetDefaultSteps,
                                                label: "Next Step",
                                                onSelect: (value) {
                                                  nextTaskId = value.id!;
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CIA_DropDownSearch(
                                                      asyncItems: () async {
                                                        var res = await UserAPI.SearcshUsersByRole(role: UserRoles.Technician);
                                                        var r = <DropDownDTO>[];
                                                        if (res.statusCode == 200) {
                                                          List<ApplicationUserModel> t = [];
                                                          t = res.result as List<ApplicationUserModel>;
                                                          r = t.map((e) => DropDownDTO(name: e.name, id: e.idInt)).toList();
                                                        }
                                                        res.result = r;
                                                        return Future.value(res);
                                                      },
                                                      label: "Assign next step to another one",
                                                      onSelect: (value) {
                                                        nextAssignId = value.id!;
                                                        setState(() {});
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
                                                  var res = await LAB_RequestsAPI.FinishTask(
                                                      id: widget.id,
                                                      nextTaskId: nextTaskId,
                                                      assignToId: nextAssignId ?? siteController.getUserId(),
                                                      notes: thisStepNotes);
                                                  thisStepNotes = null;
                                                  nextAssignId = null;
                                                  nextTaskId = null;
                                                  ShowSnackBar(context, isSuccess: res.statusCode == 200);
                                                  setState(() {});
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
                                SizedBox(height: 10,),
                                CIA_DropDownSearch(
                                  asyncItems: () async {
                                    var res = await UserAPI.SearcshUsersByRole(role: UserRoles.Technician);
                                    var r = <DropDownDTO>[];
                                    if (res.statusCode == 200) {
                                      List<ApplicationUserModel> t = [];
                                      t = res.result as List<ApplicationUserModel>;
                                      r = t.map((e) => DropDownDTO(name: e.name, id: e.idInt)).toList();
                                    }
                                    res.result = r;
                                    return Future.value(res);
                                  },
                                  label: "Assign next step to technician",
                                  onSelect: (value) {
                                    nextAssignId = value.id!;
                                    //setState(() {});
                                  },
                                  selectedItem: request.assignedTo,
                                ),
                                SizedBox(height: 10,),
                                CIA_PrimaryButton(
                                  label: 'Assign to technician',
                                  onTab: () async{
                                    if(nextAssignId==null)
                                      ShowSnackBar(context, isSuccess: false,message: "Please choose a technician!");
                                    else
                                      {
                                        var res = await LAB_RequestsAPI.AssignToTechnician(request.id!, nextAssignId!);
                                        ShowSnackBar(context, isSuccess: res.statusCode==200);

                                        setState(() {

                                        });
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
                                    var res =
                                        await LAB_RequestsAPI.FinishTask(id: widget.id, nextTaskId: nextTaskId, assignToId: nextAssignId, notes: thisStepNotes);
                                    thisStepNotes = null;
                                    nextAssignId = null;
                                    nextTaskId = null;
                                    ShowSnackBar(context, isSuccess: res.statusCode == 200);
                                    dialogHelper.dismissSingle(context);
                                    return true;
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
                                      CIA_DropDownSearch(
                                        asyncItems: LAB_RequestsAPI.GetDefaultSteps,
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
      },
    );*/
  }
}
