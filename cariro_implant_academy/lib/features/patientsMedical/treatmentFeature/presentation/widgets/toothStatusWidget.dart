import 'dart:js_interop';

import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateByBatchIdUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/CIA_GestureWidget.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/postSurgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/postSurgeryWidget.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Constants/Colors.dart';
import '../../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../../Widgets/FormTextWidget.dart';
import '../../../../../../core/injection_contianer.dart';
import '../../../../../Constants/Controllers.dart';
import '../../../../../Controllers/SiteController.dart';
import '../../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../../core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import '../../../../../core/features/settings/domain/useCases/getImplantLinesUseCase.dart';
import '../../../nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_Events.dart';

class ToothStatusWidget extends StatefulWidget {
  ToothStatusWidget(
      {Key? key,
      required this.data,
      this.onDelete,
      this.isImplant = false,
      this.settingsPrice = 0,
      required this.patientId,
      required this.isSurgical,
      required this.acceptChanges,
      required this.bloc,
      this.viewOnlyMode = false})
      : super(key: key);
  TreatmentDetailsEntity data;
  bool isImplant;
  Function? onDelete;
  bool viewOnlyMode;
  int? settingsPrice;
  bool isSurgical;
  int patientId;
  TreatmentBloc bloc;
  Function(RequestChangeEntity request) acceptChanges;

  @override
  State<ToothStatusWidget> createState() => _ToothStatusWidgetState();
}

class _ToothStatusWidgetState extends State<ToothStatusWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.viewOnlyMode) {
      if (widget.data.planPrice == 0) return Container();
      return Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    if (widget.onDelete != null) widget.onDelete!();
                  },
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                )),
                Expanded(
                  child: widget.isSurgical
                      ? RoundCheckBox(
                          isChecked: widget.data.status,
                          onTap: siteController.getRole()!.contains("secretary")
                              ? null
                              : (selected) {
                                  widget.data.status = selected;
                                  if (selected == true) {
                                    widget.data.doneByAssistant =
                                        BasicNameIdObjectEntity(name: siteController.getUserName(), id: sl<SharedPreferences>().getInt("userid"));
                                    widget.data.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                                    widget.data.date = DateTime.now().toUtc();
                                  } else {
                                    widget.data.doneByAssistant = BasicNameIdObjectEntity();
                                    widget.data.doneByAssistantID = null;
                                  }
                                  setState(() {});
                                },
                          border: null,
                          borderColor: Colors.transparent,
                          uncheckedWidget: Icon(
                            Icons.outgoing_mail,
                            color: Colors.red,
                          ),
                          size: 30,
                        )
                      : widget.data.status!
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 18,
            child: Row(
              children: [
                Expanded(
                  flex: widget.isSurgical ? 7 : 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            FormTextKeyWidget(
                              text: widget.data.name!,
                            ),
                            FormTextValueWidget(
                              text: ": ${widget.data.value ?? ""}",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      widget.data.hasAssign()
                          ? Expanded(
                              child: Row(
                                children: [
                                  FormTextKeyWidget(
                                    text: "Assigned to: ",
                                  ),
                                  FormTextValueWidget(
                                    text: widget.data.assignedTo != null ? widget.data.assignedTo?.name ?? "" : "",
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Visibility(
                  visible: !widget.isSurgical,
                  child: Expanded(
                      child: Row(
                    children: [
                      FormTextKeyWidget(text: "Price: "),
                      FormTextKeyWidget(
                          text: (widget.data.planPrice != 0 && widget.data.planPrice != null
                                  ? widget.data.planPrice ?? widget.settingsPrice
                                  : widget.settingsPrice)
                              .toString()),
                    ],
                  )),
                )
              ],
            ),
          ),
        ],
      );
    }

    return BlocListener<TreatmentBloc, TreatmentBloc_States>(
      listener: (context, state) {
        if (state is TreatmentBloc_AcceptedChangesSuccessfullyState && state.id == widget.data.requestChangeId) {
          widget.data.implantID = widget.data.requestChangeModel!.dataId;
          widget.data.implant = BasicNameIdObjectEntity(
            name: widget.data.requestChangeModel!.dataName,
            id: widget.data.requestChangeModel!.dataId,
          );
          widget.data.requestChangeModel = null;
          widget.data.requestChangeId = null;
          setState(() {});
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: IconButton(
                  onPressed: () {
                    if (widget.onDelete != null) widget.onDelete!();
                  },
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                )),
                Expanded(
                  child: widget.isSurgical
                      ? RoundCheckBox(
                          isChecked: widget.data.status,
                          onTap: siteController.getRole()!.contains("secretary")
                              ? null
                              : (selected) {
                                  widget.data.status = selected;
                                  teethData();
                                },
                          border: null,
                          borderColor: Colors.transparent,
                          uncheckedWidget: Icon(
                            Icons.circle_outlined,
                            color: Colors.red,
                          ),
                          size: 30,
                        )
                      : widget.data.status!
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 18,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: widget.isSurgical
                          ? CIA_TextFormField(
                              onChange: (value) {
                                widget.data.value = value;
                              },
                              label: widget.data.name!,
                              controller: TextEditingController(
                                text: (widget.data.value),
                              ),
                            )
                          : FormTextKeyWidget(text: widget.data.name!),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          if (widget.data.hasPrice() && !widget.isSurgical)
                            Expanded(
                              child: CIA_TextFormField(
                                suffix: "EGP",
                                label: 'Price',
                                isNumber: true,
                                onChange: (v) {
                                  if (v == "" || v == "0" || v == null) v = "0";
                                  return widget.data.planPrice = int.parse(v);
                                },
                                controller: TextEditingController(text: widget.data.planPrice.toString()),
                              ),
                            )
                          else
                            SizedBox(),
                          SizedBox(width: 10),
                          Expanded(
                            child: widget.isSurgical
                                ? ElevatedButton(
                                    onPressed: () {
                                      teethData();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Color_Background),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  FormTextKeyWidget(
                                                    text: "Candidate",
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                  FormTextValueWidget(
                                                    text: widget.data.doneByCandidate?.name,
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  FormTextKeyWidget(
                                                    text: "Batch",
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                  FormTextValueWidget(
                                                    text: widget.data.doneByCandidateBatch?.name,
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  FormTextKeyWidget(
                                                    text: "Assistant",
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                  FormTextValueWidget(
                                                    text: widget.data.doneByAssistant?.name,
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  FormTextKeyWidget(
                                                    text: "Supervisor",
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                  FormTextValueWidget(
                                                    text: widget.data.doneBySupervisor?.name,
                                                    smallFont: true,
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: !((widget.data.name!.toLowerCase().contains("without implant")) ||
                                                  (!widget.data.name!.toLowerCase().contains("implant"))),
                                              child: Expanded(
                                                flex: 2,
                                                child: Row(
                                                  children: [
                                                    FormTextKeyWidget(
                                                      text: "Implant",
                                                      smallFont: true,
                                                    ),
                                                    SizedBox(width: 5),
                                                    FormTextValueWidget(
                                                      text: widget.data.implant == null ? "" : widget.data.implant?.name,
                                                      smallFont: true,
                                                    ),
                                                    SizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : widget.data.hasAssign()
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                              asyncUseCase: sl<LoadUsersUseCase>(),
                                              searchParams: LoadUsersEnum.assistants,
                                              label: "Assign to assistant",
                                              onSelect: (value) {
                                                widget.data.assignedTo = value;
                                                widget.data.assignedToID = value.id;
                                              },
                                              selectedItem: widget.data.assignedTo,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      )
                                    : SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CIA_GestureWidget(
                              onTap: () => CIA_PopupDialog_DateOnlyPicker(
                                context,
                                "Change date",
                                (date) => setState(() => widget.data.date = date),
                                initialDate: widget.data.date,
                              ),
                              child: SizedBox(
                                width: 100,
                                child: Text(
                                  widget.data.date == null ? "" : DateFormat("dd-MM-yyyy").format(widget.data.date!),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: widget.isSurgical != true
                                ? SizedBox()
                                : Visibility(
                                    visible: widget.isSurgical && widget.data.status == true,
                                    child: widget.data.postSurgeryModelId == null
                                        ? FormTextValueWidget(
                                            text: "Save to view post surgery",
                                            smallFont: true,
                                            align: TextAlign.center,
                                          )
                                        : Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.post_add),
                                                onPressed: () {
                                                  late PostSurgicalTreatmentEntity postSurgery;
                                                  int tempScrews = 0;
                                                  int? membraneSizeId = null;
                                                  int tacsNumber = 0;
                                                  int? tacCompanyId = 0;

                                                  CIA_ShowPopUp(
                                                    width: 1000,
                                                    height: 600,
                                                    context: context,
                                                    onSave: () async {
                                                      if (tempScrews != (postSurgery.guidedBoneRegenerationCutByScrewsNumber ?? 0)) {
                                                        if (((postSurgery.guidedBoneRegenerationCutByScrewsNumber ?? 0)) > tempScrews) {
                                                          await CIA_ShowPopUpYesNo(
                                                              title:
                                                                  "Consume ${((postSurgery.guidedBoneRegenerationCutByScrewsNumber ?? 0)) - tempScrews} Screws?",
                                                              context: context,
                                                              onSave: () {
                                                                widget.bloc.add(
                                                                  TreatmentBloc_ConsumeItemByNameEvent(
                                                                    name: "Screws",
                                                                    count: ((postSurgery.guidedBoneRegenerationCutByScrewsNumber ?? 0) - tempScrews),
                                                                  ),
                                                                );
                                                              });
                                                        }
                                                      }
                                                      if (tacCompanyId != postSurgery.openSinusLift_TacsCompanyID) tacsNumber = 0;
                                                      if (tacsNumber != (postSurgery.openSinusLiftTacsNumber ?? 0)) {
                                                        if ((postSurgery.openSinusLiftTacsNumber ?? 0) > tacsNumber) {
                                                          await CIA_ShowPopUpYesNo(
                                                              title: "Consume ${((postSurgery.openSinusLiftTacsNumber ?? 0)) - tacsNumber} Tacs?",
                                                              context: context,
                                                              onSave: () async {
                                                                widget.bloc.add(TreatmentBloc_ConsumeItemByIdEvent(
                                                                    id: postSurgery.openSinusLift_TacsCompanyID!,
                                                                    count: ((postSurgery.openSinusLiftTacsNumber ?? 0)) - tacsNumber));
                                                              });
                                                        }
                                                      }

                                                      if (membraneSizeId != postSurgery.openSinusLift_MembraneID) {
                                                        if (postSurgery.openSinusLift_MembraneID != null) {
                                                          await CIA_ShowPopUpYesNo(
                                                              title: "Consume 1 ${postSurgery.openSinusLift_Membrane!.size ?? ""} Membrane?",
                                                              context: context,
                                                              onSave: () {
                                                                widget.bloc.add(TreatmentBloc_ConsumeItemByIdEvent(
                                                                    id: postSurgery.openSinusLift_MembraneID!, count: 1));
                                                              });
                                                        }
                                                      }

                                                      widget.bloc.add(TreatmentBloc_SavePostSurgicalTreatmentDataEvent(data: postSurgery));
                                                      return false;
                                                    },
                                                    child: PostSurgeryWidget(
                                                      postSurgeryId: widget.data.postSurgeryModelId!,
                                                      onLoaded: (postSurgeryData) {
                                                        postSurgery = postSurgeryData;
                                                      },
                                                      onChange: (screws, membraneId, _tacsNumber, _tacCompanyId) {
                                                        tempScrews = screws;
                                                        membraneSizeId = membraneId;
                                                        tacsNumber = _tacsNumber;
                                                        tacCompanyId = _tacCompanyId;
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                              FormTextValueWidget(
                                                text: "Post Surgery",
                                                smallFont: true,
                                              )
                                            ],
                                          ),
                                  ),
                          )
                        ],
                      ),
                    ),
                    //SizedBox(width: 10)
                  ],
                ),
                Visibility(
                  visible: widget.data.requestChangeModel != null,
                  child: Row(
                    children: [
                      Text(
                        widget.data.requestChangeModel == null
                            ? ""
                            : "User ${widget.data.requestChangeModel?.user?.name ?? ""} requested to change ${widget.data.requestChangeModel?.description ?? ""}",
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Visibility(
                        visible: siteController.getRole()!.contains("admin") && widget.data.requestChangeId != null,
                        child: Row(
                          children: [
                            Expanded(
                                child: CIA_SecondaryButton(
                                    label: "Decline",
                                    icon: Icon(Icons.cancel_outlined),
                                    onTab: () {
                                      widget.data.requestChangeModel = null;
                                      widget.data.requestChangeId = null;
                                      setState(() {});
                                    })),
                            SizedBox(width: 10),
                            Expanded(
                                child: CIA_PrimaryButton(
                              isLong: true,
                              icon: Icon(Icons.check_circle_outline),
                              label: "Accept",
                              onTab: () => widget.acceptChanges(widget.data.requestChangeModel!),
                            )),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // bloc = BlocProvider.of<TreatmentBloc>(context);
    if (widget.data.hasPrice()) widget.data.planPrice = widget.data.planPrice ?? widget.settingsPrice;
  }

  void teethData() {
    List<BasicNameIdObjectEntity> companies = [];
    int? companyID;
    List<BasicNameIdObjectEntity> lines = [];
    int? lineID;
    List<BasicNameIdObjectEntity> implants = [];

    if (widget.data.status == true) {
      widget.data.doneByAssistant = (widget.data.doneByAssistant != null && !(widget.data.doneByAssistant!.name?.isEmpty ?? true))
          ? widget.data.doneByAssistant
          : BasicNameIdObjectEntity(name: siteController.getUserName(), id: sl<SharedPreferences>().getInt("userid"));
      widget.data.doneByAssistantID = widget.data.doneByAssistantID ?? widget.data.doneByAssistant?.id;
      widget.data.doneBySupervisor = (widget.data.doneBySupervisor != null && !(widget.data.doneBySupervisor!.name?.isBlank ?? true))
          ? widget.data.doneBySupervisor
          : widget.bloc.tempSuperVisor;
      widget.data.doneBySupervisorID = widget.data.doneBySupervisorID ?? widget.bloc.tempSuperVisor?.id;
      widget.data.doneByCandidate = (widget.data.doneByCandidate != null && !(widget.data.doneByCandidate!.name?.isBlank ?? true))
          ? widget.data.doneByCandidate
          : widget.bloc.tempCandidate;
      widget.data.doneByCandidateID = widget.data.doneByCandidateID ?? widget.bloc.tempCandidate?.id;
      widget.data.doneByCandidateBatch = (widget.data.doneByCandidateBatch != null && !(widget.data.doneByCandidateBatch!.name?.isBlank ?? true))
          ? widget.data.doneByCandidateBatch
          : widget.bloc.tempCandidateBatch;
      widget.data.doneByCandidateBatchID = widget.data.doneByCandidateBatchID ?? widget.bloc.tempCandidateBatch?.id;
      CIA_ShowPopUp(
          context: context,
          title: "${widget.data.name!} Data",
          onSave: () {
            //  widget.fieldModel.status = selected;
            if (widget.data.status == true) {
              widget.data.doneByAssistant = widget.data.doneByAssistant ??
                  BasicNameIdObjectEntity(name: siteController.getUserName(), id: sl<SharedPreferences>().getInt("userid"));
              widget.data.doneByAssistantID = widget.data.doneByAssistantID ?? sl<SharedPreferences>().getInt("userid");
              widget.data.date = DateTime.now().toUtc();
            } else {
              widget.data.doneByAssistant = BasicNameIdObjectEntity();
              widget.data.doneByAssistantID = null;
            }
            setState(() {});
          },
          width: 900,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible:
                        !((widget.data.name!.toLowerCase().contains("without implant")) || (!widget.data.name!.toLowerCase().contains("implant"))),
                    child: Row(
                      children: [
                        Expanded(
                          child: CIA_DropDownSearchBasicIdName<NoParams>(
                            label: "Implant Company",
                            asyncUseCase: sl<GetImplantCompaniesUseCase>(),
                            searchParams: NoParams(),
                            selectedItem: companies.firstWhereOrNull((element) => element.id == companyID),
                            onSelect: (value) {
                              companyID = value!.id!;

                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: CIA_DropDownSearchBasicIdName<int>(
                            label: "Implant Lines",
                            asyncUseCase: companyID == null ? null : sl<GetImplantLinesUseCase>(),
                            emptyString: "Select implant company first",
                            searchParams: companyID,
                            selectedItem: lines.firstWhereOrNull((element) => element.id == lineID),
                            onSelect: (value) {
                              lineID = value!.id!;

                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                            child: BlocConsumer<TreatmentBloc, TreatmentBloc_States>(
                          listener: (context, state) {
                            if (state is TreatmentBloc_ConsumedItemSuccessfullyState)
                              ShowSnackBar(context, isSuccess: true, message: "Implant Consumed Successfully");
                            else if (state is TreatmentBloc_ConsumeItemErrorState) ShowSnackBar(context, isSuccess: false, message: state.message);
                          },
                          builder: (context, state) {
                            return CIA_DropDownSearchBasicIdName<int>(
                              label: "Implant Size",
                              asyncUseCase: lineID == null ? null : sl<GetImplantSizesUseCase>(),
                              emptyString: "Select implant line first",
                              searchParams: lineID,
                              selectedItem: widget.data.implant,
                              onSelect: (value) async {
                                if (widget.data.implantID != null) {
                                  widget.data.requestChangeModel = RequestChangeEntity(
                                    description: "${widget.data.implant?.name!} to ${value.name!}",
                                    requestEnum: RequestChangeEnum.ImplantChange,
                                    patientId: widget.patientId,
                                    dataId: value.id,
                                    dataName: value.name,
                                  );
                                } else {
                                  widget.data.implant?.name = value.name;
                                  widget.data.implantID = value.id;
                                  await CIA_ShowPopUpYesNo(
                                      context: context,
                                      title: "Consume Implant ${widget.data.implant?.name}?",
                                      onSave: () => widget.bloc.add(TreatmentBloc_ConsumeImplantEvent(id: widget.data.implantID!)));
                                }
                                setState(() {});
                              },
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Visibility(
                        visible: widget.data.requestChangeModel != null,
                        child: Row(
                          children: [
                            Text("Requested Change: ${widget.data.requestChangeModel?.dataName ?? ""}"),
                            CIA_SecondaryButton(
                                label: "Clear Request",
                                onTab: () {
                                  widget.data.requestChangeModel = null;
                                  widget.data.requestChangeId = null;
                                  setState(() {});
                                })
                          ],
                        )),
                  ),
                  CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                    label: "Assistant",
                    asyncUseCase: sl<LoadUsersUseCase>(),
                    searchParams: LoadUsersEnum.assistants,
                    selectedItem: widget.data.doneByAssistant,
                    onSelect: (value) {
                      widget.data.doneByAssistant = value;
                      widget.data.doneByAssistantID = value.id;
                      //widget.bloc.tempSuperVisor = value;
                    },
                  ),
                  CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                    label: "Supervisor",
                    asyncUseCase: sl<LoadUsersUseCase>(),
                    searchParams: LoadUsersEnum.supervisors,
                    selectedItem: widget.data.doneBySupervisor,
                    onSelect: (value) {
                      widget.data.doneBySupervisor = value;
                      widget.data.doneBySupervisorID = value.id;
                      widget.bloc.tempSuperVisor = value;
                    },
                  ),
                  CIA_DropDownSearchBasicIdName(
                    label: "Candidate Batch",
                    asyncUseCase: sl<LoadCandidateBatchesUseCase>(),
                    selectedItem: widget.data.doneByCandidateBatch,
                    onSelect: (value) {
                      widget.data.doneByCandidateBatch = value;
                      widget.data.doneByCandidateBatchID = value.id;
                      widget.bloc.tempCandidateBatch = value;
                      setState(() {});
                    },
                  ),
                  CIA_DropDownSearchBasicIdName<int>(
                    label: "Candidate",
                    asyncUseCase: widget.data.doneByCandidateBatchID == null ? null : sl<LoadCandidatesByBatchId>(),
                    searchParams: widget.data.doneByCandidateBatchID ?? 0,
                    selectedItem: widget.data.doneByCandidate,
                    onSelect: (value) {
                      widget.data.doneByCandidate = value;
                      widget.data.doneByCandidateID = value.id;
                      widget.bloc.tempCandidate = value;
                    },
                  ),
                  CIA_SecondaryButton(
                      label: "Add To Receipt",
                      onTab: () {
                        CIA_ShowPopUp(
                          context: context,
                          onSave: () {
                            BlocProvider.of<MedicalInfoShellBloc>(context).add(MedicalInfoShell_SaveChanges());

                            Future.delayed(Duration(seconds: 5)).then((value) {
                              BlocProvider.of<NonSurgicalTreatmentBloc>(context).add(NonSurgicalTreatmentBloc_AddPatientReceiptEvent(
                                patientId: widget.patientId,
                                tooth: widget.data.tooth!,
                                action: "implant",
                              ));
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  FormTextKeyWidget(text: "Tooth: ${widget.data.tooth!} || "),
                                  FormTextKeyWidget(text: widget.data.name!),
                                ],
                              ),
                              SizedBox(height: 10),
                              CIA_TextFormField(
                                label: "Price",
                                isNumber: true,
                                suffix: "EGP",
                                onChange: (value) => widget.data.planPrice = int.parse(value),
                                controller: TextEditingController(
                                  text: widget.data.planPrice?.toString() ?? widget.settingsPrice?.toString() ?? "0",
                                ),
                              )
                            ],
                          ),
                        );
                      })
                ],
              );
            },
          ));
    } else {
      widget.data.doneByAssistant = BasicNameIdObjectEntity();
      widget.data.doneByAssistantID = null;
      widget.data.doneByCandidate = BasicNameIdObjectEntity();
      widget.data.doneByCandidateID = null;
      widget.data.doneByCandidateBatch = BasicNameIdObjectEntity();
      widget.data.doneByCandidateBatchID = null;
      widget.data.implantID = null;
      widget.data.implant = BasicNameIdObjectEntity();
      widget.data.doneBySupervisor = BasicNameIdObjectEntity();
      widget.data.doneBySupervisorID = null;
      setState(() {});
    }
  }
}
