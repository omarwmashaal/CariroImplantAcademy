import 'package:cariro_implant_academy/Models/IncomeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/ExpensesModel.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class Clinic_CashFlowPage extends StatefulWidget {
  const Clinic_CashFlowPage({Key? key}) : super(key: key);

  @override
  State<Clinic_CashFlowPage> createState() => _Clinic_CashFlowPageState();
}

class _Clinic_CashFlowPageState extends State<Clinic_CashFlowPage> {
  IncomeDataSource i_dataSource = IncomeDataSource();
  ExpensesDataSource e_dataSource = ExpensesDataSource();
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return CashFlowSharedPage(
        i_dataSource: i_dataSource, e_dataSource: e_dataSource);
  }
}
