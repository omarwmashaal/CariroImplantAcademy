import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateByBatchIdUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
import '../../domain/entities/trearmentPlanPropertyEntity.dart';

class ToothStatusWidget extends StatefulWidget {
  ToothStatusWidget(
      {Key? key,
      required this.fieldModel,
      this.price = false,
      required this.title,
      this.onDelete,
      this.assignButton = false,
      this.isImplant = false,
      this.settingsPrice = 0,
      required this.patientId,
      required this.isSurgical,
      required this.acceptChanges,
      required this.tooth,
      required this.bloc,
      this.viewOnlyMode = false})
      : super(key: key);
  TreatmentPlanPropertyEntity fieldModel;
  String title;
  bool isImplant;
  bool assignButton;
  Function? onDelete;
  bool viewOnlyMode;
  bool price;
  int? settingsPrice;
  bool isSurgical;
  int patientId;
  int tooth;
  TreatmentBloc bloc;
  Function(RequestChangeEntity request) acceptChanges;

  @override
  State<ToothStatusWidget> createState() => _ToothStatusWidgetState();
}

class _ToothStatusWidgetState extends State<ToothStatusWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.viewOnlyMode) {
      if (widget.fieldModel.planPrice == 0) return Container();
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
                          isChecked: widget.fieldModel.status,
                          onTap: siteController.getRole()!.contains("secretary")
                              ? null
                              : (selected) {
                                  widget.fieldModel.status = selected;
                                  if (selected == true) {
                                    widget.fieldModel.doneByAssistant =
                                        BasicNameIdObjectEntity(name: siteController.getUserName(), id: sl<SharedPreferences>().getInt("userid"));
                                    widget.fieldModel.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                                    widget.fieldModel.date = DateTime.now().toUtc();
                                  } else {
                                    widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity();
                                    widget.fieldModel.doneByAssistantID = null;
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
                      : widget.fieldModel.status!
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
                                text: widget.title,
                              ),
                              FormTextValueWidget(
                                text: ": ${widget.fieldModel.value ?? ""}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        widget.assignButton
                            ? Expanded(
                                child: Row(
                                  children: [
                                    FormTextKeyWidget(
                                      text: "Assigned to: ",
                                    ),
                                    FormTextValueWidget(
                                      text: widget.fieldModel.assignedTo != null ? widget.fieldModel.assignedTo?.name ?? "" : "",
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    )),
                SizedBox(width: 10),
                Visibility(
                  visible: !widget.isSurgical,
                  child: Expanded(
                      child: Row(
                    children: [
                      FormTextKeyWidget(text: "Price: "),
                      FormTextKeyWidget(
                          text: (widget.fieldModel.planPrice != 0 && widget.fieldModel.planPrice != null
                                  ? widget.fieldModel.planPrice ?? widget.settingsPrice
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
        if (state is TreatmentBloc_AcceptedChangesSuccessfullyState && state.id == widget.fieldModel.requestChangeId) {
          widget.fieldModel.implantID = widget.fieldModel.requestChangeModel!.dataId;
          widget.fieldModel.implant = BasicNameIdObjectEntity(
            name: widget.fieldModel.requestChangeModel!.dataName,
            id: widget.fieldModel.requestChangeModel!.dataId,
          );
          widget.fieldModel.requestChangeModel = null;
          widget.fieldModel.requestChangeId = null;
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
                          isChecked: widget.fieldModel.status,
                          onTap: siteController.getRole()!.contains("secretary")
                              ? null
                              : (selected) {
                                  widget.fieldModel.status = selected;
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
                      : widget.fieldModel.status!
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
                  children: [
                    Expanded(
                      flex: widget.isSurgical
                          ? 7
                          : widget.price
                              ? 1
                              : 3,
                      child: widget.isSurgical
                          ? CIA_TextFormField(
                              onChange: (value) {
                                widget.fieldModel.value = value;
                              },
                              label: widget.title,
                              controller: TextEditingController(
                                text: (widget.fieldModel.value),
                              ),
                            )
                          : FormTextKeyWidget(text: widget.title),
                    ),
                    SizedBox(width: 10),
                    if (widget.price && !widget.isSurgical)
                      Expanded(
                          child: CIA_TextFormField(
                        suffix: "EGP",
                        label: 'Price',
                        isNumber: true,
                        onChange: (v) {
                          if (v == "" || v == "0" || v == null) v = "0";
                          return widget.fieldModel.planPrice = int.parse(v);
                        },
                        controller: TextEditingController(text: () {
                          if (widget.fieldModel.planPrice != null && widget.fieldModel.planPrice != 0)
                            return widget.fieldModel.planPrice.toString();
                          else
                            return widget.settingsPrice.toString();
                        }()),
                      ))
                    else
                      SizedBox(),
                    SizedBox(width: 10),
                    widget.isSurgical
                        ? Expanded(
                            flex: 9,
                            child: ElevatedButton(
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
                                              text: widget.fieldModel.doneByCandidate?.name,
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
                                              text: widget.fieldModel.doneByCandidateBatch?.name,
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
                                              text: widget.fieldModel.doneByAssistant?.name,
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
                                              text: widget.fieldModel.doneBySupervisor?.name,
                                              smallFont: true,
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            !((widget.title.toLowerCase().contains("without implant")) || (!widget.title.toLowerCase().contains("implant"))),
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
                                                text: widget.fieldModel.implant == null ? "" : widget.fieldModel.implant?.name,
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
                            ))
                        : widget.assignButton
                            ? Expanded(
                                child: Row(
                                children: [
                                  Expanded(
                                    child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                                      asyncUseCase: sl<LoadUsersUseCase>(),
                                      searchParams: LoadUsersEnum.assistants,
                                      label: "Assign to assistant",
                                      onSelect: (value) {
                                        widget.fieldModel.assignedTo = value;
                                        widget.fieldModel.assignedToID = value.id;
                                      },
                                      selectedItem: widget.fieldModel.assignedTo,
                                    ),
                                  ),
                                  SizedBox(width: 10)
                                ],
                              ))
                            : SizedBox(),
                    //SizedBox(width: 10)
                  ],
                ),
                Visibility(
                  visible: widget.fieldModel.requestChangeModel != null,
                  child: Row(
                    children: [
                      Text(
                        widget.fieldModel.requestChangeModel == null
                            ? ""
                            : "User ${widget.fieldModel.requestChangeModel?.user?.name ?? ""} requested to change ${widget.fieldModel.requestChangeModel?.description ?? ""}",
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Visibility(
                        visible: siteController.getRole()!.contains("admin") && widget.fieldModel.requestChangeId != null,
                        child: Row(
                          children: [
                            Expanded(
                                child: CIA_SecondaryButton(
                                    label: "Decline",
                                    icon: Icon(Icons.cancel_outlined),
                                    onTab: () {
                                      widget.fieldModel.requestChangeModel = null;
                                      widget.fieldModel.requestChangeId = null;
                                      setState(() {});
                                    })),
                            SizedBox(width: 10),
                            Expanded(
                                child: CIA_PrimaryButton(
                              isLong: true,
                              icon: Icon(Icons.check_circle_outline),
                              label: "Accept",
                              onTab: () => widget.acceptChanges(widget.fieldModel.requestChangeModel!),
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
    if (widget.price && widget.fieldModel.planPrice == null || widget.fieldModel.planPrice == 0) widget.fieldModel.planPrice = widget.settingsPrice;
  }

  void teethData() {
    List<BasicNameIdObjectEntity> companies = [];
    int? companyID;
    List<BasicNameIdObjectEntity> lines = [];
    int? lineID;
    List<BasicNameIdObjectEntity> implants = [];

    if (widget.fieldModel.status == true) {
      widget.fieldModel.doneByAssistant = (widget.fieldModel.doneByAssistant != null && !(widget.fieldModel.doneByAssistant!.name?.isEmpty ?? true))
          ? widget.fieldModel.doneByAssistant
          : BasicNameIdObjectEntity(name: siteController.getUserName(), id: sl<SharedPreferences>().getInt("userid"));
      widget.fieldModel.doneByAssistantID = widget.fieldModel.doneByAssistantID ?? widget.fieldModel.doneByAssistant?.id;
      widget.fieldModel.doneBySupervisor = (widget.fieldModel.doneBySupervisor != null && !(widget.fieldModel.doneBySupervisor!.name?.isBlank ?? true))
          ? widget.fieldModel.doneBySupervisor
          : widget.bloc.tempSuperVisor;
      widget.fieldModel.doneBySupervisorID = widget.fieldModel.doneBySupervisorID ?? widget.bloc.tempSuperVisor?.id;
      widget.fieldModel.doneByCandidate = (widget.fieldModel.doneByCandidate != null && !(widget.fieldModel.doneByCandidate!.name?.isBlank ?? true))
          ? widget.fieldModel.doneByCandidate
          : widget.bloc.tempCandidate;
      widget.fieldModel.doneByCandidateID = widget.fieldModel.doneByCandidateID ?? widget.bloc.tempCandidate?.id;
      widget.fieldModel.doneByCandidateBatch =
          (widget.fieldModel.doneByCandidateBatch != null && !(widget.fieldModel.doneByCandidateBatch!.name?.isBlank ?? true))
              ? widget.fieldModel.doneByCandidateBatch
              : widget.bloc.tempCandidateBatch;
      widget.fieldModel.doneByCandidateBatchID = widget.fieldModel.doneByCandidateBatchID ?? widget.bloc.tempCandidateBatch?.id;
      CIA_ShowPopUp(
          context: context,
          title: "${widget.title} Data",
          onSave: () {
            //  widget.fieldModel.status = selected;
            if (widget.fieldModel.status == true) {
              widget.fieldModel.doneByAssistant = widget.fieldModel.doneByAssistant ??
                  BasicNameIdObjectEntity(name: siteController.getUserName(), id: sl<SharedPreferences>().getInt("userid"));
              widget.fieldModel.doneByAssistantID = widget.fieldModel.doneByAssistantID ?? sl<SharedPreferences>().getInt("userid");
              widget.fieldModel.date = DateTime.now().toUtc();
            } else {
              widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity();
              widget.fieldModel.doneByAssistantID = null;
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
                    visible: !((widget.title.toLowerCase().contains("without implant")) || (!widget.title.toLowerCase().contains("implant"))),
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
                              selectedItem: widget.fieldModel.implant,
                              onSelect: (value) async {
                                if (widget.fieldModel.implantID != null) {
                                  widget.fieldModel.requestChangeModel = RequestChangeEntity(
                                    description: "${widget.fieldModel.implant?.name!} to ${value.name!}",
                                    requestEnum: RequestChangeEnum.ImplantChange,
                                    patientId: widget.patientId,
                                    dataId: value.id,
                                    dataName: value.name,
                                  );
                                } else {
                                  widget.fieldModel.implant?.name = value.name;
                                  widget.fieldModel.implantID = value.id;
                                  await CIA_ShowPopUpYesNo(
                                      context: context,
                                      title: "Consume Implant ${widget.fieldModel.implant?.name}?",
                                      onSave: () => widget.bloc.add(TreatmentBloc_ConsumeImplantEvent(id: widget.fieldModel.implantID!)));
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
                        visible: widget.fieldModel.requestChangeModel != null,
                        child: Row(
                          children: [
                            Text("Requested Change: ${widget.fieldModel.requestChangeModel?.dataName ?? ""}"),
                            CIA_SecondaryButton(
                                label: "Clear Request",
                                onTab: () {
                                  widget.fieldModel.requestChangeModel = null;
                                  widget.fieldModel.requestChangeId = null;
                                  setState(() {});
                                })
                          ],
                        )),
                  ),
                  CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                    label: "Assistant",
                    asyncUseCase: sl<LoadUsersUseCase>(),
                    searchParams: LoadUsersEnum.assistants,
                    selectedItem: widget.fieldModel.doneByAssistant,
                    onSelect: (value) {
                      widget.fieldModel.doneByAssistant = value;
                      widget.fieldModel.doneByAssistantID = value.id;
                      //widget.bloc.tempSuperVisor = value;
                    },
                  ),
                  CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                    label: "Supervisor",
                    asyncUseCase: sl<LoadUsersUseCase>(),
                    searchParams: LoadUsersEnum.supervisors,
                    selectedItem: widget.fieldModel.doneBySupervisor,
                    onSelect: (value) {
                      widget.fieldModel.doneBySupervisor = value;
                      widget.fieldModel.doneBySupervisorID = value.id;
                      widget.bloc.tempSuperVisor = value;
                    },
                  ),
                  CIA_DropDownSearchBasicIdName(
                    label: "Candidate Batch",
                    asyncUseCase: sl<LoadCandidateBatchesUseCase>(),
                    selectedItem: widget.fieldModel.doneByCandidateBatch,
                    onSelect: (value) {
                      widget.fieldModel.doneByCandidateBatch = value;
                      widget.fieldModel.doneByCandidateBatchID = value.id;
                      widget.bloc.tempCandidateBatch = value;
                      setState(() {});
                    },
                  ),
                  CIA_DropDownSearchBasicIdName<int>(
                    label: "Candidate",
                    asyncUseCase: widget.fieldModel.doneByCandidateBatchID == null ? null : sl<LoadCandidatesByBatchId>(),
                    searchParams: widget.fieldModel.doneByCandidateBatchID ?? 0,
                    selectedItem: widget.fieldModel.doneByCandidate,
                    onSelect: (value) {
                      widget.fieldModel.doneByCandidate = value;
                      widget.fieldModel.doneByCandidateID = value.id;
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
                                tooth: widget.tooth,
                                action: "implant",
                              ));
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  FormTextKeyWidget(text: "Tooth: ${widget.tooth} || "),
                                  FormTextKeyWidget(text: widget.title),
                                ],
                              ),
                              SizedBox(height: 10),
                              CIA_TextFormField(
                                label: "Price",
                                isNumber: true,
                                suffix: "EGP",
                                onChange: (value) => widget.fieldModel.planPrice = int.parse(value),
                                controller: TextEditingController(
                                  text: widget.fieldModel.planPrice?.toString() ?? widget.settingsPrice?.toString() ?? "0",
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
      widget.fieldModel.doneByAssistant = BasicNameIdObjectEntity();
      widget.fieldModel.doneByAssistantID = null;
      widget.fieldModel.doneByCandidate = BasicNameIdObjectEntity();
      widget.fieldModel.doneByCandidateID = null;
      widget.fieldModel.doneByCandidateBatch = BasicNameIdObjectEntity();
      widget.fieldModel.doneByCandidateBatchID = null;
      widget.fieldModel.implantID = null;
      widget.fieldModel.implant = BasicNameIdObjectEntity();
      widget.fieldModel.doneBySupervisor = BasicNameIdObjectEntity();
      widget.fieldModel.doneBySupervisorID = null;
      setState(() {});
    }
  }
}
