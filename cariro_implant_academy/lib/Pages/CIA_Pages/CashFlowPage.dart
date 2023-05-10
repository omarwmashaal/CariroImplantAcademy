import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CashFlow.dart';
import '../../Models/CashFlowSummaryModel.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class CashFlowsSearchPage extends StatefulWidget {
  const CashFlowsSearchPage({Key? key}) : super(key: key);

  @override
  State<CashFlowsSearchPage> createState() => _CashFlowsSearchPageState();
}

class _CashFlowsSearchPageState extends State<CashFlowsSearchPage> {
  CashFlowDataSource i_dataSource = CashFlowDataSource(type: CashFlowType.income);
  CashFlowDataSource e_dataSource = CashFlowDataSource(type: CashFlowType.expenses);
  CashFlowSummaryDataSource eS_dataSource= CashFlowSummaryDataSource(type: CashFlowType.income);
  CashFlowSummaryDataSource iS_dataSource=  CashFlowSummaryDataSource(type: CashFlowType.expenses);

  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return CashFlowSharedPage(
      i_dataSource: CashFlowDataSource(type: CashFlowType.income),
      e_dataSource: CashFlowDataSource(type: CashFlowType.expenses),
      eS_dataSource: CashFlowSummaryDataSource(type: CashFlowType.expenses),
      iS_dataSource: CashFlowSummaryDataSource(type: CashFlowType.income),

    );
  }
}
