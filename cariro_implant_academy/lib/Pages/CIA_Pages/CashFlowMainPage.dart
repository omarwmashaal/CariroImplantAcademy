import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/CashFlow.dart';
import '../../Widgets/SearchLayout.dart';
import 'Patient_ViewPatientPage.dart';

class CashFlowMainPage extends StatefulWidget {
  CashFlowMainPage({Key? key}) : super(key: key);
  var myController = new PageController(initialPage: 0);

  @override
  State<CashFlowMainPage> createState() => _CashFlowMainPageState();
}

class _CashFlowMainPageState extends State<CashFlowMainPage> {
  CashFlowDataSource dataSource = CashFlowDataSource();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: internalPagesController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        TabsLayout(
          tabs: ["Income", "Expenses"],
          pages: [
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
              columnNames: CashFlow.columns,
              loadMoreFuntcion: dataSource.addMoreRows,
              dataSource: dataSource,
              onCellTab: (value) {
                internalPagesController.jumpToPage(1);
              },
            ),
            Container()
          ],
        ),
        TitleWidget(title: "Omar")
      ],
    );
  }


}
