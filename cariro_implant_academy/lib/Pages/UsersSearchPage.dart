import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Widgets/Title.dart';
import '../core/constants/enums/enums.dart';
import '../Widgets/CIA_TextField.dart';
import '../features/user/domain/entities/enum.dart';
import '../features/user/presentation/pages/viewUserProfile.dart';

class UserSearchsPage extends StatefulWidget {
  UserSearchsPage({Key? key, required this.dataSource, this.type}) : super(key: key);
  ApplicationUserDataSource dataSource;
  static String assistantsRouteName = "Users/Assistants";
   static String assistantsRouteNameClinic = "ClinicUsers/Assistants";
  static String candidatesRouteName = "Candidates";
   static String candidatesRouteNameClinic = "ClinicCandidates";
  static String instructorsRouteName = "Users/Instructors";
   static String instructorsRouteNameClinic = "ClinicUsers/Instructors";
  static String techniciansRouteName = "Users/Technicians";
   static String techniciansRouteNameClinic = "ClinicUsers/Technicians";
  static String outSourceRouteName = "Users/Customers";
   static String outSourceRouteNameClinic = "ClinicUsers/Customers";
  static String labModeratorsRouteName = "Users/LabModerators";
   static String labModeratorsRouteNameClinic = "ClinicUsers/LabModerators";

  String? type;

  @override
  State<UserSearchsPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchsPage> {
  String search = "";
  int batchId = 0;

  int selectedUserId = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          title: () {
            if (widget.dataSource.type == UserRoles.Admin)
              return "Admins Data";
            else if (widget.dataSource.type == UserRoles.Secretary)
              return "Secretaries Data";
            else if (widget.dataSource.type == UserRoles.Instructor)
              return "Instructors Data";
            else if (widget.dataSource.type == UserRoles.Assistant)
              return "Assistants Data";
            else if (widget.dataSource.type == UserRoles.Candidate)
              return "Candidates Data";
            else if (widget.dataSource.type == UserRoles.Admin)
              return "Admins Data";
            else if (widget.dataSource.type == UserRoles.Technician)
              return "Technicians Data";
            else if (widget.dataSource.type == UserRoles.OutSource) return "Customers Data";
            else if (widget.dataSource.type == UserRoles.LabModerator) return "Moderators Data";
            return "";
          }(),
        ),
        CIA_TextField(
          label: "Search",
          icon: Icons.search,
          onChange: (value) {
            search = value;
            widget.dataSource.loadData(search: search == "" ? null : search);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: () {
            List<Widget> r = [];
            if (widget.dataSource.type == UserRoles.Candidate) {
              r.add(
                Container(
                  width: 400,
                  child: CIA_DropDownSearch(
                    label: "Batch",
                    asyncItems: () async {
                      var res = await LoadinAPI.LoadCandidatesBatches();
                      if (res.statusCode == 200) (res.result as List<DropDownDTO>).insert(0, DropDownDTO(name: "None"));
                      return res;
                    },
                    onSelect: (value) {
                      widget.dataSource.loadData(search: search == "" ? null : search, batch: value.id);
                    },
                  ),
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
          child: CIA_Table(
            columnNames: widget.dataSource.columns,
            dataSource: widget.dataSource,
            loadFunction: widget.dataSource.loadData,
            onCellClick: (index) {
              var d = widget.dataSource.models[index - 1];
              selectedUserId = d.idInt ?? 0;
              context.goNamed(widget.dataSource.type==UserRoles.Candidate?ViewUserProfilePage.candidateRouteName:ViewUserProfilePage.getRouteName(),pathParameters: {"id":selectedUserId.toString()});

            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {

   // siteController.setAppBarWidget(context: context);
  }
}
