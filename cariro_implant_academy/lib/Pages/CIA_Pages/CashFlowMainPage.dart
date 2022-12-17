import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/CashFlow.dart';
import '../../Widgets/SearchLayout.dart';

class CashFlowMainPage extends StatefulWidget {
  const CashFlowMainPage({Key? key}) : super(key: key);

  @override
  State<CashFlowMainPage> createState() => _CashFlowMainPageState();
}

class _CashFlowMainPageState extends State<CashFlowMainPage> {
  CashFlowDataSource dataSource = CashFlowDataSource();

  @override
  Widget build(BuildContext context) {
    return TabsLayout(
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
        ),
        Container()
      ],
    );
  }
}
