import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/paymentLogTableWidget.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/receiptTableWidget.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getIncomeCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getPaymentMethodsUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/listIncomeUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_Events.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Models/CashFlowSummaryModel.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/injection_contianer.dart';

class CashFlowIncomePage extends StatefulWidget {
  CashFlowIncomePage({
    Key? key,
  }) : super(key: key);
  CashFlowDataGridSource datasource = CashFlowDataGridSource(type: CashFlowType.income);
  Function(CashFlowEntity cashFlowData)? onIncomeRowClick;
  static String routePath = "CashFlowIncome";
  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "CashFlowIncomeClinic";
      case Website.Lab:
        return "CashFlowIncomeLAB";
      default:
        return "CashFlowIncomeCIA";
    }
  }

  @override
  State<CashFlowIncomePage> createState() => _CashFlowIncomePageState();
}

class _CashFlowIncomePageState extends State<CashFlowIncomePage> {
  DateTime? from;
  DateTime? to;
  int? catId;
  int? paymentMethodId;
  late CashFlowBloc bloc;

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
                      controller: TextEditingController(text: from == null ? "" : DateFormat("dd-MM-yyyy").format(from!)),
                      onChange: (value) => from = value,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DateTimeTextFormField(
                      label: "Date To",
                      controller: TextEditingController(text: to == null ? "" : DateFormat("dd-MM-yyyy").format(to!)),
                      onChange: (value) => to = value,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearchBasicIdName<Website>(
                      label: "Category",
                      asyncUseCase: sl<GetIncomeCategoriesUseCase>(),
                      searchParams: siteController.getSite(),
                      onSelect: (value) => catId = value.id,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                      label: "Payment Methods",
                      asyncUseCase: sl<GetPaymentMethodsUseCase>(),
                      onSelect: (value) => paymentMethodId = value.id,
                    ))
                  ],
                )),
                CIA_PrimaryButton(
                  label: "Filter",
                  onTab: () => loadData(),
                  isLong: true,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          flex: 5,
          child: BlocConsumer<CashFlowBloc, CashFlowBloc_States>(
              listener: (context, state) {
                if (state is CashFlowBloC_LoadingCashFlowState || state is CashFlowBloC_ProcessingCashFlowState)
                  CustomLoader.show(context);
                else
                  CustomLoader.hide();
                if (state is CashFlowBloC_LoadingCashFlowErrorState || state is CashFlowBloC_ProcessingCashFlowErrorState)
                  ShowSnackBar(context, isSuccess: false);
                else if (state is CashFlowBloC_LoadedCashFlowSuccessfullyState) widget.datasource.updateData(state.data);
              },
              buildWhen: (previous, current) =>
                  current is CashFlowBloC_LoadingCashFlowErrorState || current is CashFlowBloC_LoadedCashFlowSuccessfullyState,
              builder: (context, state) {
                if (state is CashFlowBloC_LoadingCashFlowErrorState)
                  return BigErrorPageWidget(message: state.message);
                else if (state is CashFlowBloC_LoadedCashFlowSuccessfullyState) widget.datasource.updateData(state.data);
                return TableWidget(
                    dataSource: widget.datasource,
                    onCellClick: (value) async {
                      if (sl<SharedPreferences>().getInt("Website") == Website.Lab.index) {
                        var selected = widget.datasource.models.firstWhere((element) => element.id == value);
                        PaymentLogTableWidget(
                          receiptId: selected.receiptID!,
                          context: context,
                          patientId: selected.patientId!,
                        )();
                        //          context.goNamed(CIA_Router.routeConst_LabView, pathParameters: {"id": widget.datasource.models[value - 1].labRequestId.toString()});
                      } else {
                        //  PaymentLogDataSrouce dataSource = PaymentLogDataSrouce();
                        // var recRes = await PatientAPI.GetReceiptById(widget.datasource.models[value - 1]!.receiptID!);
                        //  ReceiptModel receipt = ReceiptModel();
                        // if (recRes.statusCode == 200) receipt = recRes.result as ReceiptModel;
                        var selected = widget.datasource.models.firstWhere((element) => element.id == value);
                        PaymentLogTableWidget(
                          receiptId: selected.receiptID!,
                          context: context,
                          patientId: selected.patientId!,
                        )();
                      }
                    });
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

  void loadData() {
    bloc.add(CashFlowBloc_ListIncomeEvent(
        params: ListCashFlowParams(
      catId: catId,
      paymentMethodId: paymentMethodId,
      to: to,
      from: from,
    )));
  }

  @override
  void initState() {
    bloc = BlocProvider.of<CashFlowBloc>(context);

    loadData();
  }
}
