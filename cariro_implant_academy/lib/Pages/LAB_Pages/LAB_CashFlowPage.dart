import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/CashFlowSummaryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../features/cashflow/presentation/pages/cashFlowIncomPage.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class LAB_CashFlowsSearchPage extends StatefulWidget {
  const LAB_CashFlowsSearchPage({Key? key}) : super(key: key);

  @override
  State<LAB_CashFlowsSearchPage> createState() => _LAB_CashFlowsSearchPageState();
}

class _LAB_CashFlowsSearchPageState extends State<LAB_CashFlowsSearchPage> {
  CashFlowDataSource i_dataSource = CashFlowDataSource(type: CashFlowType.income);
  CashFlowDataSource e_dataSource = CashFlowDataSource(type: CashFlowType.expenses);
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return CashFlowIncomePage(
     // e_dataSource: e_dataSource,
    );
  }
}
