import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadCandidateBatchesUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_States.dart';
import 'package:cariro_implant_academy/features/user/presentation/pages/viewUserProfile.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Pages/CIA_Pages/ViewUserPage.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/injection_contianer.dart';
import '../../domain/entities/enum.dart';

class UserSearchPage extends StatefulWidget {
  UserSearchPage({Key? key, required this.type}) : super(key: key);

  static String routePathAssistants = "Assistants";
  static String routePathCandidates = "Candidates";
  static String routePathInstructors = "Instructors";
  static String routePathTechnicians = "Technicians";
  static String routePathCustomers = "Customers";
  static String routePathLabModerators = "LabModerators";
  static String routePathOutsource = "Outsource";

  static String getRouteNameAssistants({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicAssistants";
      default:
        return "Assistants";
    }
  }

  static String getRouteNameOutsourceModerators({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicOutsource";
      case Website.Lab:
        return "LabOutsource";
      default:
        return "CIAOutsource";
    }
  }

  static String getRouteNameLabModerators({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicLabModerators";
      case Website.Lab:
        return "LabLabModerators";
      default:
        return "CIAModerators";
    }
  }

  static String getRouteNameTechnicians({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicTechnicians";
      case Website.Lab:
        return "LabTechnicians";
      default:
        return "Technicians";
    }
  }

  static String getRouteNameCustomers({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicCustomers";
      case Website.Lab:
        return "LabCustomers";
      default:
        return "Customers";
    }
  }

  static String getRouteNameInstructors({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicInstructors";
      default:
        return "Instructors";
    }
  }

  static String getRouteNameCandidates({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicCandidates";
      default:
        return "Candidates";
    }
  }

  UserRoles type;

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  String search = "";
  int? batchId;
  String? batchName;

  late UsersBloc bloc;
  late UsersDataGridSource usersDataGridSource;

  @override
  void initState() {
    bloc = BlocProvider.of<UsersBloc>(context);
    usersDataGridSource = UsersDataGridSource(context: context, type: widget.type, usersBloc: bloc);
    bloc.add(UsersBloc_SearchUsersByRoleEvent(
      role: widget.type,
      search: search,
      batchId: batchId,
    )); //siteController.setAppBarWidget(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersBloc_States>(
      listener: (context, state) {
        if (state is UsersBloc_LoadedMultiUsersSuccessfullyState) usersDataGridSource.updateData(newData: state.usersData);
        if (state is UsersBloc_LoadingUserState)
          CustomLoader.show(context);
        else {
          CustomLoader.hide();
          if (state is UsersBloc_RefreshedCandidatesDataSuccessfullyState) {
            ShowSnackBar(context, isSuccess: true);
            bloc.add(UsersBloc_SearchUsersByRoleEvent(
              role: widget.type,
              search: search,
              batchId: batchId,
            ));
          } else if (state is UsersBloc_RefreshingCandidateDataErrorState) ShowSnackBar(context, isSuccess: false, message: state.message);
        }
      },
      buildWhen: (previous, current) => current is UsersBloc_LoadingUserErrorState || current is UsersBloc_LoadedMultiUsersSuccessfullyState,
      builder: (context, state) {
        if (state is UsersBloc_LoadingUserErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is UsersBloc_LoadingUserState)
          return LoadingWidget();
        else if (state is UsersBloc_LoadedMultiUsersSuccessfullyState) {
          return Column(
            children: [
              TitleWidget(
                title: () {
                  if (widget.type == UserRoles.Admin)
                    return "Admins Data";
                  else if (widget.type == UserRoles.Secretary)
                    return "Secretaries Data";
                  else if (widget.type == UserRoles.Instructor)
                    return "Instructors Data";
                  else if (widget.type == UserRoles.Assistant)
                    return "Assistants Data";
                  else if (widget.type == UserRoles.Candidate)
                    return "Candidates Data";
                  else if (widget.type == UserRoles.Admin)
                    return "Admins Data";
                  else if (widget.type == UserRoles.Technician)
                    return "Technicians Data";
                  else if (widget.type == UserRoles.OutSource)
                    return "Customers Data";
                  else if (widget.type == UserRoles.LabModerator) return "Moderators Data";
                  return "";
                }(),
              ),
              CIA_TextField(
                label: "Search",
                icon: Icons.search,
                onChange: (value) {
                  search = value;
                  bloc.add(UsersBloc_SearchUsersByRoleEvent(
                    role: widget.type,
                    search: search,
                    batchId: batchId,
                  ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: () {
                  List<Widget> r = [];
                  if (widget.type == UserRoles.Candidate) {
                    r.add(
                      Row(
                        children: [
                          Container(
                            width: 400,
                            child: CIA_DropDownSearchBasicIdName(
                              onClear: () {
                                batchId = null;
                                batchName = null;
                                bloc.add(UsersBloc_SearchUsersByRoleEvent(
                                  role: widget.type,
                                  search: search,
                                  batchId: batchId,
                                ));
                              },
                              asyncUseCase: sl<LoadCandidateBatchesUseCase>(),
                              label: "Batch",
                              onSelect: (value) {
                                batchId = value.id;
                                batchName = value.name;
                                bloc.add(UsersBloc_SearchUsersByRoleEvent(
                                  role: widget.type,
                                  search: search,
                                  batchId: batchId,
                                ));
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          FormTextKeyWidget(text: "${state.usersData.length.toString()} Candidate${state.usersData.length > 1 ? "s" : ""}"),
                          SizedBox(width: 20),
                          CIA_SecondaryButton(
                              label: "Refresh Candidates Data",
                              onTab: () {
                                bloc.add(UsersBloc_RefreshCandidatesDataEvent(batchId: batchId));
                              }),
                          SizedBox(width: 10),
                          BlocBuilder<UsersBloc, UsersBloc_States>(
                            builder: (context, state) {
                              String status = "";
                              if (state is UsersBloc_RefreshingCandidateDatatate) status = "Refreshing ${batchName ?? "All"} Candidates Data ...";
                              return FormTextValueWidget(
                                text: status,
                              );
                            },
                          )
                        ],
                      ),
                    );
                    r.add(
                      Expanded(
                        child: SizedBox(),
                      ),
                    );
                  }
                  return r;
                }(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TableWidget(
                  dataSource: usersDataGridSource,
                  onCellClick: (index) {
                    context.goNamed(widget.type == UserRoles.Candidate ? ViewUserProfilePage.candidateRouteName : ViewUserProfilePage.getRouteName(),
                        pathParameters: {"id": index.toString()});
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
