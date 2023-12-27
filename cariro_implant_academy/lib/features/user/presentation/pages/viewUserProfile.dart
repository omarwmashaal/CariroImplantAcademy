import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CandidateDetails.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/enum.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getUsersSessions.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/resetPasswordUseCase.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_States.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/injection_contianer.dart';
import '../../../../presentation/bloc/imagesBloc.dart';
import '../../../patient/presentation/bloc/patientVisitsBloc.dart';
import '../../domain/usecases/changeRoleUseCase.dart';

class ViewUserProfilePage extends StatefulWidget {
  ViewUserProfilePage({Key? key, required this.userId, this.role}) : super(key: key);
  static String routePath = "User/:id/UserProfile";
  static String candidateRouteName = "CandidateProfile";
  static String candidateRouteNameClinic = "ClinicCandidateProfile";
  static String candidateRoutePath = "Candidate/:id/CandidateProfile";
  int userId;

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicUserProfile";
      case Website.Lab:
        return "LabUserProfile";
      default:
        return "UserProfile";
    }
  }

  UserRoles? role;

  @override
  State<ViewUserProfilePage> createState() => _ViewUserProfilePageState();
}

class _ViewUserProfilePageState extends State<ViewUserProfilePage> {
  bool edit = false;
  bool photoChanged = false;

  FocusNode next = FocusNode();
  String? from;
  String? to;
  double imageWidth = 200;
  double imageHeight = 200;
  late UsersBloc bloc;
  late ImageBloc imageBloc;
  late UserEntity user;

  @override
  void initState() {
    bloc = BlocProvider.of<UsersBloc>(context);
    imageBloc = context.read<ImageBloc>();
    bloc.add(UsersBloc_GetUserInfoEvent(id: widget.userId));
    //if (widget.role == UserRoles.Candidate) siteController.setAppBarWidget(tabs: ["Profile", "Data"]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<UsersBloc, UsersBloc_States>(
            listener: (context, state) {
              if (state is UsersBloc_UpdatingUserInfoState || state is UsersBloc_ChangingRoleState) {
                CustomLoader.show(context);
              } else {
                CustomLoader.hide();
              }
              if (state is UsersBloc_UpdatingUserInfoErrorState) {
                ShowSnackBar(context, isSuccess: false, message: state.message);
              } else if (state is UsersBloc_LoadedSingleUserSuccessfullyState) {
                if (state.userData.profileImageId != null) imageBloc.downloadImageEvent(state.userData.profileImageId!);
              } else if (state is UsersBloc_UpdatedUserInfoSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true);
                bloc.add(UsersBloc_SwitchEditViewEvent(edit: false, user: user));
              } else if (state is UsersBloc_LoadingUserErrorState)
                ShowSnackBar(context, isSuccess: false, message: state.message);
              else if (state is UsersBloc_ResettingPasswordErrorState)
                ShowSnackBar(context, isSuccess: false, message: state.message);
              else if (state is UsersBloc_ResetPasswordSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true);
                dialogHelper.dismissSingle(context);
              }
              else if(state is UsersBloc_ChangingRoleErrorState)
                ShowSnackBar(context, isSuccess: false,message: state.message);
              else if(state is UsersBloc_ChangedRoleSuccessfullyState)
                {
                  ShowSnackBar(context, isSuccess: true);
                  bloc.add(UsersBloc_GetUserInfoEvent(id: widget.userId));
                }
            },
          ),
          BlocListener<ImageBloc, ImageBloc_State>(
            bloc: imageBloc,
            listener: (context, state) {
              if (state is ImageUploadedState) bloc.add(UsersBloc_GetUserInfoEvent(id: widget.userId));
            },
          ),
        ],
        child: BlocBuilder<UsersBloc, UsersBloc_States>(
          buildWhen: (previous, current) =>
              current is UsersBloc_LoadingUserState || current is UsersBloc_LoadedSingleUserSuccessfullyState || current is UsersBloc_SwitchEditViewModeState,
          builder: (context, state) {
            if (state is UsersBloc_LoadingUserState) {
              return LoadingWidget();
            } else if (state is UsersBloc_LoadedSingleUserSuccessfullyState || state is UsersBloc_SwitchEditViewModeState) {
              if (state is UsersBloc_LoadedSingleUserSuccessfullyState) {
                user = state.userData;
              } else if (state is UsersBloc_SwitchEditViewModeState) {
                user = state.user;
                edit = state.edit;
              }

              return Column(
                children: [
                  Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
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
                                              TitleWidget(title: "User Profile"),
                                              SizedBox(width: 10),
                                              () {
                                                if (widget.userId == sl<SharedPreferences>().getInt("userid")) {
                                                  return CIA_SecondaryButton(
                                                      label: "Reset Password",
                                                      onTab: () {
                                                        String oldPassword = "";
                                                        String newPassword1 = "";
                                                        String newPassword2 = "";
                                                        bool capital = false;
                                                        bool small = false;
                                                        bool number = false;
                                                        bool symbol = false;
                                                        CIA_ShowPopUp(
                                                            context: context,
                                                            height: 400,
                                                            onSave: () {
                                                              bloc.add(
                                                                UsersBloc_ResetPasswordEvent(
                                                                  params: ResetPasswordParams(
                                                                    newPassword1: newPassword1,
                                                                    newPassword2: newPassword2,
                                                                    oldPassword: oldPassword,
                                                                  ),
                                                                ),
                                                              );
                                                              return false;
                                                            },
                                                            child: StatefulBuilder(builder: (context, _setState) {
                                                              return Column(
                                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                children: [
                                                                  CIA_TextFormField(
                                                                    label: "Old Password",
                                                                    controller: TextEditingController(text: oldPassword),
                                                                    isObscure: true,
                                                                    onChange: (v) => _setState(() {
                                                                      oldPassword = v;
                                                                    }),
                                                                  ),
                                                                  SizedBox(height: 10),
                                                                  CIA_TextFormField(
                                                                    label: "New Password",
                                                                    controller: TextEditingController(text: newPassword1),
                                                                    isObscure: true,
                                                                    onChange: (v) {
                                                                      if (v.contains(RegExp(r'[A-Z]'))) {
                                                                        capital = true;
                                                                      } else {
                                                                        capital = false;
                                                                      }
                                                                      if (v.contains(RegExp(r'[a-z]'))) {
                                                                        small = true;
                                                                      } else {
                                                                        small = false;
                                                                      }
                                                                      if (v.contains(RegExp(r'[0-9]'))) {
                                                                        number = true;
                                                                      } else {
                                                                        number = false;
                                                                      }
                                                                      if (v.contains(RegExp(r'(?=.*?[!@#\$&*~.])'))) {
                                                                        symbol = true;
                                                                      } else {
                                                                        symbol = false;
                                                                      }
                                                                      _setState(() => newPassword1 = v);
                                                                    },
                                                                  ),
                                                                  SizedBox(height: 10),
                                                                  CIA_TextFormField(
                                                                    label: "Repeat New Password",
                                                                    controller: TextEditingController(text: newPassword2),
                                                                    isObscure: true,
                                                                    errorFunction: (value) {
                                                                      return value != newPassword1;
                                                                    },
                                                                    onChange: (v) => _setState(() => newPassword2 = v),
                                                                  ),
                                                                  SizedBox(height: 10),
                                                                  Text(
                                                                    newPassword1.isEmpty
                                                                        ? "Password can't be empty"
                                                                        : newPassword2 == newPassword1
                                                                            ? "Passwords match"
                                                                            : "Passwords don't match",
                                                                    style: TextStyle(
                                                                        color:
                                                                            newPassword2 == newPassword1 && newPassword1.isNotEmpty ? Colors.green : Colors.red,
                                                                        fontSize: 15),
                                                                  ),
                                                                  Text(
                                                                    "Contains at least 1 Capital Letter",
                                                                    style: TextStyle(
                                                                      color: capital ? Colors.green : Colors.red,
                                                                      fontSize: 15,
                                                                    ),
                                                                    textAlign: TextAlign.start,
                                                                  ),
                                                                  Text(
                                                                    "Contains at least 1 Small Letter",
                                                                    style: TextStyle(color: small ? Colors.green : Colors.red, fontSize: 15),
                                                                  ),
                                                                  Text(
                                                                    "Contains at least 1 Number",
                                                                    style: TextStyle(color: number ? Colors.green : Colors.red, fontSize: 15),
                                                                  ),
                                                                  Text(
                                                                    "Contains at least 1 Symbol",
                                                                    style: TextStyle(color: symbol ? Colors.green : Colors.red, fontSize: 15),
                                                                  ),
                                                                  BlocBuilder<UsersBloc, UsersBloc_States>(
                                                                    buildWhen: (previous, current) => current is UsersBloc_ResettingPasswordErrorState,
                                                                    builder: (context, state) {
                                                                      String error = "";
                                                                      if (state is UsersBloc_ResettingPasswordErrorState) error = state.message;
                                                                      return Text(
                                                                        error != "" ? "Error: $error" : "",
                                                                        style: TextStyle(color: Colors.red, fontSize: 15),
                                                                      );
                                                                    },
                                                                  ),
                                                                  SizedBox(height: 20),
                                                                ],
                                                              );
                                                            }));
                                                      });
                                                } else {
                                                  return Container();
                                                }
                                              }(),
                                              SizedBox(width: 10),


                                              CIA_SecondaryButton(
                                                  label: "Sessions Duration",
                                                  onTab: () async {
                                                    DateTime? from;
                                                    DateTime? to;
                                                    VisitDataSource dataSource = VisitDataSource(sessions: true,context: context, bloc: BlocProvider.of<PatientVisitsBloc>(context));
                                                    bloc.add(UsersBloc_GetSessionsDurationEvent(
                                                        params: GetSessionsDurationParams(
                                                      id: widget.userId,
                                                      from: from,
                                                      to: to,
                                                    )));
                                                    CIA_ShowPopUp(
                                                        width: 1000,
                                                        height: 900,
                                                        context: context,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Expanded(
                                                                  child: CIA_DateTimeTextFormField(
                                                                    label: "From",
                                                                    controller:
                                                                        TextEditingController(text: from == null ? "" : DateFormat("dd-MM-yyyy").format(from!)),
                                                                    onChange: (v) {
                                                                      from = v;
                                                                      bloc.add(UsersBloc_GetSessionsDurationEvent(
                                                                          params: GetSessionsDurationParams(
                                                                        id: widget.userId,
                                                                        from: from,
                                                                        to: to,
                                                                      )));
                                                                    },
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed: () {
                                                                      from = null;

                                                                      bloc.add(UsersBloc_GetSessionsDurationEvent(
                                                                          params: GetSessionsDurationParams(
                                                                        id: widget.userId,
                                                                        from: from,
                                                                        to: to,
                                                                      )));
                                                                    },
                                                                    icon: Icon(Icons.remove)),
                                                                SizedBox(width: 10),
                                                                Expanded(
                                                                  child: CIA_DateTimeTextFormField(
                                                                    label: "To",
                                                                    controller:
                                                                        TextEditingController(text: to == null ? "" : DateFormat("dd-MM-yyyy").format(to!)),
                                                                    onChange: (v) {
                                                                      to = v;
                                                                      bloc.add(UsersBloc_GetSessionsDurationEvent(
                                                                          params: GetSessionsDurationParams(
                                                                        id: widget.userId,
                                                                        from: from,
                                                                        to: to,
                                                                      )));
                                                                    },
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed: () {
                                                                      to = null;
                                                                      bloc.add(UsersBloc_GetSessionsDurationEvent(
                                                                          params: GetSessionsDurationParams(
                                                                        id: widget.userId,
                                                                        from: from,
                                                                        to: to,
                                                                      )));
                                                                    },
                                                                    icon: Icon(Icons.remove)),
                                                              ],
                                                            ),
                                                            SizedBox(height: 10),
                                                            SizedBox(height: 10),
                                                            Expanded(
                                                              child: BlocConsumer<UsersBloc, UsersBloc_States>(
                                                                listener: (context, state) {
                                                                  if (state is UsersBloc_LoadedSessionsSuccessfullyState) {
                                                                    dataSource.updateData(newData: state.sessions);
                                                                  }
                                                                },
                                                                buildWhen: (previous, current) =>
                                                                    current is UsersBloc_LoadingSessionsState ||
                                                                    current is UsersBloc_LoadingSessionsErrorState ||
                                                                    current is UsersBloc_LoadedSessionsSuccessfullyState,
                                                                builder: (context, state) {
                                                                  if (state is UsersBloc_LoadingSessionsState) {
                                                                    return LoadingWidget();
                                                                  } else if (state is UsersBloc_LoadingSessionsErrorState)
                                                                    return BigErrorPageWidget(message: state.message);
                                                                  else if (state is UsersBloc_LoadedSessionsSuccessfullyState) {
                                                                    Duration duration = Duration(seconds: 0);

                                                                    state.sessions.forEach((element) {
                                                                      if (element.duration != null) {
                                                                        var du = element.duration!.split(":");
                                                                        duration += Duration(
                                                                            hours: int.parse(du[0]), minutes: int.parse(du[1]), seconds: int.parse(du[2]));
                                                                      }
                                                                    });
                                                                    return Column(
                                                                      children: [
                                                                        Container(
                                                                            width: double.infinity,
                                                                            child: Center(child: FormTextKeyWidget(text: "Duration: $duration"))),
                                                                        Expanded(
                                                                          child: TableWidget(
                                                                            dataSource: dataSource,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }
                                                                  return LoadingWidget();
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                                  })
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Visibility(
                                            visible: siteController.getRole()=="admin",
                                            child: SizedBox(
                                              width: 300,
                                              child: HorizontalRadioButtons(
                                                names: ["Admin", "Instructor", "Assistant"],
                                                groupValue: user.role == UserRoles.Admin.name.toLowerCase()
                                                    ? "Admin"
                                                    : user.role == UserRoles.Assistant.name.toLowerCase()
                                                    ? "Assistant"
                                                    : user.role == UserRoles.Instructor.name.toLowerCase()
                                                    ? "Instructor"
                                                    : user.role == UserRoles.Secretary.name.toLowerCase()
                                                    ? "Secretary"
                                                    : "",
                                                onChange: (value) async {

                                                  bloc.add(UsersBloc_ChangeRoleEvent(params: ChangeRoleParams(role: value.toLowerCase(), id: user.idInt!)));
                                                  //await loadData();
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(child: FormTextKeyWidget(text: "ID")),
                                              Expanded(child: FormTextValueWidget(text: user.idInt.toString() == null ? "" : user.idInt.toString()))
                                            ],
                                          ),
                                          edit
                                              ? CIA_TextFormField(
                                                  label: "Name",
                                                  onChange: (v) => user.name = v,
                                                  controller: TextEditingController(text: user.name == null ? "" : user.name),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "Name")),
                                                    Expanded(child: FormTextValueWidget(text: user.name == null ? "" : user.name))
                                                  ],
                                                ),
                                          Row(
                                            children: [
                                              Expanded(child: FormTextKeyWidget(text: "Date of birth")),
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                      text: user.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(user.dateOfBirth!)))
                                            ],
                                          ),
                                          edit
                                              ? CIA_TextFormField(
                                                  label: user.role=="candidate"?"Personal Email": "Email",
                                                  onChange: (v) => user.email = v,
                                                  controller: TextEditingController(text: user.email == null ? "" : user.email),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text:  user.role=="candidate"?"Personal Email": "Email")),
                                                    Expanded(child: FormTextValueWidget(text: user.email == null ? "" : user.email))
                                                  ],
                                                ),
                                          Row(
                                            children: [
                                              Expanded(child: FormTextKeyWidget(text: "Date of birth")),
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                      text: user.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(user.dateOfBirth!)))
                                            ],
                                          ),
                                          edit
                                              ? CIA_TextFormField(
                                                  label: "Phone",
                                                  isNumber: true,
                                                  onChange: (v) => user.phoneNumber = v,
                                                  controller: TextEditingController(text: user.phoneNumber == null ? "" : user.phoneNumber),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "Phone")),
                                                    Expanded(child: FormTextValueWidget(text: user.phoneNumber == null ? "" : user.phoneNumber))
                                                  ],
                                                ),
                                          Row(
                                            children: [
                                              Expanded(child: FormTextKeyWidget(text: "Gender")),
                                              Expanded(child: FormTextValueWidget(text: user.gender == null ? "" : user.gender))
                                            ],
                                          ),
                                          edit
                                              ? CIA_TextFormField(
                                                  label: "Graduated From",
                                                  onChange: (v) => user.graduatedFrom = v,
                                                  controller: TextEditingController(text: user.graduatedFrom == null ? "" : user.graduatedFrom),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "Graduated From")),
                                                    Expanded(child: FormTextValueWidget(text: user?.graduatedFrom == null ? "" : user?.graduatedFrom))
                                                  ],
                                                ),
                                          edit
                                              ? CIA_TextFormField(
                                                  label: "Class Year",
                                                  onChange: (v) => user.classYear = v,
                                                  controller: TextEditingController(text: user.classYear == null ? "" : user.classYear),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "Class Year")),
                                                    Expanded(child: FormTextValueWidget(text: user.classYear == null ? "" : user.classYear))
                                                  ],
                                                ),
                                          edit
                                              ? CIA_TextFormField(
                                                  label: "Speciality",
                                                  onChange: (v) => user.speciality = v,
                                                  controller: TextEditingController(text: user.speciality == null ? "" : user.speciality),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "Speciality")),
                                                    Expanded(child: FormTextValueWidget(text: user?.speciality == null ? "" : user.speciality))
                                                  ],
                                                ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FormTextKeyWidget(
                                                text: "Registration: " + (user.registeredBy == null ? "" : user.registeredBy!.name as String),
                                                secondaryInfo: true,
                                              )),
                                              Expanded(
                                                  child: FormTextValueWidget(
                                                text: user?.registerationDate == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(user.registerationDate!),
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
                                          BlocBuilder<ImageBloc, ImageBloc_State>(
                                            bloc: imageBloc,
                                            buildWhen: (previous, current) =>
                                                current is ImageDownloadingState ||
                                                current is ImageLoadedState ||
                                                current is ImageLoadingErrorState ||
                                                current is ImageUploadErrorState ||
                                                current is ImageUploadingState,
                                            builder: (context, state) {
                                              if (state is ImageUploadErrorState) {
                                                if (user.profileImage != null) {
                                                  return Image(
                                                    image: MemoryImage(user.profileImage!),
                                                    height: imageHeight,
                                                    width: imageWidth,
                                                  );
                                                }
                                              } else if (state is ImageDownloadingState || state is ImageUploadingState)
                                                return SizedBox(
                                                  height: imageHeight,
                                                  width: imageWidth,
                                                  child: LoadingWidget(),
                                                );
                                              else if (state is ImageLoadedState) {
                                                user.profileImage = state.image;
                                                return Image(
                                                  image: MemoryImage(state.image),
                                                  height: imageHeight,
                                                  width: imageWidth,
                                                );
                                              }
                                              return Image(
                                                image: AssetImage("assets/ProfileImage.png"),
                                                height: imageHeight,
                                                width: imageWidth,
                                              );
                                            },
                                          ),
                                          Visibility(visible: edit, child: CIA_SecondaryButton(label: "Upload Image", onTab: () => imageBloc.selectImage())),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: edit
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: SizedBox()),
                                          Flexible(
                                            child: CIA_SecondaryButton(label: "Cancel", onTab: () => setState(() => edit = false)),
                                          ),
                                          Flexible(
                                            child: CIA_PrimaryButton(
                                                label: "Save",
                                                isLong: true,
                                                onTab: () {
                                                  bloc.add(UsersBloc_UpdateUserInfoEvent(
                                                    id: user!.idInt!,
                                                    userData: user!,
                                                  ));
                                                  if (user.profileImage != null) {
                                                    imageBloc.uploadImageEvent(UploadImageParams(
                                                      id: user.idInt!,
                                                      type: EnumImageType.UserProfile,
                                                      data: user.profileImage!,
                                                    ));
                                                  }
                                                }),
                                          ),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: CIA_SecondaryButton(
                                        onTab: () => bloc.add(UsersBloc_SwitchEditViewEvent(
                                          edit: true,
                                          user: user,
                                        )),
                                        label: "Edit Info",
                                      ),
                                    ),
                            )
                          ],
                        ),
                      )),
                ],
              );
            }
            return Container();
          },
        ));
  }
}
/*
class ViewCandidateData extends StatefulWidget {
  ViewCandidateData({Key? key, required this.userId}) : super(key: key);
  int userId;
  static String routeName = "CandidateDetails";
   static String routeNameClinic = "ClinicCandidateDetails";
  static String routePath = "Candidate/:id/CandidateDetails";

  @override
  State<ViewCandidateData> createState() => _ViewCandidateDataState();
}

class _ViewCandidateDataState extends State<ViewCandidateData> {
  bool edit = false;
  late ApplicationUserModel user;
  FocusNode next = FocusNode();
  CandidateDetailsDataSource dataSource = new CandidateDetailsDataSource();
  String? from;
  String? to;

  @override
  Widget build(BuildContext context) {
    return CIA_FutureBuilder(
      loadFunction: UserAPI.GetUserData(widget.userId),
      onSuccess: (data) {
        user = data as ApplicationUserModel;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                    child: CIA_DateTimeTextFormField(
                  label: "From",
                  controller: TextEditingController(),
                  onChange: (v) {
                    from = v;
                    dataSource.loadData(widget.userId, (v) {
                      _getx.totalImplants.value = v;
                    }, from: from, to: to);
                  },
                )),
                SizedBox(width: 10),
                Expanded(
                    child: CIA_DateTimeTextFormField(
                  label: "to",
                  controller: TextEditingController(),
                  onChange: (v) {
                    to = v;
                    dataSource.loadData(widget.userId, (v) {
                      _getx.totalImplants.value = v;
                    }, from: from, to: to);
                  },
                )),
                Expanded(child: SizedBox()),
              ],
            ),
            Expanded(
              child: CIA_Table(
                columnNames: dataSource.columns,
                dataSource: dataSource,
                allowSorting: true,
                loadFunction: () {
                  return dataSource.loadData(widget.userId, (v) {
                    _getx.totalImplants.value = v;
                  });
                },
                onCellClick: (index) {
                  if (index != 0)
                    context.goNamed(SurgicalTreatmentPage.routeName,
                        pathParameters: {'id': dataSource.effectiveRows.elementAt(index - 1).getCells().first.value.toString()});
                },
              ),
            ),
            Obx(() => Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Total Implants: ${_getx.totalImplants.value.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )),
          ],
        );
      },
    );
  }
}
*/
