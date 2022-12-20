import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/Assistant_ViewAssistantPage.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/AssistantInfo.dart';
import '../../Widgets/Title.dart';

class AssistantsSearchPage extends StatefulWidget {
  const AssistantsSearchPage({Key? key}) : super(key: key);

  @override
  State<AssistantsSearchPage> createState() => _AssistantsSearchPageState();
}

class _AssistantsSearchPageState extends State<AssistantsSearchPage> {
  AssistantDataSource dataSource = AssistantDataSource();
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        Column(
          children: [
            Expanded(child: SizedBox()),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TitleWidget(title: "Assistants Data",),
            )),
            Expanded(
              flex:10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SearchLayout(
                  radioButtons: [
                    "Name",
                    "Phone",
                    "ID",
                    "Instructor",
                    "Assistant",
                    "Candidate",
                    "Operation",
                  ],
                  loadMoreFuntcion: dataSource.addMoreRows,
                  dataSource: dataSource,
                  columnNames: AssistantInfoModel.columns,
                  onCellTab: (value) {
                    print(dataSource.models[value - 1].ID);
                    internalPagesController.setPassedObject(dataSource.models[value - 1]);
                    internalPagesController.jumpToPage(1);
                  },
                ),
              ),
            )
          ],
        ),
        ViewAssistantPage()
      ],
    );
  }
}
