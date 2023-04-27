import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Instructor_ViewInstructorPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';

class InstructorsSearchPage extends StatefulWidget {
  const InstructorsSearchPage({Key? key}) : super(key: key);

  @override
  State<InstructorsSearchPage> createState() => _InstructorsSearchPageState();
}

class _InstructorsSearchPageState extends State<InstructorsSearchPage> {
  ApplicationUserDataSource dataSource = ApplicationUserDataSource(type: UserDataSourceType.Instructor);
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        Column(
          children: [
            TitleWidget(
              title: "Instructors Data",
            ),
            SearchLayout(
              radioButtons: [
                "Name",
                "Phone",
                "ID",
                "Instructor",
                "Instructor",
                "Candidate",
                "Operation",
              ],
              loadMoreFuntcion: dataSource.loadData,
              dataSource: dataSource,
              columnNames: dataSource.columns,
              onCellTab: (value) {
                internalPagesController
                    .setPassedObject(dataSource.models[value - 1]);
                internalPagesController.jumpToPage(1);
              },
            ),
          ],
        ),
        ViewInstructorPage()
      ],
    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget();
  }
}
