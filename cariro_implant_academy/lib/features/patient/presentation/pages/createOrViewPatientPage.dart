import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/MedicalModels/NonSurgicalTreatment.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/PaymentLogModel.dart';
import 'package:cariro_implant_academy/Models/ReceiptModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/receiptTableWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSeachBlocStates.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../Widgets/SnackBar.dart';
import '../../../../core/injection_contianer.dart';
import '../../domain/entities/patientInfoEntity.dart';
import '../bloc/createOrViewPatientBloc_Events.dart';

class CreateOrViewPatientPage extends StatelessWidget {
  const CreateOrViewPatientPage({
    Key? key,
    required this.patientID,
  }) : super(key: key);

  static String getPathViewPatient(String id) {
    return "/CIA/Patients/$id/ViewPatient";
  }

  static String getPathAddPatient(String id) {
    return "/CIA/Patients/AddPatient";
  }

  static String viewPatientRouteName = "ViewPatient";
  static String viewPatientRoutePath = "Patients/:id/ViewPatient";
  static String addPatientRouteName = "AddPatient";
  static String addPatientRoutePath = "AddPatient";

  final int patientID;

  final double imageWidth = 200;
  final double imageHeight = 200;

  //PatientInfoModel patient = PatientInfoModel(patientType: EnumPatientType.CIA);

  @override
  Widget build(BuildContext context) {

    PatientInfoEntity patient = PatientInfoEntity(gender: EnumGender.Male, maritalStatus: EnumMaritalStatus.Married);
    final createOrViewPatientBloc = BlocProvider.of<CreateOrViewPatientBloc>(context);
    final imageBlocProfile = sl<ImageBloc>();
    final imageBlocIdBack = sl<ImageBloc>();
    final imageBlocIdFront = sl<ImageBloc>();
    if (patientID == 0) {
      createOrViewPatientBloc.add(ChangePageStateEvent(pageState: PageState.addNew));
      createOrViewPatientBloc.add(InitialEvent());
      createOrViewPatientBloc.emit(LoadedPatientInfoState(patient: patient));
    } else
      createOrViewPatientBloc.add(GetPatientInfoEvent(id: patientID));

    return BlocConsumer<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
      listener: (context, state) {
        if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew) {
          patient.maritalStatus = EnumMaritalStatus.Married;
          patient.gender = EnumGender.Male;
        } else if (state is LoadedPatientInfoState) {
          if (state.patient.profileImageId != null) imageBlocProfile.downloadImageEvent(state.patient.profileImageId!);
          if (state.patient.idBackImageId != null) imageBlocIdBack.downloadImageEvent(state.patient.idBackImageId!);
          if (state.patient.idFrontImageId != null) imageBlocIdFront.downloadImageEvent(state.patient.idFrontImageId!);
        }
        if (state is Error)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is CreatedPatientState) {
          ShowSnackBar(context, isSuccess: true);
          createOrViewPatientBloc.add(InitialEvent());
          createOrViewPatientBloc.emit(LoadedPatientInfoState(
              patient: PatientInfoEntity(
            gender: EnumGender.Male,
            maritalStatus: EnumMaritalStatus.Married,
          )));
        } else if (state is UpdatingPatientErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is UpdatedPatientSuccessfully) {
          patient = state.patient;
          ShowSnackBar(context, isSuccess: true);
        }

        if (state is CreatingPatientState || state is UpdatingPatientState)
          CustomLoader.show(context);
        // context.loaderOverlay.show();
        else
          CustomLoader.hide();
      },
      buildWhen: (previous, current) => current is LoadedPatientInfoState,
      builder: (context, state) {
        if (state is LoadedPatientInfoState) {
          patient = state.patient;
        }
        if (state is LoadingPatientInfoState)
          return LoadingWidget();
        else
          return Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                TitleWidget(title: "Patient's Data", showBackButton: true),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: FocusTraversalGroup(
                          policy: OrderedTraversalPolicy(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                    buildWhen: (previous, current) => current is ChangePageState,
                                    builder: (context, state) {
                                      if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew)
                                        return Container();
                                      else
                                        return CIA_PrimaryButton(
                                            label: "Show Receipts and Payments",
                                            onTab: () {
                                              ReceiptTableWidget(patientId: patientID, context: context)();
                                            });
                                    },
                                  ),
                                  Expanded(child: SizedBox())
                                ],
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew)
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                            buildWhen: (previous, current) => current is LoadedGetNextId,
                                            builder: (context, state) {
                                              if (state is LoadedGetNextId) patient.id = int.parse(state.message ?? "0");
                                              return CIA_TextFormField(
                                                isNumber: true,
                                                onChange: (value) async {
                                                  patient.id = int.parse(value);
                                                  createOrViewPatientBloc.add(CheckAvailableIdEvent(int.parse(value)));
                                                },
                                                label: "Id",
                                                controller: TextEditingController(text: (patient.id ?? "").toString()),
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
                                            if (state is LoadedGetNextId)
                                              return FormTextValueWidget(
                                                text: state.message,
                                              );
                                            else
                                              return Container();
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                          buildWhen: (previous, current) => current is LoadedAvailableId,
                                          builder: (context, state) {
                                            if (state is LoadedAvailableId)
                                              return FormTextValueWidget(
                                                text: state.message ?? "",
                                                color: state.message == null ? Colors.green : Colors.red,
                                              );
                                            else
                                              return Container();
                                          },
                                        )
                                      ],
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "ID")),
                                        Expanded(child: FormTextValueWidget(text: patient?.id.toString() == null ? "" : patient?.id.toString()))
                                      ],
                                    );
                                },
                              ),


                         BlocBuilder<CreateOrViewPatientBloc,CreateOrViewPatientBloc_State>(
                           buildWhen: (previous, current) => current is ChangePageState,

                           builder: (context, state) {
                             bool visible = false;
                             if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew && siteController.getSite()==Website.Lab)
                               {
                                 visible = true;
                               }

                               return  Visibility(
                             visible:visible,
                             child: CIA_MultiSelectChipWidget(
                               key: GlobalKey(),
                               singleSelect: true,
                               onChange: (item, isSelected) {
                                 if (isSelected) {
                                   if (item == "CIA")
                                     patient.patientType = EnumPatientType.CIA;
                                   else if (item == "Clinic")
                                     patient.patientType = EnumPatientType.Clinic;
                                   else if (item == "OutSource") patient.patientType = EnumPatientType.OutSource;
                                 }
                               },
                               labels: [
                                 CIA_MultiSelectChipWidgeModel(label: "CIA", isSelected: patient.patientType == EnumPatientType.CIA),
                                 CIA_MultiSelectChipWidgeModel(label: "Clinic", isSelected: patient.patientType == EnumPatientType.Clinic),
                                 CIA_MultiSelectChipWidgeModel(label: "OutSource", isSelected: patient.patientType == EnumPatientType.OutSource),
                               ],
                             ),
                           );
                         },),

                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew)
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.name = value;
                                      },
                                      label: "Name",
                                      controller: TextEditingController(text: patient?.name == null ? "" : patient?.name),
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Name")),
                                        Expanded(child: FormTextValueWidget(text: patient?.name == null ? "" : patient?.name))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew)
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
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "National Id")),
                                        Expanded(child: FormTextValueWidget(text: patient?.nationalId == null ? "" : patient?.nationalId))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew)
                                    return HorizontalRadioButtons(
                                      names: ["Male", "Female"],
                                      groupValue: "Male",
                                      onChange: (p0) {
                                        patient.gender = mapToEnum(EnumGender.values, p0);
                                      },
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Gender")),
                                        Expanded(child: FormTextValueWidget(text: getEnumName(patient.gender)))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState &&
                                      (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit))
                                    return CIA_TextFormField(
                                      onChange: (value) async {
                                        createOrViewPatientBloc.add(CheckDuplicateNumberEvent(value));
                                        patient.phone = value;
                                      },
                                      isPhoneNumber: true,
                                      label: "Phone Number",
                                      controller: TextEditingController(text: patient?.phone == null ? "" : patient?.phone),
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Phone Number")),
                                        Expanded(child: FormTextValueWidget(text: patient?.phone == null ? "" : patient?.phone))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is LoadedDuplicateNumber,
                                builder: (context, state) {
                                  if (state is LoadedDuplicateNumber && state.name != null)
                                    return FormTextKeyWidget(
                                      color: Colors.red,
                                      text: "Duplicate found patient: ${state.name}",
                                    );
                                  else
                                    return Container();
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState &&
                                      (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit))
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.phone2 = value;
                                      },
                                      isPhoneNumber: true,
                                      label: "Another Phone Number",
                                      controller: TextEditingController(text: patient?.phone2 == null ? "" : patient?.phone2),
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Another Phone Number")),
                                        Expanded(child: FormTextValueWidget(text: patient?.phone2 == null ? "" : patient?.phone2))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState || current is ChangedDateOfBirthState,
                                builder: (context, state) {
                                  if (state is ChangedDateOfBirthState || (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew))
                                    return CIA_DateTimeTextFormField(
                                      onTap: () {
                                        CIA_PopupDialog_DateOnlyPicker(context, "Date of birth", (date) {
                                          patient.dateOfBirth = date;
                                          createOrViewPatientBloc.emit(ChangedDateOfBirthState(date: date));
                                        });
                                      },
                                      onChange: (value) {
                                        patient.dateOfBirth = value;
                                      },
                                      label: "Date Of Birth",
                                      controller: TextEditingController(
                                          text: patient?.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy").format(patient!.dateOfBirth!)),
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Date Of Birth")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                                text: patient?.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy").format(patient!.dateOfBirth!)))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState &&
                                      (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit))
                                    return HorizontalRadioButtons(
                                      names: ["Married", "Single"],
                                      onChange: (v) {
                                        patient.maritalStatus = mapToEnum(EnumMaritalStatus.values, v);
                                      },
                                      groupValue: getEnumName(patient.maritalStatus) ?? "Married",
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Marital Status")),
                                        Expanded(child: FormTextValueWidget(text: getEnumName(patient.maritalStatus) ?? ""))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState &&
                                      (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit))
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.address = value;
                                      },
                                      label: "Address",
                                      controller: TextEditingController(text: patient?.address == null ? "" : patient?.address),
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Address")),
                                        Expanded(child: FormTextValueWidget(text: patient?.address == null ? "" : patient?.address))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState,
                                builder: (context, state) {
                                  if (state is ChangePageState &&
                                      (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit))
                                    return CIA_TextFormField(
                                      onChange: (value) {
                                        patient.city = value;
                                      },
                                      label: "City",
                                      controller: TextEditingController(text: patient?.city == null ? "" : patient?.city),
                                    );
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "City")),
                                        Expanded(child: FormTextValueWidget(text: patient?.city == null ? "" : patient?.city))
                                      ],
                                    );
                                },
                              ),
                              BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                buildWhen: (previous, current) => current is ChangePageState || current is ChangedPatientRelative,
                                builder: (context, state) {
                                  if (state is ChangedPatientRelative || (state is ChangePageState && createOrViewPatientBloc.pageState == PageState.addNew))
                                    return CIA_TextFormField(
                                      onTap: () {
                                        CIA_ShowPopUp(
                                            context: context,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                CIA_TextFormField(
                                                  label: "Search",
                                                  controller: TextEditingController(),
                                                  onChange: (value) async {
                                                    createOrViewPatientBloc.add(SearchPatientsEvent(query: value));
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
                                                                createOrViewPatientBloc.emit(ChangedPatientRelative());
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
                                  else
                                    return Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Relative")),
                                        Expanded(child: FormTextValueWidget(text: patient.relative ?? ""))
                                      ],
                                    );
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: FormTextKeyWidget(
                                    text: "", // "Registration: ${addNew ? siteController.getUser().name! : patient.registeredBy!.name!}",
                                    secondaryInfo: true,
                                  )),
                                  Expanded(
                                      child: FormTextValueWidget(
                                    text: "", // addNew ? DateTime.now().toLocal().toString() : patient.registerationDate ?? "",
                                    secondaryInfo: true,
                                  ))
                                ],
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
                                    if (state is ImageLoadingState || state is ImageUploadingState)
                                      return LoadingWidget();
                                    else if (state is ImageLoadedState) {
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
                                      visible: state is ChangePageState &&
                                          (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit),
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
                                          if (state is ImageLoadingState || state is ImageUploadingState)
                                            return LoadingWidget();
                                          else if (state is ImageLoadedState) {
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
                                            visible: state is ChangePageState &&
                                                (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit),
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
                                          if (state is ImageLoadingState || state is ImageUploadingState)
                                            return LoadingWidget();
                                          else if (state is ImageLoadedState) {
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
                                            visible: state is ChangePageState &&
                                                (createOrViewPatientBloc.pageState == PageState.addNew || createOrViewPatientBloc.pageState == PageState.edit),
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
                  bloc: createOrViewPatientBloc,
                  builder: (context, state) {
                    if (state is ChangePageState && (createOrViewPatientBloc.pageState == PageState.addNew))
                      return Center(
                        child: CIA_PrimaryButton(
                            label: "Save",
                            isLong: true,
                            onTab: () async {
                              createOrViewPatientBloc.add(CreatePatientEvent(patient: patient));
                            }),
                      );
                    else if (state is ChangePageState && (createOrViewPatientBloc.pageState == PageState.edit))
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: SizedBox()),
                            Flexible(
                              child: CIA_SecondaryButton(
                                  label: "Cancel", onTab: () => createOrViewPatientBloc.add(ChangePageStateEvent(pageState: PageState.view))),
                            ),
                            Flexible(
                              child: CIA_PrimaryButton(
                                  label: "Save",
                                  isLong: true,
                                  onTab: () {
                                    createOrViewPatientBloc.add(ChangePageStateEvent(pageState: PageState.view));
                                    createOrViewPatientBloc.add(UpdatePatientDataEvent(patient: patient));
                                    if (patient.idBackImage != null)
                                      imageBlocIdBack.uploadImageEvent(UploadImageParams(
                                        id: patientID,
                                        type: EnumImageType.IdBack,
                                        data: patient.idBackImage!,
                                      ));
                                    if (patient.idFrontImage != null)
                                      imageBlocIdFront.uploadImageEvent(UploadImageParams(
                                        id: patientID,
                                        type: EnumImageType.IdFront,
                                        data: patient.idFrontImage!,
                                      ));
                                    if (patient.profileImage != null)
                                      imageBlocProfile.uploadImageEvent(UploadImageParams(
                                        id: patientID,
                                        type: EnumImageType.PatientProfile,
                                        data: patient.profileImage!,
                                      ));
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
                            createOrViewPatientBloc.add(ChangePageStateEvent(pageState: PageState.edit));
                          },
                          label: "Edit Info",
                        ),
                      );
                  },
                ),
              ],
            ),
          );
      },
    );
  }
}
