import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Models/LAB_RequestModel.dart';
import '../../../Pages/LAB_Pages/LAB_ViewTask.dart';
import '../../../Pages/SharedPages/LapCreateNewRequestSharedPage.dart';
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

  @override
  void initState() {
    medicalShellBloc = BlocProvider.of<MedicalInfoShellBloc>(context);
    blocInfo = BlocProvider.of<CreateOrViewPatientBloc>(context);
    blocImage = BlocProvider.of<ImageBloc>(context);

    blocInfo.add(GetPatientInfoEvent(id: widget.patientId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: false));

      return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              children: [
                BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeTitleState,
                  builder: (context, state) {
                    return Expanded(
                      child: TitleWidget(
                        showBackButton: true,
                        title: state is MedicalInfoBlocChangeTitleState ? state.title : "",
                      ),
                    );
                  },
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
                Expanded(child: SizedBox()),
                BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                  builder: (context, state) {
                    if (state is LoadedPatientInfoState) {
                      PatientInfoEntity patient = state.patient;
                      if (patient.profileImageId != null) blocImage.downloadImageEvent(patient.profileImageId!);
                      return Expanded(
                        flex: 10,
                        child: Column(
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
                                  context.goNamed(CreateOrViewPatientPage.viewPatientRouteName, pathParameters: {"id": widget.patientId.toString()});
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            CIA_SecondaryButton(
                                label: "Create LAB Request",
                                icon: Icon(Icons.document_scanner_outlined),
                                onTab: () async {
                                  /*var checkLabRequests = await MedicalAPI.CheckLabRequests(widget.patientId);
                                  bool showRequestPage = false;
                                  if (checkLabRequests.statusCode != 200) {
                                    await CIA_ShowPopUpYesNo(
                                        width: 800,
                                        context: context,
                                        title: "Patient has incomplete requests are you sure you want to create new request?",
                                        onSave: () {
                                          showRequestPage = true;
                                        });
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
                                label: "View LAB Request",
                                icon: const Icon(Icons.document_scanner_outlined),
                                onTab: () {
                                  LabRequestDataSource dataSource = LabRequestDataSource();
                                  CIA_ShowPopUp(
                                    hideButton: true,
                                    context: context,
                                    width: 1100,
                                    height: 650,
                                    onSave: () {},
                                    child: CIA_Table(
                                      columnNames: dataSource.columns,
                                      dataSource: dataSource,
                                      loadFunction: () async {
                                        return dataSource.loadPatientRequests(patient!.id!);
                                      },
                                      onCellClick: (index) {
                                        CIA_ShowPopUp(
                                            width: 1100,
                                            height: 650,
                                            context: context,
                                            child: LAB_ViewTaskPage(
                                              id: dataSource.models[index - 1].id!,
                                            ));
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
                                      label: "View mode",
                                      onTab: () => medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: false)));
                                return CIA_PrimaryButton(
                                  label: "Edit mode",
                                  onTab: () =>  medicalShellBloc.add(MedicalInfoShell_ChangeViewEditEvent(allowEdit: true)),
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
                                    text: patient?.id.toString() == null ? "" : patient?.id.toString(),
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
                          ],
                        ),
                      );
                    } else if (state is LoadingError)
                      return Text(
                        "Error loading patient info",
                        style: TextStyle(color: Colors.red),
                      );
                    else
                      return LoadingWidget();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
