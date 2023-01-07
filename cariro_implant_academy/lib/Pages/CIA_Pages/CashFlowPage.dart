import 'package:cariro_implant_academy/Models/IncomeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/ExpensesModel.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class CashFlowsSearchPage extends StatefulWidget {
  const CashFlowsSearchPage({Key? key}) : super(key: key);

  @override
  State<CashFlowsSearchPage> createState() => _CashFlowsSearchPageState();
}

class _CashFlowsSearchPageState extends State<CashFlowsSearchPage> {
  IncomeDataSource i_dataSource = IncomeDataSource();
  ExpensesDataSource e_dataSource = ExpensesDataSource();
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return CashFlowSharedPage(
        i_dataSource: i_dataSource, e_dataSource: e_dataSource);
  }
}
