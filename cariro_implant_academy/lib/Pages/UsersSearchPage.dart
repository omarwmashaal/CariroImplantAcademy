import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';
import '../Models/Enum.dart';
import '../Widgets/CIA_TextField.dart';

class UserSearchPage extends StatefulWidget {
  UserSearchPage({Key? key, required this.dataSource}) : super(key: key);
  ApplicationUserDataSource dataSource;

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  String search = "";
  int selectedUserId = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
       var pages = [Column(
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
               else if (widget.dataSource.type == UserRoles.Admin) return "Admins Data";
               else if (widget.dataSource.type == UserRoles.Technician) return "Technicians Data";
               else if (widget.dataSource.type == UserRoles.OutSource) return "Customers Data";
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
           SizedBox(height: 10),
           Expanded(
             child: CIA_Table(
               columnNames: widget.dataSource.columns,
               dataSource: widget.dataSource,
               loadFunction: widget.dataSource.loadData,
               onCellClick: (index)
               {
                 var d = widget.dataSource.models[index-1];
                 selectedUserId = d.idInt??0;
                 internalPagesController.jumpToPage(1);
               },
             ),
           ),
         ],
       ),
         ViewUserData(userId: selectedUserId)];
       return pages[index];
      },
      itemCount: 2,
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,

    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget();
  }
}
