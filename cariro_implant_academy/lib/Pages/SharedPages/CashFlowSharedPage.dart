import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/IncomeModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Constants/Fonts.dart';
import '../../Models/CashFlowCategorySumamryModel.dart';
import '../../Models/CashFlowSumamryModel.dart';
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
    this.eS_dataSource,
    this.iS_dataSource,
    this.diS_dataSource,
    this.onIncomeRowClick,
    this.onExpenseRowClick,
  }) : super(key: key);
  IncomeDataSource i_dataSource;
  ExpensesDataSource e_dataSource;
  CashFlowSummaryDataSource? eS_dataSource;
  CashFlowSummaryDataSource? iS_dataSource;
  CashFlowSummaryDataSource? diS_dataSource;
  Function? onIncomeRowClick;
  Function? onExpenseRowClick;

  @override
  State<CashFlowSharedPage> createState() => _CashFlowSharedPageState();
}

class _CashFlowSharedPageState extends State<CashFlowSharedPage> {
  int selectedPage = 0;

  bool weekSelected = false;
  bool monthSelected = true;
  bool yearSelected = false;
  String selectedCategory = "";

  PageController _controller = PageController();

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
                    selectedCategory =
                        CashFlowSummaryDataSource().models[value - 2].Category!;
                    _controller.jumpToPage(1);
                  }),
            ),
          ],
        ),
        PageView.builder(
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              var pages = [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        weekSelected
                            ? CIA_PrimaryButton(
                                label: "This Week", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "This Week",
                                onTab: () {
                                  setState(() {
                                    weekSelected = true;
                                    monthSelected = false;
                                    yearSelected = false;
                                  });
                                }),
                        SizedBox(width: 10),
                        monthSelected
                            ? CIA_PrimaryButton(
                                label: "This Month", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "This Month",
                                onTab: () {
                                  setState(() {
                                    weekSelected = false;
                                    monthSelected = true;
                                    yearSelected = false;
                                  });
                                }),
                        SizedBox(width: 10),
                        yearSelected
                            ? CIA_PrimaryButton(
                                label: "This Year", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "This Year",
                                onTab: () {
                                  setState(() {
                                    weekSelected = false;
                                    monthSelected = false;
                                    yearSelected = true;
                                  });
                                }),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: CIA_Table(
                                showGridLines: true,
                                showSum: true,
                                title: "Expenses Summary",
                                columnNames: CashFlowSummaryModel.columns,
                                dataSource: widget.eS_dataSource == null
                                    ? CashFlowSummaryDataSource()
                                    : widget.eS_dataSource
                                        as CashFlowSummaryDataSource,
                                onCellClick: (value) {
                                  selectedCategory = CashFlowSummaryDataSource()
                                      .models[value - 2]
                                      .Category!;
                                  _controller.jumpToPage(1);
                                }),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                child: CIA_Table(
                                    showSum: true,
                                    showGridLines: true,
                                    title: "Income Summary",
                                    columnNames: CashFlowSummaryModel.columns,
                                    dataSource: widget.iS_dataSource == null
                                        ? CashFlowSummaryDataSource()
                                        : widget.iS_dataSource
                                            as CashFlowSummaryDataSource,
                                    onCellClick: (value) {
                                      try {
                                        selectedCategory =
                                            CashFlowSummaryDataSource()
                                                .models[value - 2]
                                                .Category!;
                                        _controller.jumpToPage(1);
                                      } catch (e) {}
                                    }),
                              ),
                              SizedBox(height: 30),
                              Expanded(
                                child: CIA_Table(
                                    showSum: true,
                                    showGridLines: true,
                                    title: "Doctors Income Summary",
                                    columnNames: CashFlowSummaryModel.columns,
                                    dataSource: widget.diS_dataSource == null
                                        ? CashFlowSummaryDataSource()
                                        : widget.diS_dataSource
                                            as CashFlowSummaryDataSource,
                                    onCellClick: (value) {
                                      selectedCategory =
                                          CashFlowSummaryDataSource()
                                              .models[value - 2]
                                              .Category!;
                                      _controller.jumpToPage(1);
                                    }),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _controller.jumpToPage(0);
                            },
                            icon: Icon(Icons.arrow_back)),
                        Expanded(
                            child: Center(
                                child: Text(
                          selectedCategory,
                          style: TextStyle(
                              fontFamily: Inter_ExtraBold, fontSize: 20),
                        )))
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: CIA_Table(
                          columnNames: CashFlowCategorySummaryModel.columns,
                          dataSource: CashFlowCategorySummaryDataSource(),
                          onCellClick: (value) {}),
                    ),
                  ],
                ),
              ];
              return pages[index];
            })
        /*PageView(
          controller: _controller,
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    weekSelected
                        ? CIA_PrimaryButton(
                            label: "This Week", isLong: true, onTab: () {})
                        : CIA_SecondaryButton(
                            label: "This Week",
                            onTab: () {
                              setState(() {
                                weekSelected = true;
                                monthSelected = false;
                                yearSelected = false;
                              });
                            }),
                    SizedBox(width: 10),
                    monthSelected
                        ? CIA_PrimaryButton(
                            label: "This Month", isLong: true, onTab: () {})
                        : CIA_SecondaryButton(
                            label: "This Month",
                            onTab: () {
                              setState(() {
                                weekSelected = false;
                                monthSelected = true;
                                yearSelected = false;
                              });
                            }),
                    SizedBox(width: 10),
                    yearSelected
                        ? CIA_PrimaryButton(
                            label: "This Year", isLong: true, onTab: () {})
                        : CIA_SecondaryButton(
                            label: "This Year",
                            onTab: () {
                              setState(() {
                                weekSelected = false;
                                monthSelected = false;
                                yearSelected = true;
                              });
                            }),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: CIA_Table(
                            showGridLines: true,
                            showSum: true,
                            title: "Expenses Summary",
                            columnNames: CashFlowSummaryModel.columns,
                            dataSource: widget.eS_dataSource == null
                                ? CashFlowSummaryDataSource()
                                : widget.eS_dataSource
                                    as CashFlowSummaryDataSource,
                            onCellClick: (value) {
                              if (widget.onExpenseRowClick != null)
                                widget.onExpenseRowClick!(value);
                            }),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                            child: CIA_Table(
                                showSum: true,
                                showGridLines: true,
                                title: "Income Summary",
                                columnNames: CashFlowSummaryModel.columns,
                                dataSource: widget.iS_dataSource == null
                                    ? CashFlowSummaryDataSource()
                                    : widget.iS_dataSource
                                        as CashFlowSummaryDataSource,
                                onCellClick: (value) {
                                  try {
                                    selectedCategory =
                                        CashFlowSummaryDataSource()
                                            .models[value - 2]
                                            .Category!;
                                    _controller.jumpToPage(1);
                                  } catch (e) {}
                                }),
                          ),
                          SizedBox(height: 30),
                          Expanded(
                            child: CIA_Table(
                                showSum: true,
                                showGridLines: true,
                                title: "Doctors Income Summary",
                                columnNames: CashFlowSummaryModel.columns,
                                dataSource: widget.diS_dataSource == null
                                    ? CashFlowSummaryDataSource()
                                    : widget.diS_dataSource
                                        as CashFlowSummaryDataSource,
                                onCellClick: (value) {
                                  selectedCategory = CashFlowSummaryDataSource()
                                      .models[value - 2]
                                      .Category!;
                                  _controller.jumpToPage(1);
                                }),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _controller.jumpToPage(0);
                        },
                        icon: Icon(Icons.arrow_back)),
                    Expanded(
                        child: Center(
                            child: Text(
                      selectedCategory,
                      style:
                          TextStyle(fontFamily: Inter_ExtraBold, fontSize: 20),
                    )))
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: CIA_Table(
                            showGridLines: true,
                            showSum: true,
                            title: "Expenses Summary",
                            columnNames: CashFlowSummaryModel.columns,
                            dataSource: widget.eS_dataSource == null
                                ? CashFlowSummaryDataSource()
                                : widget.eS_dataSource
                                    as CashFlowSummaryDataSource,
                            onCellClick: (value) {
                              if (widget.onExpenseRowClick != null)
                                widget.onExpenseRowClick!(value);
                            }),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                            child: CIA_Table(
                                showSum: true,
                                showGridLines: true,
                                title: "Income Summary",
                                columnNames: CashFlowSummaryModel.columns,
                                dataSource: widget.iS_dataSource == null
                                    ? CashFlowSummaryDataSource()
                                    : widget.iS_dataSource
                                        as CashFlowSummaryDataSource,
                                onCellClick: (value) {
                                  try {
                                    selectedCategory =
                                        CashFlowSummaryDataSource()
                                            .models[value - 2]
                                            .Category!;
                                    _controller.jumpToPage(1);
                                  } catch (e) {}
                                }),
                          ),
                          SizedBox(height: 30),
                          Expanded(
                            child: CIA_Table(
                                showSum: true,
                                showGridLines: true,
                                title: "Doctors Income Summary",
                                columnNames: CashFlowSummaryModel.columns,
                                dataSource: widget.diS_dataSource == null
                                    ? CashFlowSummaryDataSource()
                                    : widget.diS_dataSource
                                        as CashFlowSummaryDataSource,
                                onCellClick: (value) {
                                  selectedCategory = CashFlowSummaryDataSource()
                                      .models[value - 2]
                                      .Category!;
                                  _controller.jumpToPage(1);
                                }),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        )*/
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
    siteController.setAppBarWidget(tabs: ["Income", "Expenses", "Summary"]);
  }
}
