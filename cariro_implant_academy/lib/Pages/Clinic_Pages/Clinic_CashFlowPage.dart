import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CashFlow.dart';
import '../../Models/CashFlowSummaryModel.dart';
import '../../features/cashflow/presentation/pages/cashFlowIncomPage.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class Clinic_CashFlowPage extends StatefulWidget {
  const Clinic_CashFlowPage({Key? key}) : super(key: key);

  @override
  State<Clinic_CashFlowPage> createState() => _Clinic_CashFlowPageState();
}

class _Clinic_CashFlowPageState extends State<Clinic_CashFlowPage> {
  CashFlowDataSource i_dataSource = CashFlowDataSource(type: CashFlowType.income);
  CashFlowDataSource e_dataSource = CashFlowDataSource(type: CashFlowType.expenses);
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return CashFlowIncomePage(
      //e_dataSource: e_dataSource,
    );
  }
}
