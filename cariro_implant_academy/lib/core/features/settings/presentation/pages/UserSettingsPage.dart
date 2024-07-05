import 'dart:typed_data';

import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocEvents.dart';
import 'package:cariro_implant_academy/core/features/authentication/presentation/bloc/authentication_blocStates.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../Constants/Controllers.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../features/user/domain/entities/enum.dart';
import '../../../../../presentation/bloc/imagesBloc.dart';
import '../../../../../presentation/bloc/imagesBloc_States.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../injection_contianer.dart';

class UsersSettingsPage extends StatefulWidget {
  const UsersSettingsPage({Key? key}) : super(key: key);
  static String routePath = "UsersSettings";

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Lab:
        return "LabUsersSettings";
      case Website.Clinic:
        return "ClinicUsersSettings";
      default:
        return "UsersSettings";
    }
  }

  @override
  State<UsersSettingsPage> createState() => _UsersSettingsPageState();
}

class _UsersSettingsPageState extends State<UsersSettingsPage> with TickerProviderStateMixin {
  late TabController tabController;
  late AuthenticationBloc authenticationBloc;
  late UsersBloc usersBloc;
  late UsersDataGridSource dataSource;
  late UserRoles type;

  Website chosenWebsite = Website.CIA;

  @override
  void initState() {
    type = UserRoles.Admin;
    authenticationBloc = context.read<AuthenticationBloc>(); // BlocProvider.of<AuthenticationBloc>(context);
    usersBloc = BlocProvider.of<UsersBloc>(context);
    dataSource = UsersDataGridSource(
      context: context,
      type: type,
      usersBloc: usersBloc,
    );
    reloadUsers();
    tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersBloc_States>(
      listener: (context, state) {
        if (state is UsersBloc_UpdatingUserInfoState || state is UsersBloc_RemovingUserState)
          CustomLoader.show(context);
        else {
          CustomLoader.hide();
          if (state is UsersBloc_UpdatingUserInfoErrorState) {
            ShowSnackBar(context, isSuccess: false, message: state.message);
            reloadUsers();
          } else if (state is UsersBloc_UpdatedUserInfoSuccessfullyState || state is UsersBloc_RemovedUserSuccessfullyState) {
            ShowSnackBar(context, isSuccess: true);
            reloadUsers();
          } else if (state is UsersBloc_RemovingUserErrorState) ShowSnackBar(context, isSuccess: false, message: state.message);
        }
      },
      child: Column(
        children: [
          CIA_SecondaryButton(
              label: "Add new",
              onTab: () {
                var role = "";
                if (tabController.index == 0)
                  role = "admin";
                else if (tabController.index == 1)
                  role = "instructor";
                else if (tabController.index == 2)
                  role = "assistant";
                else if (tabController.index == 3)
                  role = "candidate";
                else if (tabController.index == 4)
                  role = "secretary";
                else if (tabController.index == 5)
                  role = "labmoderator";
                else if (tabController.index == 6)
                  role = "technician";
                else if (tabController.index == 7) role = "labdesigner";
                UserEntity newUser = UserEntity(roles: [role], gender: "Male", accessWebsites: [chosenWebsite]);
                bool newBatch = false;
                Uint8List? userProfilePicture;
                ImageBloc imageBloc = context.read<ImageBloc>();
                CIA_ShowPopUp(
                  title: "Add new $role",
                  height: 600,
                  width: role == "candidate" ? double.maxFinite : null,
                  context: context,
                  child: StatefulBuilder(builder: (context, setState) {
                    String error = "";
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CIA_TextFormField(
                                          label: "Name",
                                          controller: TextEditingController(text: newUser.name ?? ""),
                                          onChange: (value) => newUser.name = value,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Visibility(
                                          visible: tabController.index != 1,
                                          child: CIA_TextFormField(
                                            label: tabController.index == 3 ? "Personal Email" : "Email",
                                            controller: TextEditingController(text: newUser.email ?? ""),
                                            onChange: (value) {
                                              newUser.email = value;
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: role == "candidate",
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_TextFormField(
                                            label: "Instagram Link",
                                            controller: TextEditingController(text: newUser.instagramLink ?? ""),
                                            onChange: (value) {
                                              newUser.instagramLink = value;
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: role == "candidate",
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_TextFormField(
                                            label: "Facebook Link",
                                            controller: TextEditingController(text: newUser.facebookLink ?? ""),
                                            onChange: (value) {
                                              newUser.facebookLink = value;
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: tabController.index != 3,
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FormTextValueWidget(
                                              text: r"Default passowrd: Pa$$word1",
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: HorizontalRadioButtons(
                                            names: ["Male", "Female"],
                                            groupValue: "Male",
                                            onChange: (v) {
                                              newUser.gender = v;
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CIA_TextFormField(
                                          label: "Phone Number",
                                          isNumber: true,
                                          controller: TextEditingController(text: newUser.phoneNumber ?? ""),
                                          onChange: (value) => newUser.phoneNumber = value,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CIA_TextFormField(
                                          onTap: () {
                                            CIA_PopupDialog_DateOnlyPicker(context, "Birthday", (v) {
                                              setState(() {
                                                newUser.dateOfBirth = v;
                                              });
                                            });
                                          },
                                          label: "Date of Birth",
                                          controller: TextEditingController(
                                            text: newUser.dateOfBirth == null ? "" : DateFormat("dd-MM-yyyy").format(newUser.dateOfBirth!),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: role != "secretary",
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_TextFormField(
                                            label: "Graduated From",
                                            controller: TextEditingController(text: newUser.graduatedFrom ?? ""),
                                            onChange: (value) => newUser.graduatedFrom = value,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: role != "secretary",
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_TextFormField(
                                            label: "Class Year",
                                            controller: TextEditingController(text: newUser.classYear ?? ""),
                                            onChange: (value) => newUser.classYear = value,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: role != "secretary",
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_TextFormField(
                                            label: "Speciality",
                                            controller: TextEditingController(text: newUser.speciality ?? ""),
                                            onChange: (value) => newUser.speciality = value,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: tabController.index == 3,
                                        child: Column(
                                          children: [
                                            CIA_MultiSelectChipWidget(
                                              onChange: (item, isSelected) {
                                                if (isSelected)
                                                  newUser.batchId = null;
                                                else
                                                  newUser.batch = null;
                                                setState(() => newBatch = isSelected);
                                              },
                                              labels: [
                                                CIA_MultiSelectChipWidgeModel(
                                                  label: "New Batch",
                                                ),
                                              ],
                                            ),
                                            newBatch
                                                ? Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: CIA_TextFormField(
                                                      label: "New Batch Name",
                                                      controller: TextEditingController(text: newUser.batch == null ? "" : newUser.batch!.name ?? ""),
                                                      onChange: (value) {
                                                        newUser.batch = BasicNameIdObjectEntity(name: value);
                                                        newUser.batchId = null;
                                                      },
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: CIA_DropDownSearchBasicIdName(
                                                      onClear: () {
                                                        newUser.batchId = null;
                                                        newUser.batch = null;
                                                      },
                                                      asyncUseCase: sl<LoadCandidateBatchesUseCase>(),
                                                      label: "Batch",
                                                      onSelect: (value) {
                                                        newUser.batchId = value.id;
                                                        newUser.batch = null;
                                                      },
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              BlocConsumer<AuthenticationBloc, Authentication_blocState>(
                                listener: (context, state) async {
                                  if (state is RegisteredUserSuccessfullyState) {
                                    if (newUser.profileImage != null) {
                                      var result = await imageBloc.uploadImageEvent(UploadImageParams(
                                        id: state.user.idInt!,
                                        type: EnumImageType.UserProfile,
                                        data: newUser.profileImage!,
                                      ));
                                      if (result == false)
                                        ShowSnackBar(context, isSuccess: false, message: "User Created But failed to upload image!");
                                    }
                                    dialogHelper.dismissSingle(context);
                                    reloadUsers();
                                  }
                                },
                                builder: (context, state) {
                                  if (state is RegisteringUserErrorState)
                                    error = state.message;
                                  else if (state is RegisteringUserState)
                                    return LoadingWidget();
                                  else
                                    error = "";
                                  return Text(
                                    key: GlobalKey(),
                                    error,
                                    style: TextStyle(color: Colors.red),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: role == "candidate",
                          child: Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BlocConsumer<ImageBloc, ImageBloc_State>(
                                bloc: imageBloc,
                                listener: (context, state) {
                                  if (state is ImageSelectingError) ShowSnackBar(context, isSuccess: false, message: state.message);
                                },
                                builder: (context, state) {
                                  if (state is ImageLoadingState || state is ImageUploadingState) {
                                    return LoadingWidget();
                                  } else if (state is ImageLoadedState) {
                                    newUser.profileImage = state.image;
                                    return Image(
                                      image: MemoryImage(state.image),
                                      height: 200,
                                      width: 200,
                                    );
                                  } else
                                    return Image(
                                      image: AssetImage("assets/ProfileImage.png"),
                                      height: 200,
                                      width: 200,
                                    );
                                },
                              ),
                              SizedBox(height: 10),
                              CIA_SecondaryButton(
                                  label: "Upload Image",
                                  onTab: () async {
                                    imageBloc.selectImage();
                                  }),
                            ],
                          )),
                        ),
                      ],
                    );
                  }),
                  onSave: () {
                    authenticationBloc.registerUserEvent(newUser);
                    return false;
                  },
                );
              }),
          SizedBox(height: 10),
          CIA_MultiSelectChipWidget(
            singleSelect: true,
            onChange: (item, isSelected) {
              chosenWebsite = Website.values.firstWhere((element) => element.name == item);
              reloadUsers();
            },
            labels: Website.values
                .map((e) => CIA_MultiSelectChipWidgeModel(
                      label: e.name,
                      isSelected: chosenWebsite == e,
                    ))
                .toList(),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: TabBar(
                    onTap: (value) {
                      type = UserRoles.values[value];
                      dataSource = UsersDataGridSource(context: context, type: type, usersBloc: usersBloc);

                      reloadUsers();

                      //setState(() {});
                    },
                    controller: tabController,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: "Admins",
                      ),
                      Tab(
                        text: "Instructor",
                      ),
                      Tab(
                        text: "Assistants",
                      ),
                      Tab(
                        text: "Candidates",
                      ),
                      Tab(
                        text: "Secretaries",
                      ),
                      Tab(
                        text: "Lab Moderators",
                      ),
                      Tab(
                        text: "Lab Tech",
                      ),
                      Tab(
                        text: "Lab Designer",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _buildWidget(),
                      _buildWidget(),
                      _buildWidget(),
                      _buildWidget(),
                      _buildWidget(),
                      _buildWidget(),
                      _buildWidget(),
                      _buildWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /* Row(
            children: [
              Expanded(child: SizedBox()),


          ),*/
        ],
      ),
    );
  }

  _buildWidget() {
    return BlocConsumer<UsersBloc, UsersBloc_States>(listener: (context, state) {
      if (state is UsersBloc_LoadedMultiUsersSuccessfullyState) dataSource.updateData(newData: state.usersData);
      if (state is UsersBloc_ResettingPasswordForUserState || state is UsersBloc_ChangingRoleState)
        CustomLoader.show(context);
      else
        CustomLoader.hide();

      if (state is UsersBloc_ResettingPasswordForUserErrorState)
        ShowSnackBar(context, isSuccess: false, message: state.message);
      else if (state is UsersBloc_ChangingRoleErrorState)
        ShowSnackBar(context, isSuccess: false, message: state.message);
      else if (state is UsersBloc_ResetPasswordForUserSuccessfullyState)
        ShowSnackBar(context, isSuccess: true);
      else if (state is UsersBloc_ChangedRoleSuccessfullyState) {
        ShowSnackBar(context, isSuccess: true);
        reloadUsers();
      }
    }, builder: (context, state) {
      if (state is UsersBloc_LoadingUserState)
        return LoadingWidget();
      else if (state is UsersBloc_LoadingUserErrorState) return BigErrorPageWidget(message: state.message);
      return TableWidget(
        dataSource: dataSource,
      );
    });
  }

  reloadUsers() {
    usersBloc.add(UsersBloc_SearchUsersByRoleEvent(role: type, accessWebsites: chosenWebsite));
  }
}
