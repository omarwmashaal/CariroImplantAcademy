import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TagsInputWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/receiptTableWidget.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/setPatientOutUseCase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/patientFieldWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../Widgets/SnackBar.dart';
import '../../../../core/injection_contianer.dart';
import '../../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../domain/entities/patientInfoEntity.dart';
import '../bloc/createOrViewPatientBloc_Events.dart';

class CreateOrViewPatientPage extends StatelessWidget {
  CreateOrViewPatientPage({
    Key? key,
    required this.patientID,
    this.onCreatedPatient,
  }) : super(key: key);

  static String getVisitPatientRouteName({bool goToVisit = false}) {
    if (goToVisit || siteController.getRole()!.contains("secretary")) {
      return getViewRouteName();
    }
    return PatientMedicalHistory.getRouteName();
  }

  static String getViewRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicViewPatient";
      default:
        return "ViewPatient";
    }
  }

  static String getAddRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicAddPatient";
      default:
        return "AddPatient";
    }
  }

  static String viewPatientRoutePath = ":id/ViewPatient";
  static String addPatientRoutePath = "AddPatient";

  final int patientID;
  Function(bool success, PatientInfoEntity? patient)? onCreatedPatient;

  final double imageWidth = 200;
  final double imageHeight = 200;

  //PatientInfoModel patient = PatientInfoModel(patientType: EnumPatientType.CIA);

  @override
  Widget build(BuildContext context) {
    PatientInfoEntity patient = PatientInfoEntity(
        gender: EnumGender.Male,
        maritalStatus: EnumMaritalStatus.Married,
        website: siteController.getSite() == Website.Lab ? Website.Private : siteController.getSite());
    final bloc = BlocProvider.of<CreateOrViewPatientBloc>(context);
    final imageBlocProfile = sl<ImageBloc>();
    final imageBlocIdBack = sl<ImageBloc>();
    final imageBlocIdFront = sl<ImageBloc>();
    if (patientID == 0) {
      bloc.add(ChangePageStateEvent(pageState: PageState.addNew, listed: patient.listed!));
      //createOrViewPatientBloc.add(GetNextAvailableIdEvent());
      bloc.emit(LoadedPatientInfoState(patient: patient));
    } else {
      bloc.add(GetPatientInfoEvent(id: patientID));
    }

    return BlocConsumer<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
      listener: (context, state) {
        if (state is ChangePageState && bloc.pageState == PageState.edit) {
          // createOrViewPatientBloc.add(GetNextAvailableIdEvent());
        }
        if (state is ChangePageState && bloc.pageState == PageState.addNew) {
          patient.maritalStatus = EnumMaritalStatus.Married;
          patient.gender = EnumGender.Male;
        } else if (state is LoadedPatientInfoState) {
          if (state.patient.profileImageId != null) imageBlocProfile.downloadImageEvent(state.patient.profileImageId!);
          if (state.patient.idBackImageId != null) imageBlocIdBack.downloadImageEvent(state.patient.idBackImageId!);
          if (state.patient.idFrontImageId != null) imageBlocIdFront.downloadImageEvent(state.patient.idFrontImageId!);
        }
        if (state is Error) {
          if (onCreatedPatient != null) {
            onCreatedPatient!(false, null);
          }
          ShowSnackBar(context, isSuccess: false, message: state.message);
        } else if (state is CreatedPatientState) {
          ShowSnackBar(context, isSuccess: true);
          if (onCreatedPatient != null) {
            onCreatedPatient!(true, state.patient);
          }
          //createOrViewPatientBloc.add(GetNextAvailableIdEvent());
          bloc.emit(LoadedPatientInfoState(
              patient: PatientInfoEntity(
            gender: EnumGender.Male,
            maritalStatus: EnumMaritalStatus.Married,
          )));
        } else if (state is UpdatingPatientErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is UpdatedPatientSuccessfully) {
          patient = state.patient;
          bloc.emit(LoadedPatientInfoState(patient: patient));
          ShowSnackBar(context, isSuccess: true);
        } else if (state is PatientOutSuccessfullyState) {
          bloc.add(GetPatientInfoEvent(id: patientID));
        }

        if (state is CreatingPatientState || state is UpdatingPatientState) {
          CustomLoader.show(context);
        } else {
          CustomLoader.hide();
        }
      },
      buildWhen: (previous, current) => current is LoadedPatientInfoState,
      builder: (context, state) {
        if (state is LoadedPatientInfoState) {
          patient = state.patient;
        }
        if (state is LoadingPatientInfoState) {
          return LoadingWidget();
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    TitleWidget(title: "Patient's Data", showBackButton: true),
                    PatientFieldWidget(
                        bloc: bloc,
                        editOrAddWidget: Container(),
                        viewWidget: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: patient.out ? Colors.red : Colors.green,
                            ),
                            SizedBox(width: 10),
                            Visibility(
                                visible: patient.out,
                                child: CIA_GestureWidget(
                                    onTap: () {
                                      CIA_ShowPopUp(context: context, child: Text(patient.outReason ?? ""));
                                    },
                                    child: Text("Patient Out!. Click to view Reason"))),
                            SizedBox(width: 10),
                            CIA_SecondaryButton(
                              label: "Set Patient ${patient.out ? "Active" : "Out"}",
                              onTab: () => patient.out
                                  ? bloc.add(SetPatientOutEvent(SetPatientOutParams(
                                      id: patientID,
                                      outReason: "",
                                    )))
                                  : CIA_ShowPopUp(
                                      height: 400,
                                      context: context,
                                      onSave: () => bloc.add(SetPatientOutEvent(SetPatientOutParams(
                                            id: patientID,
                                            outReason: patient.outReason ?? "",
                                          ))),
                                      child: CIA_TextFormField(
                                        label: "Reason",
                                        maxLines: 10,
                                        controller: TextEditingController(),
                                        onChange: (v) => patient.outReason = v,
                                      )),
                            ),
                          ],
                        )),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 70,
                      child: BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                        builder: (BuildContext context, CreateOrViewPatientBloc_State state) {
                          return FormTextKeyWidget(text: patient.listed! ? "Listed" : "Unlisted");
                        },
                      ),
                    ),
                    PatientFieldWidget(
                        bloc: bloc,
                        editOrAddWidget: Switch(
                          value: patient.listed ?? false,
                          onChanged: (value) {
                            patient.listed = value;
                            if (value == false) {
                              patient.secondaryId = patient.id?.toString();
                              patient.nationalId = null;
                            }
                            bloc.emit(ChangePageState("", patient.listed!));
                          },
                        ),
                        viewWidget: Container()),
                  ],
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return PatientFieldWidget(
                        bloc: bloc,
                        editOrAddWidget: Visibility(
                            visible: patient.listed != true,
                            child: Row(
                              children: EnumPatientCallHistory.values
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: patient.callHistoryStatus == e
                                            ? CIA_PrimaryButton(
                                                label: AddSpacesToSentence(e.name),
                                                onTab: () => null,
                                                isLong: true,
                                                icon: getDefaulCallHistoryIcon(e),
                                              )
                                            : CIA_SecondaryButton(
                                                label: AddSpacesToSentence(e.name),
                                                icon: getDefaulCallHistoryIcon(e),
                                                onTab: () {
                                                  patient.callHistoryStatus = e;
                                                  bloc.add(UpdatePatientDataEvent(patient: patient));
                                                }),
                                      ))
                                  .toList(),
                            )),
                        viewWidget: Container());
                  },
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: FocusTraversalGroup(
                          policy: OrderedTraversalPolicy(),
                          child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                    buildWhen: (previous, current) => current is ChangePageState,
                                    builder: (context, state) {
                                      if (state is ChangePageState && bloc.pageState == PageState.addNew) {
                                        return Container();
                                      } else {
                                        return CIA_PrimaryButton(
                                            label: "Show Receipts and Payments",
                                            onTab: () {
                                              ReceiptTableWidget(patientId: patientID, context: context)();
                                            });
                                      }
                                    },
                                  ),
                                  Expanded(child: SizedBox())
                                ],
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.listed != true)
                                    return Container();
                                  else {
                                    if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                              buildWhen: (previous, current) => current is LoadedGetNextId,
                                              builder: (context, state) {
                                                if (patient.website == Website.Private) return Container();
                                                if (state is LoadedGetNextId && bloc.pageState == PageState.addNew) {
                                                  patient.secondaryId = state.message ?? "0";
                                                }
                                                return CIA_TextFormField(
                                                  isNumber: true,
                                                  onChange: (value) async {
                                                    patient.secondaryId = value;
                                                    bloc.add(CheckAvailableIdEvent(value));
                                                  },
                                                  label: "Id",
                                                  controller: TextEditingController(text: (patient.secondaryId ?? "").toString()),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          FormTextKeyWidget(text: "Next Available Id"),
                                          SizedBox(width: 10),
                                          BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                            buildWhen: (previous, current) => current is LoadedGetNextId,
                                            builder: (context, state) {
                                              if (state is LoadedGetNextId) {
                                                return FormTextValueWidget(
                                                  text: state.message,
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                            buildWhen: (previous, current) => current is LoadedAvailableId,
                                            builder: (context, state) {
                                              if (state is LoadedAvailableId) {
                                                return FormTextValueWidget(
                                                  text: state.message ?? "",
                                                  color: state.message == null ? Colors.green : Colors.red,
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          )
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "ID")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                                  text: patient?.secondaryId.toString() == null ? "" : patient?.secondaryId.toString()))
                                        ],
                                      );
                                    }
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  bool visible = false;
                                  if (state is ChangePageState && bloc.pageState == PageState.addNew && siteController.getSite() == Website.Lab) {
                                    visible = true;
                                  }

                                  return Visibility(
                                    visible: visible,
                                    child: CIA_MultiSelectChipWidget(
                                      key: GlobalKey(),
                                      singleSelect: true,
                                      onChange: (item, isSelected) {
                                        if (isSelected) {
                                          if (item == "CIA") {
                                            patient.website = Website.CIA;
                                          } else if (item == "Clinic")
                                            patient.website = Website.Clinic;
                                          else if (item == "Private") patient.website = Website.Private;
                                        }
                                        bloc.emit(ChangePageState("", patient.listed ?? true));
                                      },
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "CIA", isSelected: patient.website == Website.CIA),
                                        CIA_MultiSelectChipWidgeModel(label: "Clinic", isSelected: patient.website == Website.Clinic),
                                        CIA_MultiSelectChipWidgeModel(label: "Private", isSelected: patient.website == Website.Private),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.name = value;
                                      },
                                      label: "Name",
                                      controller: TextEditingController(text: patient?.name == null ? "" : patient?.name),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Name")),
                                        Expanded(child: FormTextValueWidget(text: patient?.name == null ? "" : patient?.name))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (patient.listed != true) return Container();
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.nationalId = value;
                                      },
                                      isNumber: true,
                                      label: "National ID",
                                      errorFunction: (value) {
                                        return value.length != 14;
                                      },
                                      controller: TextEditingController(text: patient?.nationalId == null ? "" : patient?.nationalId),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "National Id")),
                                        Expanded(child: FormTextValueWidget(text: patient?.nationalId == null ? "" : patient?.nationalId))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState && bloc.pageState == PageState.addNew) {
                                    return HorizontalRadioButtons(
                                      names: ["Male", "Female"],
                                      groupValue: "Male",
                                      onChange: (p0) {
                                        patient.gender = mapToEnum(EnumGender.values, p0);
                                      },
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Gender")),
                                        Expanded(child: FormTextValueWidget(text: getEnumName(patient.gender)))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return CIA_TextFormField(
                                      onChange: (value) async {
                                        bloc.add(CheckDuplicateNumberEvent(value));
                                        patient.phone = value;
                                      },
                                      isPhoneNumber: true,
                                      label: "Phone Number",
                                      controller: TextEditingController(text: patient?.phone == null ? "" : patient?.phone),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Phone Number")),
                                        Expanded(child: FormTextValueWidget(text: patient?.phone == null ? "" : patient?.phone))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is LoadedDuplicateNumber,
                                builder: (context, state) {
                                  if (state is LoadedDuplicateNumber && state.name != null) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: FormTextKeyWidget(
                                        color: Colors.red,
                                        text: "Duplicate found patient: ${state.name}",
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.phone2 = value;
                                      },
                                      isPhoneNumber: true,
                                      label: "Another Phone Number",
                                      controller: TextEditingController(text: patient?.phone2 == null ? "" : patient?.phone2),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Another Phone Number")),
                                        Expanded(child: FormTextValueWidget(text: patient?.phone2 == null ? "" : patient?.phone2))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState || current is ChangedDateOfBirthState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangedDateOfBirthState ||
                                      (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit))) {
                                    return CIA_DateTimeTextFormField(
                                      onTap: () {
                                        CIA_PopupDialog_DateOnlyPicker(context, "Date of birth", (date) {
                                          patient.dateOfBirth = date;
                                          bloc.emit(ChangedDateOfBirthState(date: date));
                                        });
                                      },
                                      onChange: (value) {
                                        patient.dateOfBirth = value;
                                      },
                                      label: "Date Of Birth",
                                      controller: TextEditingController(
                                          text: patient?.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy").format(patient!.dateOfBirth!)),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Date Of Birth")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy").format(patient!.dateOfBirth!)))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return HorizontalRadioButtons(
                                      names: ["Married", "Single"],
                                      onChange: (v) {
                                        patient.maritalStatus = mapToEnum(EnumMaritalStatus.values, v);
                                      },
                                      groupValue: getEnumName(patient.maritalStatus) ?? "Married",
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Marital Status")),
                                        Expanded(child: FormTextValueWidget(text: getEnumName(patient.maritalStatus) ?? ""))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.address = value;
                                      },
                                      label: "Address",
                                      controller: TextEditingController(text: patient?.address == null ? "" : patient?.address),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Address")),
                                        Expanded(child: FormTextValueWidget(text: patient?.address == null ? "" : patient?.address))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit)) {
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.city = value;
                                      },
                                      label: "City",
                                      controller: TextEditingController(text: patient?.city == null ? "" : patient?.city),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "City")),
                                        Expanded(child: FormTextValueWidget(text: patient?.city == null ? "" : patient?.city))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState || current is ChangedPatientRelative,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangedPatientRelative ||
                                      (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit))) {
                                    return CIA_TextFormField(
                                      onTap: () {
                                        CIA_ShowPopUp(
                                            context: context,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                CIA_TextFormField(
                                                  label: "Search by name or id",
                                                  controller: TextEditingController(),
                                                  onChange: (value) async {
                                                    bloc.add(SearchPatientsEvent(query: value));
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 400,
                                                  child: BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                                    buildWhen: (previous, current) => current is LoadedPatients,
                                                    builder: (context, state) {
                                                      return ListView.builder(
                                                        itemBuilder: (context, index) {
                                                          return ListTile(
                                                            onTap: () {
                                                              if (state is LoadedPatients) {
                                                                patient.relative = state.patients[index].name;
                                                                patient.relativePatientId = state.patients[index].id;
                                                                bloc.emit(ChangedPatientRelative());
                                                              }
                                                            },
                                                            title: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  state is LoadedPatients ? (state as LoadedPatients).patients[index].name ?? "" : "",
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                                Divider()
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        itemCount: state is LoadedPatients ? (state as LoadedPatients).patients.length : 0,
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ));
                                      },
                                      label: "Relative",
                                      controller: TextEditingController(text: patient.relative ?? ""),
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Relative")),
                                        Expanded(child: FormTextValueWidget(text: patient.relative ?? ""))
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState || current is ChangedPatientRelative,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangedPatientRelative ||
                                      (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit))) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: CIA_TagsInputWidget(
                                            dynamicVisibility: true,
                                            key: GlobalKey(),
                                            label: "Missed Teeth",
                                            initialValue: patient.missingTeeth?.map((e) => e.toString()).toList(),
                                            onDelete: (value) {
                                              if (bloc.pageState != PageState.view) patient.missingTeeth?.remove(int.tryParse(value) ?? 0);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        CIA_SecondaryButton(
                                            label: "Add missing teeth",
                                            onTab: () {
                                              CIA_ShowPopUp(
                                                  onSave: () => bloc.emit(LoadedPatientInfoState(patient: patient)),
                                                  context: context,
                                                  width: double.maxFinite,
                                                  child: StatefulBuilder(
                                                    builder: (context, setState) {
                                                      return Column(
                                                        children: [
                                                          CIA_TeethChart(
                                                            showSingleBridgeSelection: false,
                                                            onSingleBridgeChange: (bridge) => null,
                                                            selectedTeeth: patient.missingTeeth ?? [],
                                                            onChange: (selectedTeethList) {
                                                              patient.missingTeeth ??= [];
                                                              patient.missingTeeth = selectedTeethList;
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ));
                                            })
                                      ],
                                    );
                                  } else {
                                    return CIA_TagsInputWidget(
                                      dynamicVisibility: true,
                                      key: GlobalKey(),
                                      label: "Missed Teeth",
                                      initialValue: patient.missingTeeth?.map((e) => e.toString()).toList(),
                                      disableDelete: true,
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState || current is ChangedPatientRelative,
                                builder: (context, state) {
                                  if (patient.website == Website.Private) return Container();
                                  if (state is ChangedPatientRelative ||
                                      (state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit))) {
                                    return Column(
                                      children: [
                                        FormTextKeyWidget(text: "Diseases"),
                                        CIA_MultiSelectChipWidget(
                                          onChange: (value, isSelected) {
                                            DiseasesEnum? disease;
                                            switch (value) {
                                              case "Kidney Disease":
                                                disease = DiseasesEnum.KidneyDisease;
                                                break;
                                              case "Liver Disease":
                                                disease = DiseasesEnum.LiverDisease;
                                                break;
                                              case "Asthma":
                                                disease = DiseasesEnum.Asthma;
                                                break;
                                              case "Psychological":
                                                disease = DiseasesEnum.Psychological;
                                                break;
                                              case "Rhemuatic":
                                                disease = DiseasesEnum.Rhemuatic;
                                                break;
                                              case "Anemia":
                                                disease = DiseasesEnum.Anemia;
                                                break;
                                              case "Epilepsy":
                                                disease = DiseasesEnum.Epilepsy;
                                                break;
                                              case "Heart problem":
                                                disease = DiseasesEnum.HeartProblem;
                                                break;
                                              case "Thyroid":
                                                disease = DiseasesEnum.Thyroid;
                                                break;
                                              case "Hepatitis":
                                                disease = DiseasesEnum.Hepatitis;
                                                break;
                                              case "Venereal Disease":
                                                disease = DiseasesEnum.VenerealDisease;
                                                break;
                                              case "Other":
                                                disease = DiseasesEnum.Other;
                                                break;
                                            }
                                            if (patient.diseases == null) {
                                              patient.diseases = [];
                                            }
                                            if (isSelected) {
                                              patient.diseases?.add(disease!);
                                            } else {
                                              patient.diseases?.remove(disease);
                                            }
                                          },
                                          redFlags: true,
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Kidney Disease",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.KidneyDisease)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Liver Disease",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.LiverDisease)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Asthma",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Asthma)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Psychological",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Psychological)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Rhemuatic",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Rhemuatic)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Anemia",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Anemia)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Epilepsy",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Epilepsy)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Heart problem",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.HeartProblem)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Thyroid",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Thyroid)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Hepatitis",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Hepatitis)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Venereal Disease",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.VenerealDisease)),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Other",
                                                selectedColor: Colors.red,
                                                isSelected: patient.diseases != null && patient.diseases!.contains(DiseasesEnum.Other))
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return CIA_TagsInputWidget(
                                      dynamicVisibility: true,
                                      key: GlobalKey(),
                                      label: "Diseases",
                                      initialValue: patient.diseases?.map((e) => e.name.toString()).toList(),
                                      disableDelete: true,
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: FormTextKeyWidget(
                                        text:
                                            "Registration: ${bloc.pageState == PageState.addNew ? siteController.getUserName() ?? "" : patient.registeredBy}",
                                        secondaryInfo: true,
                                      )),
                                      Expanded(
                                          child: FormTextValueWidget(
                                        text: bloc.pageState == PageState.addNew
                                            ? DateTime.now().toLocal().toString()
                                            : patient.registrationDate == null
                                                ? ""
                                                : DateFormat("dd/MM/yyyy hh:mm a").format(patient.registrationDate!),
                                        secondaryInfo: true,
                                      ))
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BlocBuilder<ImageBloc, ImageBloc_State>(
                                  bloc: imageBlocProfile,
                                  builder: (context, state) {
                                    if (state is ImageLoadingState || state is ImageUploadingState) {
                                      return LoadingWidget();
                                    } else if (state is ImageLoadedState) {
                                      patient.profileImage = state.image;
                                      return Image(
                                        image: MemoryImage(state.image),
                                        height: imageHeight,
                                        width: imageWidth,
                                      );
                                    } else
                                      return Image(
                                        image: AssetImage("assets/ProfileImage.png"),
                                        height: imageHeight,
                                        width: imageWidth,
                                      );
                                  },
                                ),
                                SizedBox(height: 10),
                                BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                  buildWhen: (previous, current) => current is ChangePageState,
                                  builder: (context, state) {
                                    return Visibility(
                                      visible: state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit),
                                      child: CIA_SecondaryButton(
                                          label: "Upload Image",
                                          onTab: () async {
                                            imageBlocProfile.selectImage();
                                            // personalImageBytes = await ImagePickerWeb.getImageAsBytes();
                                            //setState(() {});
                                          }),
                                    );
                                  },
                                ),
                              ],
                            )),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      BlocBuilder<ImageBloc, ImageBloc_State>(
                                        bloc: imageBlocIdFront,
                                        builder: (context, state) {
                                          if (state is ImageLoadingState || state is ImageUploadingState) {
                                            return LoadingWidget();
                                          } else if (state is ImageLoadedState) {
                                            patient.idFrontImage = state.image;
                                            return Image(
                                              image: MemoryImage(state.image),
                                              height: imageHeight,
                                              width: imageWidth,
                                            );
                                          } else
                                            return Image(
                                              image: AssetImage("assets/userIDFront.png"),
                                              height: imageHeight,
                                              width: imageWidth,
                                            );
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                        buildWhen: (previous, current) => current is ChangePageState,
                                        builder: (context, state) {
                                          return Visibility(
                                            visible:
                                                state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit),
                                            child: CIA_SecondaryButton(
                                                label: "Upload Image",
                                                onTab: () async {
                                                  imageBlocIdFront.selectImage();
                                                }),
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      BlocBuilder<ImageBloc, ImageBloc_State>(
                                        bloc: imageBlocIdBack,
                                        builder: (context, state) {
                                          if (state is ImageLoadingState || state is ImageUploadingState) {
                                            return LoadingWidget();
                                          } else if (state is ImageLoadedState) {
                                            patient.idBackImage = state.image;
                                            return Image(
                                              image: MemoryImage(state.image),
                                              height: imageHeight,
                                              width: imageWidth,
                                            );
                                          } else
                                            return Image(
                                              image: AssetImage("assets/userIDBack.png"),
                                              height: imageHeight,
                                              width: imageWidth,
                                            );
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                        buildWhen: (previous, current) => current is ChangePageState,
                                        builder: (context, state) {
                                          return Visibility(
                                            visible:
                                                state is ChangePageState && (bloc.pageState == PageState.addNew || bloc.pageState == PageState.edit),
                                            child: CIA_SecondaryButton(
                                                label: "Upload Image",
                                                onTab: () async {
                                                  imageBlocIdBack.selectImage();
                                                }),
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                  buildWhen: (previous, current) => current is ChangePageState,
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is ChangePageState && (bloc.pageState == PageState.addNew)) {
                      return Center(
                        child: CIA_PrimaryButton(
                            label: "Save",
                            isLong: true,
                            onTab: () async {
                              bloc.add(CreatePatientEvent(patient: patient));
                            }),
                      );
                    } else if (state is ChangePageState && (bloc.pageState == PageState.edit))
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: SizedBox()),
                            Flexible(
                              child: CIA_SecondaryButton(
                                  label: "Cancel",
                                  onTab: () {
                                    bloc.add(ChangePageStateEvent(pageState: PageState.view, listed: patient.listed!));
                                    bloc.add(GetPatientInfoEvent(id: patientID));
                                  }),
                            ),
                            Flexible(
                              child: CIA_PrimaryButton(
                                  label: "Save",
                                  isLong: true,
                                  onTab: () {
                                    bloc.add(ChangePageStateEvent(pageState: PageState.view, listed: patient.listed!));
                                    bloc.add(UpdatePatientDataEvent(patient: patient));
                                    if (patient.idBackImage != null) {
                                      imageBlocIdBack.uploadImageEvent(UploadImageParams(
                                        id: patientID,
                                        type: EnumImageType.IdBack,
                                        data: patient.idBackImage!,
                                      ));
                                    }
                                    if (patient.idFrontImage != null) {
                                      imageBlocIdFront.uploadImageEvent(UploadImageParams(
                                        id: patientID,
                                        type: EnumImageType.IdFront,
                                        data: patient.idFrontImage!,
                                      ));
                                    }
                                    if (patient.profileImage != null) {
                                      imageBlocProfile.uploadImageEvent(UploadImageParams(
                                        id: patientID,
                                        type: EnumImageType.PatientProfile,
                                        data: patient.profileImage!,
                                      ));
                                    }
                                  } /*{
                                          var response = await PatientAPI.UpdatePatientDate(patient);

                                          if (response.statusCode == 200) {
                                            ShowSnackBar(context, isSuccess: true, title: "Succeed!", message: "Uploading Images...");
                                            if (personalImageBytes != null)
                                              response = await PatientAPI.UploadImage(patient.id!, EnumImageType.PatientProfile, personalImageBytes!);
                                            if (backIdImageBytes != null)
                                              response = await PatientAPI.UploadImage(patient.id!, EnumImageType.IdBack, backIdImageBytes!);
                                            if (frontIdImageBytes != null)
                                              response = await PatientAPI.UploadImage(patient.id!, EnumImageType.IdFront, frontIdImageBytes!);

                                            if (response.statusCode == 200) {
                                              ShowSnackBar(context, isSuccess: true, title: "Succeed!", message: "Patient has been added successfully!");
                                            } else
                                              ShowSnackBar(context, isSuccess: false, title: "Failed!", message: "Patient added but failed to upload images");
                                          } else
                                            ShowSnackBar(context, isSuccess: false, title: "Failed!", message: response.errorMessage!);

                                          setState(() {
                                            edit = false;
                                          });
                                        }*/
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                      );
                    else
                      return Center(
                        child: CIA_SecondaryButton(
                          onTab: () {
                            bloc.add(ChangePageStateEvent(pageState: PageState.edit, listed: patient.listed!));
                          },
                          label: "Edit Info",
                        ),
                      );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
