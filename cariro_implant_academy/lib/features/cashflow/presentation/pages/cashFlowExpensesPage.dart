import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/paymentLogTableWidget.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/receiptTableWidget.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getExpensesCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getIncomeCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMembraneCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getMembranesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getNonMedicalNonStockExpensesCategories.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getPaymentMethodsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getSuppliersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTacsUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/listIncomeUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_Events.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_States.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/widgets/addExpensesWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Models/CashFlowSummaryModel.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/features/settings/domain/useCases/getMedicalExpensesCategoriesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getNonMedicalStockCategories.dart';
import '../../../../core/injection_contianer.dart';

class CashFlowExpensesPage extends StatefulWidget {
  CashFlowExpensesPage({
    Key? key,
  }) : super(key: key);
  CashFlowDataGridSource e_dataSource = CashFlowDataGridSource(type: CashFlowType.expenses);

  static String routePath = "CashFlowExpenses";

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "CashFlowExpensesClinic";
      case Website.Lab:
        return "CashFlowExpensesLAB";
      default:
        return "CashFlowExpensesCIA";
    }
  }

  @override
  State<CashFlowExpensesPage> createState() => _CashFlowExpensesPageState();
}

class _CashFlowExpensesPageState extends State<CashFlowExpensesPage> {
  DateTime? from;
  DateTime? to;
  int? catId;
  int? paymentMethodId;
  late CashFlowBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CashFlowBloc>(context);
    loadData();
  }

  void loadData() {
    bloc.add(CashFlowBloc_ListExpensesEvent(
        params: ListCashFlowParams(
      from: from,
      to: to,
      paymentMethodId: paymentMethodId,
      catId: catId,
    )));
  }

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
                  onTab: () => ShowAddExpenesesPopUpWidget(
                    context: context,
                    cashFlowBloc: bloc,
                  ),
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
                        child: CIA_DropDownSearchBasicIdName<Website>(
                      onClear: () {
                        catId = null;
                      },
                      label: "Category",
                      asyncUseCase: sl<GetExpensesCategoriesUseCase>(),
                      searchParams: siteController.getSite(),
                      onSelect: (value) => catId = value.id,
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CIA_DropDownSearchBasicIdName(
                      onClear: () {
                        paymentMethodId = null;
                      },
                      asyncUseCase: sl<GetPaymentMethodsUseCase>(),
                      label: "Payment Methods",
                      onSelect: (value) => paymentMethodId = value.id,
                    ))
                  ],
                )),
                CIA_PrimaryButton(
                  label: "Filter",
                  onTab: () {
                    loadData();
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
          child: BlocConsumer<CashFlowBloc, CashFlowBloc_States>(
            listener: (context, state) {
              if (state is CashFlowBloC_ProcessingCashFlowSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true);
                dialogHelper.dismissSingle(context);
                loadData();
              } else if (state is CashFlowBloC_ProcessingCashFlowErrorState)
                ShowSnackBar(context, isSuccess: false);
              else if (state is CashFlowBloC_LoadedCashFlowSuccessfullyState) widget.e_dataSource.updateData(state.data);
            },
            builder: (context, state) {
              return TableWidget(
                  dataSource: widget.e_dataSource,
                  onCellClick: (value) {
                    /*selectedCategory =
                        CashFlowSummaryDataSource().models[value - 2].Category!;
                    _controller.jumpToPage(1);*/
                  });
            },
          ),
        ),
      ],
    );
  }
}
