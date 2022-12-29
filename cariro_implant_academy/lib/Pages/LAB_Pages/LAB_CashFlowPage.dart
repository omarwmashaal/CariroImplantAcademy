import 'package:cariro_implant_academy/Models/IncomeModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/ExpensesModel.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_Table.dart';

class LAB_CashFlowsSearchPage extends StatefulWidget {
  const LAB_CashFlowsSearchPage({Key? key}) : super(key: key);

  @override
  State<LAB_CashFlowsSearchPage> createState() =>
      _LAB_CashFlowsSearchPageState();
}

class _LAB_CashFlowsSearchPageState extends State<LAB_CashFlowsSearchPage> {
  IncomeDataSource i_dataSource = IncomeDataSource();
  ExpensesDataSource e_dataSource = ExpensesDataSource();
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return TabsLayout(
        onChange: (value) => setState(() => selectedPage = value),
        sideWidget: Row(
          children: [
            selectedPage == 0
                ? CIA_PrimaryButton(
                    width: 155,
                    label: "Add new income",
                    onTab: () {
                      CIA_ShowPopUp(context, "Add new Income", Text("adasd"));
                    },
                    isLong: true,
                  )
                : CIA_PrimaryButton(
                    width: 155,
                    label: "Add new Expense",
                    onTab: () {
                      CIA_ShowPopUp(context, "Add new Expense", Text("adasd"));
                      //internalPagesController.jumpToPage(2);
                    },
                    isLong: true,
                  ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
        tabs: [
          "Income",
          "Expenses"
        ],
        pages: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Date", values: ["dates"])),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Category", values: ["dates"])),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Items", values: ["dates"])),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Methods", values: ["dates"])),
                        ],
                      )),
                      CIA_PrimaryButton(
                        label: "Filter",
                        onTab: () {},
                        isLong: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 5,
                child: CIA_Table(
                    columnNames: IncomeInfoModel.columns,
                    dataSource: i_dataSource,
                    onCellClick: (value) {
                      print(i_dataSource.models[value - 1].ID);
                    }),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Date", values: ["dates"])),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Category", values: ["dates"])),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Items", values: ["dates"])),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CIA_DropDown(
                                  label: "Methods", values: ["dates"])),
                        ],
                      )),
                      CIA_PrimaryButton(
                        label: "Filter",
                        onTab: () {},
                        isLong: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 5,
                child: CIA_Table(
                    columnNames: IncomeInfoModel.columns,
                    dataSource: e_dataSource,
                    onCellClick: (value) {
                      print(e_dataSource.models[value - 1].ID);
                    }),
              ),
            ],
          ),
        ]);
  }
}
