import 'package:cariro_implant_academy/Constants/Controllers.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    labRequestsBloc = sl<LabRequestsBloc>();
    blocInfo = BlocProvider.of<CreateOrViewPatientBloc>(context);
    blocImage = BlocProvider.of<ImageBloc>(context);

    blocInfo.add(GetPatientInfoEvent(id: widget.patientId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: false));

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
                      SizedBox(width: 10,),
                      Expanded(
                        child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                          buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                          builder: (context, state) {
                            return AbsorbPointer(
                              absorbing: state is MedicalInfoBlocChangeViewEditState? !state.edit:false,
                              child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                                buildWhen: (previous, current) => current is MedicalInfoBlocChangeDateState,
                                builder: (context, state) {
                                  if (state is MedicalInfoBlocChangeDateState) state.data.date = state.date;
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      child: Text( "Date: "+
                                        (state is MedicalInfoBlocChangeDateState
                                                ? state.date == null
                                                    ? ""
                                                    : DateFormat("dd-MM-yyyy").format(state.date!)
                                                : "") +
                                            (siteController.getRole()=="admin"? " Click To Edit":" Only Admin can edit"),
                                        style: TextStyle(),
                                      ),
                                      onTap: () =>siteController.getRole()!="admin"?null:  CIA_PopupDialog_DateOnlyPicker(
                                          context,
                                          "Pick Date",
                                          (date) => medicalShellBloc.emit(
                                              MedicalInfoBlocChangeDateState(date: date, data: state is MedicalInfoBlocChangeDateState ? state.data : null))),
                                    ),
                                  );
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
                  SizedBox(width:10),
                  Expanded(
                    child: BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
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
                                  icon: Icon(Icons.document_scanner_outlined),
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
                                          else if (state is LabRequestsBloc_LoadingRequestsErrorState) return BigErrorPageWidget(message: state.message);
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
                              BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                                buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                                builder: (context, state) {
                                  if (state is MedicalInfoBlocChangeViewEditState && state.edit)
                                    return CIA_SecondaryButton(
                                        label: "View mode", onTab: () => medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: false)));
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
                                  FormTextValueWidget(text: patient.out? "Patient Out!":""),
                                  Icon(Icons.circle,color: patient.out? Colors.red:Colors.green,),
                                ],
                              ),
                              CIA_PrimaryButton(label: "Save", onTab: (){
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
