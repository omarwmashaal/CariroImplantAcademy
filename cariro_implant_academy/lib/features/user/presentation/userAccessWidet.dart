import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../Widgets/CIA_PopUp.dart';
import '../../../Widgets/FormTextWidget.dart';
import '../../../Widgets/SnackBar.dart';
import '../../../core/constants/enums/enums.dart';
import 'bloc/usersBloc_Events.dart';

class UserAccessWidget extends StatelessWidget {
  UserAccessWidget({Key? key, required this.user}) : super(key: key);
  UserEntity user;

  @override
  Widget build(BuildContext context) {
    UsersBloc usersBloc = BlocProvider.of<UsersBloc>(context);
    return !siteController.getRole()!.contains("admin")
        ? Container()
        : IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              var roles = user.roles;
              var accesswesbites = user.accessWebsites;
              CIA_ShowPopUp(
                width: double.maxFinite,
                  context: context,
                  onSave: () {
                    user.accessWebsites = accesswesbites;
                    user.roles = roles;
                    usersBloc.add(UsersBloc_UpdateUserInfoEvent(id: user.idInt!, userData: user));
                  },
                  child: Column(
                    children: [
                      FormTextKeyWidget(text: "Website Access"),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CIA_CheckBoxWidget(
                            text: "CIA",
                            onChange: (value) {
                              if (value == false && (accesswesbites?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at access to at least one website!");
                                return;
                              }
                              accesswesbites!.removeWhere((element) => element == Website.CIA);
                              if (value) accesswesbites!.add(Website.CIA);
                            },
                            value: accesswesbites?.contains(Website.CIA) ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "LAB",
                            onChange: (value) {
                              if (value == false && (accesswesbites?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at access to at least one website!");
                                return;
                              }
                              accesswesbites!.removeWhere((element) => element == Website.Lab);
                              if (value) accesswesbites!.add(Website.Lab);
                            },
                            value: accesswesbites?.contains(Website.Lab) ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "Clinic",
                            onChange: (value) {
                              if (value == false && (accesswesbites?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at access to at least one website!");
                                return;
                              }
                              accesswesbites!.removeWhere((element) => element == Website.Clinic);
                              if (value) accesswesbites!.add(Website.Clinic);
                            },
                            value: accesswesbites?.contains(Website.Clinic) ?? false,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      FormTextKeyWidget(text: "Roles"),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CIA_CheckBoxWidget(
                            text: "Admin",
                            onChange: (value) {
                              if (value == false && (roles?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at least one role!");
                                return;
                              }
                              roles!.removeWhere((element) => element == "admin");
                              if (value) roles!.add("admin");
                            },
                            value: roles?.contains("admin") ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "Instructor",
                            onChange: (value) {
                              if (value == false && (roles?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at least one role!");
                                return;
                              }
                              roles!.removeWhere((element) => element == "instructor");
                              if (value) roles!.add("instructor");
                            },
                            value: roles?.contains("instructor") ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "Assistant",
                            onChange: (value) {
                              if (value == false && (roles?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at least one role!");
                                return;
                              }
                              roles!.removeWhere((element) => element == "assistant");
                              if (value) roles!.add("assistant");
                            },
                            value: roles?.contains("assistant") ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "Secretary",
                            onChange: (value) {
                              if (value == false && (roles?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at least one role!");
                                return;
                              }
                              roles!.removeWhere((element) => element == "secretary");
                              if (value) roles!.add("secretary");
                            },
                            value: roles?.contains("secretary") ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "Lab Moderator",
                            onChange: (value) {
                              if (value == false && (roles?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at least one role!");
                                return;
                              }
                              roles!.removeWhere((element) => element == "labmoderator");
                              if (value) roles!.add("labmoderator");
                            },
                            value: roles?.contains("labmoderator") ?? false,
                          ),
                          CIA_CheckBoxWidget(
                            text: "Technician",
                            onChange: (value) {
                              if (value == false && (roles?.length ?? 0) < 2) {
                                ShowSnackBar(context, isSuccess: false, message: "User must have at least one role!");
                                return;
                              }
                              roles!.removeWhere((element) => element == "technician");
                              if (value) roles!.add("technician");
                            },
                            value: roles?.contains("technician") ?? false,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ));
            },
          );
  }
}
