import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/IncomeModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Models/ExpensesModel.dart';
import '../../Widgets/CIA_IncrementalExpensesTextField.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/Title.dart';

class CashFlowSharedPage extends StatefulWidget {
  CashFlowSharedPage({
    Key? key,
    required this.i_dataSource,
    required this.e_dataSource,
    this.onIncomeRowClick,
    this.onExpenseRowClick,
  }) : super(key: key);
  IncomeDataSource i_dataSource;
  ExpensesDataSource e_dataSource;
  Function? onIncomeRowClick;
  Function? onExpenseRowClick;

  @override
  State<CashFlowSharedPage> createState() => _CashFlowSharedPageState();
}

class _CashFlowSharedPageState extends State<CashFlowSharedPage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: tabsController,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                  () => TitleWidget(
                    title: siteController.title.value,
                    showBackButton: false,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CIA_PrimaryButton(
                      width: 155,
                      label: "Add new income",
                      onTab: () {
                        CIA_ShowPopUp(
                            context: context,
                            title: "Add new Income",
                            child: Text("adasd"));
                      },
                      isLong: true,
                    ),
                  ),
                )
              ],
            ),
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
                            child:
                                CIA_DropDown(label: "Date", values: ["dates"])),
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
                  dataSource: widget.i_dataSource,
                  onCellClick: (value) {
                    if (widget.onIncomeRowClick != null)
                      widget.onIncomeRowClick!(value);
                  }),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                  () => TitleWidget(
                    title: siteController.title.value,
                    showBackButton: false,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CIA_PrimaryButton(
                      width: 155,
                      label: "Add new Expense",
                      onTab: () {
                        CIA_ShowPopUp(
                          buttonText: "Save",
                          size: 600,
                          context: context,
                          title: "Add new Expense",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CIA_DropDown(label: "Category", values: [
                                "values",
                                "values",
                                "values",
                                "values",
                              ]),
                              SizedBox(height: 10),
                              CIA_IncrementalExpensesTextField(
                                label: 'Item',
                              )
                            ],
                          ),
                        );
                        //internalPagesController.jumpToPage(2);
                      },
                      isLong: true,
                    ),
                  ),
                )
              ],
            ),
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
                            child:
                                CIA_DropDown(label: "Date", values: ["dates"])),
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
                  dataSource: widget.e_dataSource,
                  onCellClick: (value) {
                    if (widget.onExpenseRowClick != null)
                      widget.onExpenseRowClick!(value);
                  }),
            ),
          ],
        ),
      ],
    );

    TabsLayout(
        onChange: (value) => setState(() => selectedPage = value),
        sideWidget: Row(
          children: [
            selectedPage == 0
                ? CIA_PrimaryButton(
                    width: 155,
                    label: "Add new income",
                    onTab: () {
                      CIA_ShowPopUp(
                          context: context,
                          title: "Add new Income",
                          child: Text("adasd"));
                    },
                    isLong: true,
                  )
                : CIA_PrimaryButton(
                    width: 155,
                    label: "Add new Expense",
                    onTab: () {
                      CIA_ShowPopUp(
                        buttonText: "Save",
                        size: 600,
                        context: context,
                        title: "Add new Expense",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CIA_DropDown(label: "Category", values: [
                              "values",
                              "values",
                              "values",
                              "values",
                            ]),
                            SizedBox(height: 10),
                            CIA_IncrementalExpensesTextField(
                              label: 'Item',
                            )
                          ],
                        ),
                      );
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
                    dataSource: widget.i_dataSource,
                    onCellClick: (value) {
                      if (widget.onIncomeRowClick != null)
                        widget.onIncomeRowClick!(value);
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
                    dataSource: widget.e_dataSource,
                    onCellClick: (value) {
                      if (widget.onExpenseRowClick != null)
                        widget.onExpenseRowClick!(value);
                    }),
              ),
            ],
          ),
        ]);
  }

  @override
  void initState() {
    siteController.setAppBarWidget(tabs: ["Income", "Expenses"]);
  }
}
