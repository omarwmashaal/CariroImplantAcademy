import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/checkLabRequestsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/toDoListBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/toDoListBloc_States.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSeachBlocStates.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSearchBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../../features/labRequest/domain/entities/labRequestEntityl.dart';
import '../../../features/labRequest/presentation/pages/LAB_ViewTask.dart';
import '../../../features/labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import '../../../Widgets/CIA_PopUp.dart';
import '../../../Widgets/CIA_PrimaryButton.dart';
import '../../../Widgets/CIA_SecondaryButton.dart';
import '../../../Widgets/CIA_Table.dart';
import '../../../Widgets/FormTextWidget.dart';
import '../../../Widgets/Title.dart';
import '../../../features/patient/presentation/pages/createOrViewPatientPage.dart';

class MedicalInfoShellPage extends StatefulWidget {
  MedicalInfoShellPage({Key? key, required this.patientId, required this.child}) : super(key: key);
  int patientId;
  Widget child;

  @override
  State<MedicalInfoShellPage> createState() => _MedicalInfoShellPageState();
}

class _MedicalInfoShellPageState extends State<MedicalInfoShellPage> {
  late MedicalInfoShellBloc medicalShellBloc;
  late CreateOrViewPatientBloc blocInfo;
  late ImageBloc blocImage;
  late LabRequestsBloc labRequestsBloc;
  late ToDoListBloc toDoListBloc;

  @override
  void initState() {
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    labRequestsBloc = sl<LabRequestsBloc>();
    blocInfo = BlocProvider.of<CreateOrViewPatientBloc>(context);
    blocImage = BlocProvider.of<ImageBloc>(context);
    toDoListBloc = context.read<ToDoListBloc>();

    blocInfo.add(GetPatientInfoEvent(id: widget.patientId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: false));
    toDoListBloc.getToList(widget.patientId);
    return BlocListener<LabRequestsBloc, LabRequestsBloc_States>(
      bloc: labRequestsBloc,
      listener: (context, state) {
        if (state is LabRequestsBloc_CreatedLabRequestSuccessfullyState) dialogHelper.dismissAll(context);
      },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                        buildWhen: (previous, current) => current is MedicalInfoBlocChangeTitleState,
                        builder: (context, state) {
                          return TitleWidget(
                            showBackButton: true,
                            title: state is MedicalInfoBlocChangeTitleState ? state.title : "",
                          );
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                          buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                          builder: (context, state) {
                            return AbsorbPointer(
                              absorbing: state is MedicalInfoBlocChangeViewEditState ? !state.edit : false,
                              child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                                buildWhen: (previous, current) => current is MedicalInfoBlocChangeDateState,
                                builder: (context, state) {
                                  // if (state is MedicalInfoBlocChangeDateState && state.dontChange != true) state.data.date = state.date;
                                  // if (state is MedicalInfoBlocChangeDateState && state.dontChange != true)
                                  //   return MouseRegion(
                                  //     cursor: SystemMouseCursors.click,
                                  //     child: CIA_GestureWidget(
                                  //       child: Text(
                                  //         "Date: " +
                                  //             (state is MedicalInfoBlocChangeDateState
                                  //                 ? state.date == null
                                  //                     ? ""
                                  //                     : DateFormat("dd-MM-yyyy").format(state.date!)
                                  //                 : "") +
                                  //             (siteController.getRole()!.contains("admin") ? " Click To Edit" : " Only Admin can edit"),
                                  //         style: TextStyle(),
                                  //       ),
                                  //       onTap: () => (!siteController.getRole()!.contains("admin"))
                                  //           ? null
                                  //           : CIA_PopupDialog_DateOnlyPicker(context, "Pick Date", (date) {
                                  //               medicalShellBloc.emit(MedicalInfoBlocChangeDateState(
                                  //                   date: date, data: state is MedicalInfoBlocChangeDateState ? state.data : null));
                                  //             }),
                                  //     ),
                                  //   );
                                  return Container();
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: widget.child,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: BlocConsumer<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                      listener: (context, state) {
                        if (state is LoadedPatientInfoState && state.patient.listed != true) {
                          context.goNamed(CreateOrViewPatientPage.getViewRouteName(), pathParameters: {"id": widget.patientId.toString()});
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadedPatientInfoState) {
                          PatientInfoEntity patient = state.patient;
                          if (patient.profileImageId != null) blocImage.downloadImageEvent(patient.profileImageId!);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ImageBloc, ImageBloc_State>(
                                bloc: blocImage,
                                builder: (context, state) {
                                  if (state is ImageLoadingState) {
                                    return LoadingWidget();
                                  } else if (state is ImageLoadedState) {
                                    return Image(
                                      image: MemoryImage(state.image!),
                                      height: 100,
                                      width: 100,
                                    );
                                  }
                                  return const Image(
                                    image: AssetImage("assets/ProfileImage.png"),
                                    height: 100,
                                    width: 100,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CIA_SecondaryButton(
                                  label: "View more info",
                                  onTab: () {
                                    context.goNamed(CreateOrViewPatientPage.getViewRouteName(), pathParameters: {"id": widget.patientId.toString()});
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              CIA_SecondaryButton(
                                  label: "Create LAB Request",
                                  icon: Icon(
                                    Icons.document_scanner_outlined,
                                  ),
                                  onTab: () async {
                                    print('check lab request');
                                    bool showRequestsPage = (await sl<CheckLabRequestsUseCase>()(patient.id!)).isRight();
                                    if (!showRequestsPage) {
                                      await CIA_ShowPopUpYesNo(
                                          width: 800,
                                          context: context,
                                          title: "Patient has incomplete requests are you sure you want to create new request?",
                                          onSave: () {
                                            showRequestsPage = true;
                                          });
                                    }
                                    if (showRequestsPage)
                                      CIA_ShowPopUp(
                                        hideButton: true,
                                        context: context,
                                        width: 1100,
                                        height: 650,
                                        child: LabCreateNewRequestPage(
                                          isDoctor: true,
                                          patientId: patient.id,
                                          fixDismiss: true,
                                        ),
                                      );
                                    /*var checkLabRequests = await MedicalAPI.CheckLabRequests(widget.patientId);
                                  bool showRequestPage = false;
                                  if (checkLabRequests.statusCode != 200) {

                                  } else
                                    showRequestPage = true;
                                  if (showRequestPage)
                                    CIA_ShowPopUp(
                                      hideButton: true,
                                      context: context,
                                      width: 1100,
                                      height: 650,
                                      child: LabCreateNewRequestSharedPage(isDoctor: true, patient: patient),
                                    );
                                */
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              CIA_SecondaryButton(
                                  label: "View LAB Requests",
                                  icon: const Icon(Icons.document_scanner_outlined),
                                  onTab: () {
                                    LabRequestDataGridSource dataSource = LabRequestDataGridSource();
                                    labRequestsBloc.add(LabRequestsBloc_GetPatientsRequestsEvent(patientId: patient.id!));
                                    CIA_ShowPopUp(
                                      hideButton: true,
                                      context: context,
                                      width: 1100,
                                      height: 650,
                                      onSave: () {},
                                      child: BlocConsumer<LabRequestsBloc, LabRequestsBloc_States>(
                                        bloc: labRequestsBloc,
                                        listener: (context, state) {
                                          if (state is LabRequestsBloc_LoadedMultiRequestsSuccessfullyState) dataSource.updateData(state.requests);
                                        },
                                        buildWhen: (previous, current) =>
                                            current is LabRequestsBloc_LoadingRequestsErrorState ||
                                            current is LabRequestsBloc_LoadedMultiRequestsSuccessfullyState ||
                                            current is LabRequestsBloc_LoadingRequestsState,
                                        builder: (context, state) {
                                          if (state is LabRequestsBloc_LoadingRequestsState)
                                            return LoadingWidget();
                                          else if (state is LabRequestsBloc_LoadingRequestsErrorState)
                                            return BigErrorPageWidget(message: state.message);
                                          return TableWidget(
                                            dataSource: dataSource,
                                            onCellClick: (index) {
                                              CIA_ShowPopUp(
                                                  width: 1100,
                                                  height: 650,
                                                  context: context,
                                                  child: LAB_ViewRequestPage(
                                                    id: index,
                                                  ));
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ToDoListBloc, ToDoListBloc_States>(
                                builder: (context, state) {
                                  List<ToDoListEntity> toList = [];
                                  String text = "";
                                  if (state is ToDoListBlocState_GettingDataFailed)
                                    text = "To Do List: error";
                                  else if (state is ToDoListBlocState_GettingDataSuccess) {
                                    text = "To Do List: \n waiting: ${state.data?.where((element) => !element.done).toList().length ?? 0}";
                                    toList = state.data;
                                  } else
                                    text = "To Do List";
                                  return CIA_SecondaryButton(
                                      label: text,
                                      icon: const Icon(Icons.check_box),
                                      onTab: () {
                                        CIA_ShowPopUp(
                                          hideButton: true,
                                          context: context,
                                          height: 650,
                                          width: double.maxFinite,
                                          onSave: () {},
                                          child: BlocConsumer<ToDoListBloc, ToDoListBloc_States>(
                                            listener: (context, state) {
                                              if (state is ToDoListBlocState_UpdatingDataState ||
                                                  state is ToDoListBlocState_AddingDataState ||
                                                  state is ToDoListBlocState_GettingDataState)
                                                CustomLoader.show(context);
                                              else {
                                                CustomLoader.hide();
                                                if (state is ToDoListBlocState_AddingDataSuccess || state is ToDoListBlocState_UpdatingDataSuccess) {
                                                  ShowSnackBar(context, isSuccess: true);
                                                  toDoListBloc.getToList(widget.patientId);
                                                } else if (state is ToDoListBlocState_AddingDataFailed)
                                                  ShowSnackBar(context, isSuccess: false, message: state.message);
                                                else if (state is ToDoListBlocState_GettingDataFailed)
                                                  ShowSnackBar(context, isSuccess: false, message: state.message);
                                                else if (state is ToDoListBlocState_UpdatingDataFailed)
                                                  ShowSnackBar(context, isSuccess: false, message: state.message);
                                              }
                                            },
                                            buildWhen: (previous, current) =>
                                                current is ToDoListBlocState_AddingDataFailed ||
                                                current is ToDoListBlocState_UpdatingDataFailed ||
                                                current is ToDoListBlocState_GettingDataSuccess ||
                                                current is ToDoListBlocState_GettingDataFailed,
                                            builder: (context, state) {
                                              var dataSource = ToDoListDataGridSource(context, toDoListBloc);

                                              if (state is ToDoListBlocState_AddingDataState ||
                                                  state is ToDoListBlocState_UpdatingDataState ||
                                                  state is ToDoListBlocState_GettingDataState)
                                                return LoadingWidget();
                                              else if (state is ToDoListBlocState_AddingDataFailed)
                                                return BigErrorPageWidget(message: state.message);
                                              else if (state is ToDoListBlocState_GettingDataFailed)
                                                return BigErrorPageWidget(message: state.message);
                                              else if (state is ToDoListBlocState_UpdatingDataFailed)
                                                return BigErrorPageWidget(message: state.message);
                                              else if (state is ToDoListBlocState_GettingDataSuccess) {
                                                toList = state.data;
                                                dataSource.models = toList;
                                                dataSource.init(toList);
                                              }
                                              String newItem = "";
                                              DateTime dueDate = DateTime.now();
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: CIA_TextFormField(
                                                            label: "Data",
                                                            controller: TextEditingController(text: newItem),
                                                            onChange: (value) => newItem = value,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: CIA_DateTimeTextFormField(
                                                            label: "Due Date",
                                                            controller: TextEditingController(text: ""),
                                                            initialDate: dueDate,
                                                            onChange: (value) => dueDate = value,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        CIA_PrimaryButton(
                                                          label: "Add",
                                                          onTab: () {
                                                            toDoListBloc.addToDoListItem(ToDoListEntity(
                                                              data: newItem,
                                                              done: false,
                                                              dueDate: dueDate,
                                                              patientId: widget.patientId,
                                                            ));
                                                          },
                                                          icon: Icon(Icons.add),
                                                          isLong: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Divider(),
                                                  Expanded(
                                                    child: TableWidget(
                                                      dataSource: dataSource,
                                                    ),
                                                    //   child: ListView(
                                                    //     children: toList
                                                    //         .mapIndexed((i, e) => Padding(
                                                    //               padding: const EdgeInsets.all(8.0),
                                                    //               child: Card(
                                                    //                 child: Row(
                                                    //                   children: [
                                                    //                     Text("${i + 1}. "),
                                                    //                     IconButton(
                                                    //                       onPressed: () {
                                                    //                         toDoListBloc.updateToListItem(e, true);
                                                    //                       },
                                                    //                       icon: Icon(
                                                    //                         Icons.delete_forever,
                                                    //                         color: Colors.red,
                                                    //                       ),
                                                    //                     ),
                                                    //                     SizedBox(width: 10),
                                                    //                     Expanded(
                                                    //                       child: CIA_CheckBoxWidget(
                                                    //                         text: e.data,
                                                    //                         value: e.done,
                                                    //                         onChange: (value) {
                                                    //                           e.done = value;
                                                    //                           toDoListBloc.updateToListItem(e, false);
                                                    //                         },
                                                    //                       ),
                                                    //                     ),
                                                    //                     Row(
                                                    //                       children: [
                                                    //                         FormTextValueWidget(
                                                    //                           secondaryInfo: true,
                                                    //                           text: "Created: ${DateFormat("dd-MM-yyyy").format(e.createDate!)}",
                                                    //                         ),
                                                    //                         SizedBox(width: 10),
                                                    //                         FormTextValueWidget(
                                                    //                           secondaryInfo: true,
                                                    //                           text: e.dueDate == null
                                                    //                               ? ""
                                                    //                               : "Due: ${DateFormat("dd-MM-yyyy").format(e.dueDate!)}",
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //             ))
                                                    //         .toList(),
                                                    //   ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                                buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                                builder: (context, state) {
                                  if (state is MedicalInfoBlocChangeViewEditState && state.edit)
                                    return CIA_SecondaryButton(
                                        label: "View mode",
                                        onTab: () => medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: false)));
                                  return CIA_PrimaryButton(
                                    label: "Edit mode",
                                    onTab: () => medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: true)),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: "ID")),
                                  Expanded(
                                    child: FormTextValueWidget(
                                      text: patient?.secondaryId.toString() == null ? "" : patient?.secondaryId.toString(),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: "Name")),
                                  Expanded(
                                    child: FormTextValueWidget(text: patient?.name == null ? "" : patient?.name),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: "Gender")),
                                  Expanded(
                                    child: FormTextValueWidget(text: getEnumName(patient.gender) ?? ""),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  FormTextValueWidget(text: patient.out ? "Patient Out!" : ""),
                                  Icon(
                                    Icons.circle,
                                    color: patient.out ? Colors.red : Colors.green,
                                  ),
                                ],
                              ),
                              CIA_PrimaryButton(
                                  label: "Save",
                                  onTab: () {
                                    medicalShellBloc.add(MedicalInfoShell_SaveChanges());
                                  })
                            ],
                          );
                        } else if (state is LoadingError)
                          return Text(
                            "Error loading patient info",
                            style: TextStyle(color: Colors.red),
                          );
                        else
                          return LoadingWidget();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
