import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Assistant_ViewAssistantPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Title.dart';

class AssistantsSearchPage extends StatefulWidget {
  const AssistantsSearchPage({Key? key}) : super(key: key);

  @override
  State<AssistantsSearchPage> createState() => _AssistantsSearchPageState();
}

class _AssistantsSearchPageState extends State<AssistantsSearchPage> {
  ApplicationUserDataSource dataSource = ApplicationUserDataSource(type: UserDataSourceType.Assistant);
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        Column(
          children: [
            TitleWidget(
              title: "Assistants Data",
            ),
            SearchLayout(
              radioButtons: [
                "Name",
                "Phone",
                "ID",
                "Instructor",
                "Assistant",
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
        ViewAssistantPage()
      ],
    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget();
  }
}
