import 'package:cariro_implant_academy/API/CashFlowAPI.dart';
import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/CashFlowSummaryModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Constants/Fonts.dart';
import '../../Models/CashFlowCategorySumamryModel.dart';
import '../../Models/DTOs/DropDownDTO.dart';
import '../../Widgets/CIA_IncrementalExpensesTextField.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_Table.dart';
import '../../Widgets/Title.dart';

class _getXController extends GetxController {
  static RxInt incomeSum = 0.obs;
  static RxInt expensesSum = 0.obs;
  static RxString from = "".obs;
  static RxString to = "".obs;
}

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
  CashFlowDataSource i_dataSource;
  CashFlowDataSource e_dataSource;
  CashFlowSummaryDataSource? eS_dataSource;
  CashFlowSummaryDataSource? iS_dataSource;
  CashFlowSummaryDataSource? diS_dataSource;
  Function(CashFlowModel model)? onIncomeRowClick;
  Function(int index)? onExpenseRowClick;

  @override
  State<CashFlowSharedPage> createState() => _CashFlowSharedPageState();
}

class _CashFlowSharedPageState extends State<CashFlowSharedPage> {
  int selectedPage = 0;

  bool weekSelected = false;
  bool monthSelected = true;
  bool yearSelected = false;
  bool lastMonthSelected = false;
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
            Obx(
              () => TitleWidget(
                title: siteController.title.value,
                showBackButton: false,
              ),
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
                        Expanded(child: CIA_DropDown(label: "Date", values: ["dates"])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CIA_DropDown(label: "Category", values: ["dates"])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CIA_DropDown(label: "Items", values: ["dates"])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CIA_DropDown(label: "Methods", values: ["dates"])),
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
                  columnNames: widget.i_dataSource.columns,
                  dataSource: widget.i_dataSource,
                  loadFunction: widget.i_dataSource.loadData,
                  onCellClick: (value) {
                    if (widget.onIncomeRowClick != null) widget.onIncomeRowClick!(widget.i_dataSource.models[value - 1]);
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
                        List<CashFlowModel> models = <CashFlowModel>[
                          CashFlowModel(
                            category: DropDownDTO(),
                            paymentMethod: DropDownDTO(),
                            supplier: DropDownDTO(),
                          )
                        ];
                        bool newCategory = false;
                        bool newPaymentMethod = false;
                        bool newSupplier = false;
                        bool isStockItem = false;
                        int total = 0;
                        CashFlowModel dummyModel = CashFlowModel(
                          category: DropDownDTO(),
                          paymentMethod: DropDownDTO(),
                          supplier: DropDownDTO(),
                        );
                        CIA_ShowPopUp(
                            context: context,
                            width: 700,
                            height: 500,
                            title: "Add new Expenses",
                            onSave: () async {
                              models.forEach((element) {
                                element.supplierId = dummyModel.supplierId;
                                element.supplier = dummyModel.supplier;
                                element.paymentMethodId = dummyModel.paymentMethodId;
                                element.paymentMethod = dummyModel.paymentMethod;
                                element.categoryId = dummyModel.categoryId;
                                element.category = dummyModel.category;
                              });
                              var res = await CashFlowAPI.AddExpense(models, isStockItem);
                              if (res.statusCode == 200) {
                                ShowSnackBar(isSuccess: true, title: "Success", message: "Entries Added!");
                              } else
                                ShowSnackBar(isSuccess: false, title: "Failed", message: res.errorMessage ?? "");

                              await widget.i_dataSource.loadData();
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: () {
                                            List<Widget> r = [];
                                            r.add(Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_MultiSelectChipWidget(
                                                    onChange: (item, isSelected) => setState(() => isStockItem = isSelected),
                                                    labels: [
                                                      CIA_MultiSelectChipWidgeModel(label: "Is Stock item?"),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: FormTextKeyWidget(
                                                      text: "Is this a stock item?",
                                                    ))
                                              ],
                                            ));
                                            r.add(SizedBox(height: 10));
                                            r.add(Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_MultiSelectChipWidget(
                                                    onChange: (item, isSelected) => setState(() => newCategory = isSelected),
                                                    labels: [
                                                      CIA_MultiSelectChipWidgeModel(label: "New Category"),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: newCategory
                                                      ? CIA_TextFormField(
                                                          label: "Category",
                                                          onChange: (value) {
                                                            dummyModel.category = DropDownDTO(name: value);
                                                            dummyModel.categoryId = null;
                                                            models.forEach((element) {
                                                              element.category = DropDownDTO(name: value);
                                                              element.categoryId = null;
                                                            });
                                                          },
                                                          controller: TextEditingController(text: dummyModel.category!.name ?? ""),
                                                        )
                                                      : CIA_DropDownSearch(
                                                          label: "Category",
                                                          asyncItems: SettingsAPI.GetExpensesCategories,
                                                          onSelect: (value) {
                                                            dummyModel.category = value;
                                                            dummyModel.categoryId = value.id;
                                                            models.forEach((model) {});
                                                          },
                                                          selectedItem: dummyModel.category,
                                                        ),
                                                )
                                              ],
                                            ));
                                            r.add(SizedBox(height: 10));
                                            r.add(Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_MultiSelectChipWidget(
                                                    onChange: (item, isSelected) => setState(() => newPaymentMethod = isSelected),
                                                    labels: [
                                                      CIA_MultiSelectChipWidgeModel(label: "New Payment Method"),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: newPaymentMethod
                                                      ? CIA_TextFormField(
                                                          label: "Payment Method",
                                                          onChange: (value) {
                                                            dummyModel.paymentMethod = DropDownDTO(name: value);
                                                            dummyModel.paymentMethodId = null;
                                                            models.forEach((model) {
                                                              model.paymentMethod = DropDownDTO(name: value);
                                                              model.paymentMethodId = null;
                                                            });
                                                          },
                                                          controller: TextEditingController(text: dummyModel.paymentMethod!.name ?? ""),
                                                        )
                                                      : CIA_DropDownSearch(
                                                          label: "Payment Method",
                                                          asyncItems: SettingsAPI.GetPaymentMethods,
                                                          onSelect: (value) {
                                                            dummyModel.paymentMethod = value;
                                                            dummyModel.paymentMethodId = value.id;
                                                            models.forEach((model) {
                                                              model.paymentMethod = value;
                                                              model.paymentMethodId = value.id;
                                                            });
                                                          },
                                                          selectedItem: dummyModel.paymentMethod,
                                                        ),
                                                )
                                              ],
                                            ));
                                            r.add(SizedBox(height: 10));
                                            r.add(Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_MultiSelectChipWidget(
                                                    onChange: (item, isSelected) => setState(() => newSupplier = isSelected),
                                                    labels: [
                                                      CIA_MultiSelectChipWidgeModel(label: "New Supplier"),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: newSupplier
                                                      ? CIA_TextFormField(
                                                          label: "Supplier",
                                                          onChange: (value) {
                                                            dummyModel.supplier = DropDownDTO(name: value);
                                                            dummyModel.supplierId = null;
                                                            models.forEach((element) {
                                                              element.supplier = DropDownDTO(name: value);
                                                              element.supplierId = null;
                                                            });
                                                          },
                                                          controller: TextEditingController(text: dummyModel.supplier!.name ?? ""),
                                                        )
                                                      : CIA_DropDownSearch(
                                                          label: "Supplier",
                                                          asyncItems: SettingsAPI.GetSuppliers,
                                                          onSelect: (value) {
                                                            dummyModel.supplier = value;
                                                            dummyModel.supplierId = value.id;
                                                            models.forEach((model) {
                                                              model.supplier = value;
                                                              model.supplierId = value.id;
                                                            });
                                                          },
                                                          selectedItem: dummyModel.supplier,
                                                        ),
                                                )
                                              ],
                                            ));
                                            r.addAll(models
                                                .map((model) => Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: CIA_TextFormField(
                                                                  onChange: (value) => model.name = value,
                                                                  label: "Name",
                                                                  controller: TextEditingController(text: model.name ?? "")),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: CIA_TextFormField(
                                                                isNumber: true,
                                                                onChange: (value) {
                                                                  if (value == null || value == "") value = "0";
                                                                  model.price = int.parse(value);
                                                                  total = 0;
                                                                  models.forEach((element) {
                                                                    total += element.price ?? 0;
                                                                  });
                                                                  setState(() {});
                                                                },
                                                                label: "Price",
                                                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: CIA_TextFormField(
                                                                isNumber: true,
                                                                onChange: (value) {
                                                                  if (value == null || value == "") value = "0";
                                                                  model.count = int.parse(value);
                                                                  setState(() {});
                                                                },
                                                                label: "Count",
                                                                controller: TextEditingController(text: (model.count ?? 0).toString()),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: CIA_TextFormField(
                                                                onChange: (value) => model.notes = value,
                                                                label: "Notes",
                                                                controller: TextEditingController(text: model.notes ?? ""),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            IconButton(
                                                                onPressed: () {
                                                                  int index = 0;
                                                                  index = models.indexWhere((element) => element == model);
                                                                  models.insert(
                                                                      index + 1,
                                                                      CashFlowModel(
                                                                        category: dummyModel.category,
                                                                        categoryId: dummyModel.categoryId,
                                                                        paymentMethod: dummyModel.paymentMethod,
                                                                        paymentMethodId: dummyModel.paymentMethodId,
                                                                        supplier: dummyModel.supplier,
                                                                        supplierId: dummyModel.supplierId,
                                                                      ));
                                                                  setState(() {});
                                                                },
                                                                icon: Icon(Icons.add)),
                                                            IconButton(
                                                                onPressed: () {
                                                                  models.remove(model);
                                                                  setState(() {});
                                                                },
                                                                icon: Icon(Icons.remove))
                                                          ],
                                                        )
                                                      ],
                                                    ))
                                                .toList());

                                            return r;
                                          }(),
                                        ),
                                      ),
                                    ),
                                    Text("Total: ${total.toString()}")
                                  ],
                                );
                              },
                            ));
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
                        Expanded(child: CIA_DropDown(label: "Date", values: ["dates"])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CIA_DropDown(label: "Category", values: ["dates"])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CIA_DropDown(label: "Items", values: ["dates"])),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CIA_DropDown(label: "Methods", values: ["dates"])),
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
                  columnNames: widget.e_dataSource.columns,
                  dataSource: widget.e_dataSource,
                  loadFunction: widget.e_dataSource.loadData,
                  onCellClick: (value) {
                    /*selectedCategory =
                        CashFlowSummaryDataSource().models[value - 2].Category!;
                    _controller.jumpToPage(1);*/
                  }),
            ),
          ],
        ),
        PageView.builder(
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              var pages = [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        weekSelected
                            ? CIA_PrimaryButton(label: "This Week", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "This Week",
                                onTab: () {
                                  setState(() {
                                    weekSelected = true;
                                    monthSelected = false;
                                    yearSelected = false;
                                    lastMonthSelected = false;
                                  });
                                }),
                        SizedBox(width: 10),
                        monthSelected
                            ? CIA_PrimaryButton(label: "This Month", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "This Month",
                                onTab: () {
                                  setState(() {
                                    weekSelected = false;
                                    monthSelected = true;
                                    yearSelected = false;
                                    lastMonthSelected = false;
                                  });
                                }),
                        SizedBox(width: 10),
                        lastMonthSelected
                            ? CIA_PrimaryButton(label: "Last Month", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "Last Month",
                                onTab: () {
                                  setState(() {
                                    weekSelected = false;
                                    monthSelected = false;
                                    lastMonthSelected = true;
                                    yearSelected = false;
                                  });
                                }),
                        SizedBox(width: 10),
                        yearSelected
                            ? CIA_PrimaryButton(label: "This Year", isLong: true, onTab: () {})
                            : CIA_SecondaryButton(
                                label: "This Year",
                                onTab: () {
                                  setState(() {
                                    weekSelected = false;
                                    monthSelected = false;
                                    yearSelected = true;
                                    lastMonthSelected = false;
                                  });
                                }),
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => Row(
                        children: [
                          FormTextValueWidget(text: "from: ${_getXController.from.value}"),
                          SizedBox(
                            width: 10,
                          ),
                          FormTextValueWidget(text: "to: ${_getXController.to.value}"),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CIA_Table(
                                    showGridLines: true,
                                    title: "Expenses Summary",
                                    columnNames: widget.eS_dataSource!.columns,
                                    loadFunction: () async {
                                      var res = await widget.eS_dataSource!.loadData(weekSelected
                                          ? "ThisWeek"
                                          : monthSelected
                                              ? "ThisMonth"
                                              : yearSelected
                                                  ? "ThisYear"
                                                  : lastMonthSelected
                                                      ? "LastMonth"
                                                      : "");
                                      if (res.statusCode == 200) {
                                        _getXController.from.value = (res.result as CashFlowSummaryModel).from ?? "";
                                        _getXController.to.value = (res.result as CashFlowSummaryModel).to ?? "";
                                      }
                                      var t = 0;
                                      widget.eS_dataSource!.models.forEach((element) {
                                        t += element.total ?? 0;
                                      });
                                      _getXController.expensesSum.value = t;
                                      print(t);
                                      return res;
                                    },
                                    dataSource: widget.eS_dataSource as CashFlowSummaryDataSource,
                                    onCellClick: (value) {
                                      /*  selectedCategory = CashFlowSummaryDataSource()
                                          .models[value - 2]
                                          .Category!;
                                      _controller.jumpToPage(1);*/
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    FormTextKeyWidget(text: "Total: "),
                                    Obx(() => FormTextValueWidget(
                                          text: () {
                                            _getXController.expensesSum.value = 0;
                                            widget.eS_dataSource!.models.forEach((element) {
                                              _getXController.expensesSum.value += element.total ?? 0;
                                            });
                                            return _getXController.expensesSum.value.toString();
                                          }(),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                              child: Column(
                            children: [
                              CIA_Table(
                                  showGridLines: true,
                                  title: "Income Summary",
                                  columnNames: widget.iS_dataSource!.columns,
                                  dataSource: widget.iS_dataSource == null
                                      ? CashFlowSummaryDataSource(type: CashFlowType.income)
                                      : widget.iS_dataSource as CashFlowSummaryDataSource,
                                  loadFunction: () async {
                                    var res = await widget.iS_dataSource!.loadData(weekSelected
                                        ? "ThisWeek"
                                        : monthSelected
                                            ? "ThisMonth"
                                            : yearSelected
                                                ? "ThisYear"
                                                : lastMonthSelected
                                                    ? "LastMonth"
                                                    : "");
                                    var t = 0;
                                    widget.iS_dataSource!.models.forEach((element) {
                                      t += element.total ?? 0;
                                    });
                                    _getXController.incomeSum.value = t;
                                    print(t);
                                    return res;
                                  },
                                  onCellClick: (value) {
                                    try {
                                      selectedCategory = widget.iS_dataSource!.models[value - 2].category!.name!;
                                      _controller.jumpToPage(1);
                                    } catch (e) {}
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  FormTextKeyWidget(text: "Total: "),
                                  Obx(() => FormTextValueWidget(
                                        text: () {
                                          _getXController.incomeSum.value = 0;
                                          widget.iS_dataSource!.models.forEach((element) {
                                            _getXController.incomeSum.value += element.total ?? 0;
                                          });
                                          return _getXController.incomeSum.value.toString();
                                        }(),
                                      )),
                                ],
                              ),
                              SizedBox(height: 30),
                              /*Expanded(
                                child: CIA_Table(

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
                              )*/
                            ],
                          ))
                        ],
                      ),
                    ),
                    Center(
                      child: Wrap(
                        children: [
                              CIA_PrimaryButton(
                              label: "Add Settlement",
                              onTab: () {
                                int newValue = 0;
                                String filter = "This month";
                                CIA_ShowPopUp(
                                  onSave: ()async
                                  {
                                    var res = await CashFlowAPI.AddSettlement(filter, newValue);
                                    ShowSnackBar(isSuccess: res.statusCode==200);
                                    setState(() {

                                    });
                                  },
                                  context: context,
                                  child: Column(
                                    children: [
                                      CIA_MultiSelectChipWidget(
                                          singleSelect: true,
                                          onChange: (item, isSelected) {
                                            if (isSelected) {
                                              filter = item;
                                            }
                                          },
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "This month", isSelected: true),
                                            CIA_MultiSelectChipWidgeModel(label: "Last month"),
                                          ]),
                                      CIA_TextFormField(
                                        isNumber: true,
                                        label: "Value",
                                        controller: TextEditingController(),
                                        onChange: (v) => newValue = int.parse(v),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ],
                      ),
                    ),
                    Expanded(child: SizedBox())
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
                          style: TextStyle(fontFamily: Inter_ExtraBold, fontSize: 20),
                        )))
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: CIA_Table(
                          columnNames: CashFlowCategorySummaryModel.columns, dataSource: CashFlowCategorySummaryDataSource(), onCellClick: (value) {}),
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

    /*TabsLayout(
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
                        width: 600,
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
        ]);*/
  }

  @override
  void initState() {
    siteController.setAppBarWidget(tabs: ["Income", "Expenses", "Summary"]);
  }
}
