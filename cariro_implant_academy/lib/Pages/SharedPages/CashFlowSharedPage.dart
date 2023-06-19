import 'package:cariro_implant_academy/API/CashFlowAPI.dart';
import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/CashFlowSummaryModel.dart';
import 'package:cariro_implant_academy/Models/TacCompanyModel.dart';
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
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../API/PatientAPI.dart';
import '../../API/StockAPI.dart';
import '../../Constants/Fonts.dart';
import '../../Models/CashFlowCategorySumamryModel.dart';
import '../../Models/DTOs/DropDownDTO.dart';
import '../../Models/Enum.dart';
import '../../Models/ImplantModel.dart';
import '../../Models/PaymentLogModel.dart';
import '../../Models/ReceiptModel.dart';
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

class CashFlowIncomeSharedPage extends StatefulWidget {
  CashFlowIncomeSharedPage({
    Key? key,
  }) : super(key: key);
  CashFlowDataSource i_dataSource = CashFlowDataSource(type: CashFlowType.income);
  Function(CashFlowModel model)? onIncomeRowClick;
  static String routeName = "CashFlowIncome";
  static String routePath = "CashFlowIncome";
  static String routeCIAname = "CashFlowIncomeCIA";
  static String routeLABname = "CashFlowIncomeLAB";
  static String routeClinicName = "CashFlowIncomeClinic";

  @override
  State<CashFlowIncomeSharedPage> createState() => _CashFlowIncomeSharedPageState();
}

class _CashFlowIncomeSharedPageState extends State<CashFlowIncomeSharedPage> {
  String? from;
  String? to;
  int? catId;
  int? paymentMethodId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: "Income",
          showBackButton: false,
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
                        child: CIA_DateTimeTextFormField(
                      label: "Date From",
                      controller: TextEditingController(),
                      onChange: (value) => from = value,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DateTimeTextFormField(
                      label: "Date To",
                      controller: TextEditingController(),
                      onChange: (value) => to = value,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearch(
                      label: "Category",
                      asyncItems: () => SettingsAPI.GetIncomeCategories(),
                      onSelect: (value) => catId = value.id,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearch(
                      label: "Payment Methods",
                      asyncItems: () => SettingsAPI.GetPaymentMethods(),
                      onSelect: (value) => paymentMethodId = value.id,
                    ))
                  ],
                )),
                CIA_PrimaryButton(
                  label: "Filter",
                  onTab: () {
                    widget.i_dataSource.loadData(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId);
                  },
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
              loadFunction: () async => widget.i_dataSource.loadData(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId),
              onCellClick: (value) async {
                PaymentLogDataSrouce dataSource = PaymentLogDataSrouce();
                var recRes = await PatientAPI.GetReceiptById(widget.i_dataSource.models[value - 1]!.receiptID!);
                ReceiptModel receipt = ReceiptModel();
                if (recRes.statusCode == 200) receipt = recRes.result as ReceiptModel;

                await CIA_ShowPopUp(
                    width: 1000,
                    context: context,
                    title: "Receipt And Payment Logs",
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Date")),
                                          Expanded(child: FormTextValueWidget(text: receipt.date ?? "")),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Patient ID")),
                                          Expanded(child: FormTextValueWidget(text: (receipt.patient!.id ?? "").toString())),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Patient Name")),
                                          Expanded(child: FormTextValueWidget(text: receipt.patient!.name ?? "")),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Operator")),
                                          Expanded(child: FormTextValueWidget(text: receipt.operator!.name ?? "")),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        children: () {
                                          List<Widget> r = [];
                                          receipt.toothReceiptData!.forEach((element) {
                                            r.add(Visibility(
                                              visible: (element.crown ?? 0) != 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Crown")),
                                                    Expanded(child: FormTextValueWidget(text: (element.crown ?? 0).toString())),
                                                  ],
                                                ),
                                              ),
                                            ));
                                            r.add(Visibility(
                                              visible: (element.scaling ?? 0) != 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Scaling")),
                                                    Expanded(child: FormTextValueWidget(text: (element.scaling ?? 0).toString())),
                                                  ],
                                                ),
                                              ),
                                            ));
                                            r.add(Visibility(
                                              visible: (element.extraction ?? 0) != 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Extraction")),
                                                    Expanded(child: FormTextValueWidget(text: (element.extraction ?? 0).toString())),
                                                  ],
                                                ),
                                              ),
                                            ));
                                            r.add(Visibility(
                                              visible: (element.restoration ?? 0) != 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Restoration")),
                                                    Expanded(child: FormTextValueWidget(text: (element.restoration ?? 0).toString())),
                                                  ],
                                                ),
                                              ),
                                            ));
                                            r.add(Visibility(
                                              visible: (element.rootCanalTreatment ?? 0) != 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Root Canal Treatment")),
                                                    Expanded(child: FormTextValueWidget(text: (element.rootCanalTreatment ?? 0).toString())),
                                                  ],
                                                ),
                                              ),
                                            ));
                                            r.add(Divider());
                                          });
                                          return r;
                                        }(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(child: FormTextKeyWidget(text: "Total")),
                                    Expanded(child: FormTextValueWidget(text: (receipt.total ?? 0).toString())),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(child: FormTextKeyWidget(text: "Paid amount")),
                                    Expanded(child: FormTextValueWidget(color: Colors.green, text: (receipt.paid ?? 0).toString())),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(child: FormTextKeyWidget(text: "Unpaid amount")),
                                    Expanded(
                                        child: FormTextValueWidget(
                                            color: receipt.unpaid != 0 ? Colors.red : Colors.black, text: (receipt.unpaid ?? 0).toString())),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CIA_Table(
                            columnNames: dataSource.columns,
                            dataSource: dataSource,
                            loadFunction: () async {
                              return await dataSource.loadData(
                                  id: widget.i_dataSource!.models[value - 1]!.patientId!, receiptId: widget.i_dataSource!.models[value - 1]!.receiptID!);
                            },
                          ),
                        ),
                      ],
                    ));
              }),
        ),
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
  void initState() {}
}

class CashFlowExpensesSharedPage extends StatefulWidget {
  CashFlowExpensesSharedPage({
    Key? key,
  }) : super(key: key);
  CashFlowDataSource e_dataSource = CashFlowDataSource(type: CashFlowType.expenses);

  static String routeName = "CashFlowExpenses";
  static String routePath = "CashFlowExpenses";
  static String routeCIAname = "CashFlowExpensesCIA";
  static String routeLABname = "CashFlowExpensesLAB";
  static String routeClinicName = "CashFlowExpensesClinic";

  @override
  State<CashFlowExpensesSharedPage> createState() => _CashFlowExpensesSharedPageState();
}

class _CashFlowExpensesSharedPageState extends State<CashFlowExpensesSharedPage> {
  String? from;
  String? to;
  int? catId;
  int? paymentMethodId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TitleWidget(
              title: "Expenses",
              showBackButton: false,
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
                    EnumExpenseseCategoriesType expCategory = EnumExpenseseCategoriesType.Service;

                    CIA_ShowPopUp(
                        context: context,
                        width: 1000,
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
                          var res = await CashFlowAPI.AddExpense(models, isStockItem, expCategory);
                          if (res.statusCode == 200) {
                            ShowSnackBar(context, isSuccess: true, title: "Success", message: "Entries Added!");
                          } else
                            ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "");

                          await widget.e_dataSource.loadData();
                        },
                        child: SimpleBuilder(builder: (context) {
                          String medicalType = "Tacs";
                          return StatefulBuilder(
                            builder: (context, _setState) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: () {
                                          List<Widget> r = [];
                                          r.add(
                                            CIA_MultiSelectChipWidget(
                                              key: GlobalKey(),
                                              singleSelect: true,
                                              labels: [
                                                CIA_MultiSelectChipWidgeModel(
                                                    label: "Paid for service?", isSelected: expCategory == EnumExpenseseCategoriesType.Service),
                                                CIA_MultiSelectChipWidgeModel(
                                                    label: "Paid for buying items?",
                                                    isSelected: expCategory == EnumExpenseseCategoriesType.BoughtItem ||
                                                        expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                                              ],
                                              onChange: (item, isSelected) {
                                                if (item == "Paid for service?")
                                                  expCategory = EnumExpenseseCategoriesType.Service;
                                                else
                                                  expCategory = EnumExpenseseCategoriesType.BoughtItem;
                                                _setState(() {});
                                              },
                                            ),
                                          );

                                          r.add(SizedBox(height: 10));
                                          r.add(
                                            Visibility(
                                              visible: expCategory == EnumExpenseseCategoriesType.BoughtItem ||
                                                  expCategory == EnumExpenseseCategoriesType.BoughtMedical,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: CIA_MultiSelectChipWidget(
                                                  key: GlobalKey(),
                                                  singleSelect: true,
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Bought nonMedical Item?", isSelected: expCategory == EnumExpenseseCategoriesType.BoughtItem),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Bought Medical Item?", isSelected: expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                                                  ],
                                                  onChange: (item, isSelected) {
                                                    if (item == "Bought nonMedical Item?")
                                                      expCategory = EnumExpenseseCategoriesType.BoughtItem;
                                                    else
                                                      expCategory = EnumExpenseseCategoriesType.BoughtMedical;
                                                    _setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                          );

                                          r.add(Row(
                                            children: [
                                              Expanded(
                                                child: expCategory == EnumExpenseseCategoriesType.BoughtMedical
                                                    ? Container()
                                                    : CIA_MultiSelectChipWidget(
                                                        onChange: (item, isSelected) => _setState(() => newCategory = isSelected),
                                                        labels: [
                                                          CIA_MultiSelectChipWidgeModel(label: "New Category"),
                                                        ],
                                                      ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: expCategory == EnumExpenseseCategoriesType.BoughtMedical
                                                    ? CIA_MultiSelectChipWidget(
                                                        key: GlobalKey(),
                                                        singleSelect: true,
                                                        labels: [
                                                          CIA_MultiSelectChipWidgeModel(label: "Tacs", isSelected: medicalType == "Tacs"),
                                                          CIA_MultiSelectChipWidgeModel(label: "Membranes", isSelected: medicalType == "Membranes"),
                                                          CIA_MultiSelectChipWidgeModel(label: "Screws", isSelected: medicalType == "Screws"),
                                                          CIA_MultiSelectChipWidgeModel(label: "Implants", isSelected: medicalType == "Implants"),
                                                          CIA_MultiSelectChipWidgeModel(label: "Other", isSelected: medicalType == "Other"),
                                                        ],
                                                        onChange: (item, isSelected) {
                                                          if (isSelected)
                                                            _setState(() {
                                                              medicalType = item;
                                                            });
                                                        },
                                                      )
                                                    : newCategory
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
                                                            asyncItems: expCategory == EnumExpenseseCategoriesType.Service
                                                                ? SettingsAPI.GetNonMedicalNonStockExpensesCategories
                                                                : expCategory == EnumExpenseseCategoriesType.BoughtItem
                                                                    ? SettingsAPI.GetNonMedicalStockCategories
                                                                    : SettingsAPI.GetMedicalExpensesCategories,
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
                                                  onChange: (item, isSelected) => _setState(() => newPaymentMethod = isSelected),
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
                                                  onChange: (item, isSelected) => _setState(() => newSupplier = isSelected),
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

                                          if (expCategory == EnumExpenseseCategoriesType.BoughtMedical) {
                                            if (medicalType == "Tacs") {
                                              r.addAll(models
                                                  .map((model) => Column(
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CIA_DropDownSearch(
                                                                  label: "Tacs Company",
                                                                  asyncItems: () async {
                                                                    var res = await SettingsAPI.GetTacsCompanies();
                                                                    if (res.statusCode == 200)
                                                                      res.result = ((res.result as List<TacCompanyModel>)
                                                                          .map((e) => DropDownDTO(name: e.name, id: e.id))).toList();
                                                                    return res;
                                                                  },
                                                                  onSelect: (value) {
                                                                    model.tac = value;
                                                                    model.id = value.id;
                                                                  },
                                                                  selectedItem: model.tac,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: CIA_TextFormField(
                                                                  isNumber: true,
                                                                  onChange: (value) {
                                                                    if (value == null || value == "") value = "0";
                                                                    model.count = int.parse(value);
                                                                    _setState(() {});
                                                                  },
                                                                  label: "Count",
                                                                  controller: TextEditingController(text: (model.count ?? 0).toString()),
                                                                ),
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
                                                                    _setState(() {});
                                                                  },
                                                                  label: "Price",
                                                                  controller: TextEditingController(text: (model.price ?? 0).toString()),
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
                                                                    _setState(() {});
                                                                  },
                                                                  icon: Icon(Icons.add)),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    models.remove(model);
                                                                    _setState(() {});
                                                                  },
                                                                  icon: Icon(Icons.remove))
                                                            ],
                                                          ),
                                                        ],
                                                      ))
                                                  .toList());
                                            }
                                            else if (medicalType == "Membranes") {
                                              r.addAll(models
                                                  .map((model) => Column(
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CIA_DropDownSearch(
                                                                  label: "Membrane Company",
                                                                  asyncItems: SettingsAPI.GetMembraneCompanies,
                                                                  onSelect: (value) {
                                                                    model.membraneCompany = value;
                                                                    _setState(() {});
                                                                  },
                                                                  selectedItem: model.membraneCompany,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: CIA_DropDownSearch(
                                                                  label: "Membrane",
                                                                  asyncItems: model.membraneCompany == null
                                                                      ? null
                                                                      : () async {
                                                                          var res = await SettingsAPI.GetMembranes(model.membraneCompany!.id!);
                                                                          return res;
                                                                        },
                                                                  onSelect: (value) {
                                                                    model.id = value.id;
                                                                    model.membrane = value;
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: CIA_TextFormField(
                                                                  isNumber: true,
                                                                  onChange: (value) {
                                                                    if (value == null || value == "") value = "0";
                                                                    model.count = int.parse(value);
                                                                    _setState(() {});
                                                                  },
                                                                  label: "Count",
                                                                  controller: TextEditingController(text: (model.count ?? 0).toString()),
                                                                ),
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
                                                                    _setState(() {});
                                                                  },
                                                                  label: "Price",
                                                                  controller: TextEditingController(text: (model.price ?? 0).toString()),
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
                                                                    _setState(() {});
                                                                  },
                                                                  icon: Icon(Icons.add)),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    models.remove(model);
                                                                    _setState(() {});
                                                                  },
                                                                  icon: Icon(Icons.remove))
                                                            ],
                                                          ),
                                                        ],
                                                      ))
                                                  .toList());
                                            }
                                            else if (medicalType == "Implants") {
                                              r.addAll(models
                                                  .map((model) => Column(
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CIA_DropDownSearch(
                                                                  label: "Implant Company",
                                                                  asyncItems: SettingsAPI.GetImplantCompanies,
                                                                  onSelect: (value) {
                                                                    model.implantCompany = value;
                                                                    _setState(() {});
                                                                  },
                                                                  selectedItem: model.implantCompany,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: CIA_DropDownSearch(
                                                                  label: "Implant Line",
                                                                  asyncItems: model.implantCompany == null
                                                                      ? null
                                                                      : () async {
                                                                          var res = await SettingsAPI.GetImplantLines(model.implantCompany!.id!);
                                                                          return res;
                                                                        },
                                                                  onSelect: (value) {
                                                                    model.implantLine = value;
                                                                    _setState(() {});
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: CIA_DropDownSearch(
                                                                  label: "Implant",
                                                                  asyncItems: model.implantLine == null
                                                                      ? null
                                                                      : () async {
                                                                          var res = await SettingsAPI.GetImplants(model.implantLine!.id!);
                                                                          if (res.statusCode == 200) {
                                                                            res.result = ((res.result) as List<ImplantModel>)
                                                                                .map((e) => DropDownDTO(name: e.name, id: e.id))
                                                                                .toList();
                                                                          }
                                                                          return res;
                                                                        },
                                                                  onSelect: (value) {
                                                                    model.id = value.id;
                                                                    model.implant = value;
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: CIA_TextFormField(
                                                                  isNumber: true,
                                                                  onChange: (value) {
                                                                    if (value == null || value == "") value = "0";
                                                                    model.count = int.parse(value);
                                                                    _setState(() {});
                                                                  },
                                                                  label: "Count",
                                                                  controller: TextEditingController(text: (model.count ?? 0).toString()),
                                                                ),
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
                                                                    _setState(() {});
                                                                  },
                                                                  label: "Price",
                                                                  controller: TextEditingController(text: (model.price ?? 0).toString()),
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
                                                                    _setState(() {});
                                                                  },
                                                                  icon: Icon(Icons.add)),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    models.remove(model);
                                                                    _setState(() {});
                                                                  },
                                                                  icon: Icon(Icons.remove))
                                                            ],
                                                          ),
                                                        ],
                                                      ))
                                                  .toList());
                                            }
                                            else if (medicalType == "Screws") {
                                              models = [models.first];
                                              models.first.name = "Screws";

                                              StockAPI.GetStockByName("Screws").then((value) {
                                                if (value.statusCode == 200) models.first.id == ((value.result) as DropDownDTO).id;
                                              });
                                              r.add(SizedBox(height: 10));
                                              r.add(
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CIA_TextFormField(
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          if (value == null || value == "") value = "0";
                                                          models.first.count = int.parse(value);
                                                          _setState(() {});
                                                        },
                                                        label: "Screws Count",
                                                        controller: TextEditingController(text: (models.first.count ?? 0).toString()),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: CIA_TextFormField(
                                                        isNumber: true,
                                                        onChange: (value) {
                                                          if (value == null || value == "") value = "0";
                                                          models.first.price = int.parse(value);
                                                          total = 0;
                                                          models.forEach((element) {
                                                            total += element.price ?? 0;
                                                          });
                                                          _setState(() {});
                                                        },
                                                        label: "Price",
                                                        controller: TextEditingController(text: (models.first.price ?? 0).toString()),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                  ],
                                                ),
                                              );
                                            }
                                            else{
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
                                                            _setState(() {});
                                                          },
                                                          label: "Price",
                                                          controller: TextEditingController(text: (model.price ?? 0).toString()),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Visibility(
                                                        visible: expCategory != EnumExpenseseCategoriesType.Service,
                                                        child: Expanded(
                                                          child: CIA_TextFormField(
                                                            isNumber: true,
                                                            onChange: (value) {
                                                              if (value == null || value == "") value = "0";
                                                              model.count = int.parse(value);
                                                              _setState(() {});
                                                            },
                                                            label: "Count",
                                                            controller: TextEditingController(text: (model.count ?? 0).toString()),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: expCategory != EnumExpenseseCategoriesType.Service ? 10 : 0),
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
                                                            _setState(() {});
                                                          },
                                                          icon: Icon(Icons.add)),
                                                      IconButton(
                                                          onPressed: () {
                                                            models.remove(model);
                                                            _setState(() {});
                                                          },
                                                          icon: Icon(Icons.remove))
                                                    ],
                                                  )
                                                ],
                                              ))
                                                  .toList());
                                            }
                                          } else {
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
                                                                  _setState(() {});
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
                                                                  _setState(() {});
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
                                                                  _setState(() {});
                                                                },
                                                                icon: Icon(Icons.add)),
                                                            IconButton(
                                                                onPressed: () {
                                                                  models.remove(model);
                                                                  _setState(() {});
                                                                },
                                                                icon: Icon(Icons.remove))
                                                          ],
                                                        )
                                                      ],
                                                    ))
                                                .toList());
                                          }

                                          return r;
                                        }(),
                                      ),
                                    ),
                                  ),
                                  Text("Total: ${total.toString()}")
                                ],
                              );
                            },
                          );
                        }));
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
                        child: CIA_DateTimeTextFormField(
                      label: "Date From",
                      controller: TextEditingController(),
                      onChange: (value) => from = value,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DateTimeTextFormField(
                      label: "Date To",
                      controller: TextEditingController(),
                      onChange: (value) => to = value,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearch(
                      label: "Category",
                      asyncItems: () => SettingsAPI.GetExpensesCategories(),
                      onSelect: (value) => catId = value.id,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearch(
                      label: "Payment Methods",
                      asyncItems: () => SettingsAPI.GetPaymentMethods(),
                      onSelect: (value) => paymentMethodId = value.id,
                    ))
                  ],
                )),
                CIA_PrimaryButton(
                  label: "Filter",
                  onTab: () {
                    widget.e_dataSource.loadData(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId);
                  },
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
              loadFunction: () async => widget.e_dataSource.loadData(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId),
              onCellClick: (value) {
                /*selectedCategory =
                        CashFlowSummaryDataSource().models[value - 2].Category!;
                    _controller.jumpToPage(1);*/
              }),
        ),
      ],
    );
  }
}

class CashFlowSummarySharedPage extends StatefulWidget {
  CashFlowSummarySharedPage({
    Key? key,
  }) : super(key: key);
  CashFlowSummaryDataSource? eS_dataSource = CashFlowSummaryDataSource(type: CashFlowType.expenses);
  CashFlowSummaryDataSource? iS_dataSource = CashFlowSummaryDataSource(type: CashFlowType.income);
  CashFlowSummaryDataSource? diS_dataSource;

  static String routeName = "CashFlowSummary";
  static String routePath = "CashFlowSummary";
  static String routeCIAname = "CashFlowSummaryCIA";
  static String routeLABname = "CashFlowSummaryLAB";
  static String routeClinicName = "CashFlowSummaryClinic";

  @override
  State<CashFlowSummarySharedPage> createState() => _CashFlowSummarySharedPageState();
}

class _CashFlowSummarySharedPageState extends State<CashFlowSummarySharedPage> {
  int selectedPage = 0;
  bool weekSelected = false;
  bool monthSelected = true;
  bool yearSelected = false;
  bool lastMonthSelected = false;
  String selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                //_getXController.expensesSum.value = 0;
                                int total = 0;
                                widget.eS_dataSource!.models.forEach((element) {
                                  total += element.total ?? 0;
                                });
                                _getXController.expensesSum.value = total;
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

                        return res;
                      },
                      onCellClick: (value) {
                        try {
                          selectedCategory = widget.iS_dataSource!.models[value - 2].category!.name!;
                          //_controller.jumpToPage(1);
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
                              int total  = 0;
                              widget.iS_dataSource!.models.forEach((element) {
                                total+= element.total ?? 0;
                              });
                              _getXController.incomeSum.value = total;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormTextKeyWidget(text: "Net profit: "),
            Obx(() =>               FormTextValueWidget(text: "${_getXController.incomeSum.value-_getXController.expensesSum.value} EGP"),
            )            ],
        ),
        SizedBox(height:10),
        Center(
          child: Wrap(
            children: [
              CIA_PrimaryButton(
                  label: "Add Settlement",
                  onTab: () {
                    int newValue = _getXController.expensesSum.value-_getXController.incomeSum.value;
                    String filter = "This month";
                    CIA_ShowPopUp(
                      onSave: () async {
                        var res = await CashFlowAPI.AddSettlement(filter, newValue);
                        ShowSnackBar(context, isSuccess: res.statusCode == 200);
                        setState(() {});
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
                            controller: TextEditingController(text:"${_getXController.expensesSum.value-_getXController.incomeSum.value}"),
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
    );

    //todo: summary secondary page
    /*Column(
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
            ),*/
  }
}
