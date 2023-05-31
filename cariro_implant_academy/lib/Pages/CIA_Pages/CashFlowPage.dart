import 'package:cariro_implant_academy/Models/PaymentLogModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../API/PatientAPI.dart';
import '../../Models/CashFlow.dart';
import '../../Models/CashFlowSummaryModel.dart';
import '../../Models/ReceiptModel.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/FormTextWidget.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class CashFlowsSearchPage extends StatefulWidget {
  const CashFlowsSearchPage({Key? key}) : super(key: key);

  @override
  State<CashFlowsSearchPage> createState() => _CashFlowsSearchPageState();
}

class _CashFlowsSearchPageState extends State<CashFlowsSearchPage> {
  CashFlowDataSource i_dataSource = CashFlowDataSource(type: CashFlowType.income);
  CashFlowDataSource e_dataSource = CashFlowDataSource(type: CashFlowType.expenses);
  CashFlowSummaryDataSource eS_dataSource = CashFlowSummaryDataSource(type: CashFlowType.income);
  CashFlowSummaryDataSource iS_dataSource = CashFlowSummaryDataSource(type: CashFlowType.expenses);

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return CashFlowIncomeSharedPage(
    );
  }
}
