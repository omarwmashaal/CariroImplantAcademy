import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_Events.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/addOrRemoveMyPatientsBloc_states.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Models/CashFlowSummaryModel.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../core/constants/enums/enums.dart';
import '../bloc/cashFlowBloc.dart';

class CashFlowSummaryPage extends StatefulWidget {
  CashFlowSummaryPage({
    Key? key,
  }) : super(key: key);
  CashFlowSummaryDataGridSource eS_dataSource = CashFlowSummaryDataGridSource();
  CashFlowSummaryDataGridSource iS_dataSource = CashFlowSummaryDataGridSource();
  CashFlowSummaryDataGridSource? diS_dataSource;

  static String routeName = "CashFlowSummary";
   static String routeNameClinic = "ClinicCashFlowSummary";
  static String routePath = "CashFlowSummary";
  static String routeCIAname = "CashFlowSummaryCIA";
  static String routeLABname = "CashFlowSummaryLAB";
  static String routeClinicName = "CashFlowSummaryClinic";

  @override
  State<CashFlowSummaryPage> createState() => _CashFlowSummaryPageState();
}

class _CashFlowSummaryPageState extends State<CashFlowSummaryPage> {
  int selectedPage = 0;
  String selectedCategory = "";
  late CashFlowBloc bloc;
  EnumSummaryFilter filter = EnumSummaryFilter.ThisMonth;
  int incomeTotal = 0;
  int expensesTotal = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<CashFlowBloc>(context);
    bloc.add(CashFlowBloc_GetSummaryEvent(filter: filter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CashFlowBloc, CashFlowBloc_States>(
      listener: (context, state) {
        if (state is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState) {
          widget.eS_dataSource.updateData(state.data.expenses ?? []);
          widget.iS_dataSource.updateData(state.data.income ?? []);
        } else if (state is CashFlowBloC_ProcessingCashFlowSuccessfullyState) {
          dialogHelper.dismissSingle(context);
          bloc.add(CashFlowBloc_GetSummaryEvent(filter: filter));
        }
        if (state is CashFlowBloC_ProcessingCashFlowState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              filter == EnumSummaryFilter.ThisWeek
                  ? CIA_PrimaryButton(label: "This Week", isLong: true, onTab: () {})
                  : CIA_SecondaryButton(
                      label: "This Week",
                      onTab: () {
                        setState(() {
                          filter = EnumSummaryFilter.ThisWeek;
                          bloc.add(CashFlowBloc_GetSummaryEvent(filter: filter));
                        });
                      }),
              SizedBox(width: 10),
              filter == EnumSummaryFilter.ThisMonth
                  ? CIA_PrimaryButton(label: "This Month", isLong: true, onTab: () {})
                  : CIA_SecondaryButton(
                      label: "This Month",
                      onTab: () {
                        setState(() {
                          filter = EnumSummaryFilter.ThisMonth;
                          bloc.add(CashFlowBloc_GetSummaryEvent(filter: filter));
                        });
                      }),
              SizedBox(width: 10),
              filter == EnumSummaryFilter.LastMonth
                  ? CIA_PrimaryButton(label: "Last Month", isLong: true, onTab: () {})
                  : CIA_SecondaryButton(
                      label: "Last Month",
                      onTab: () {
                        setState(() {
                          filter = EnumSummaryFilter.LastMonth;
                          bloc.add(CashFlowBloc_GetSummaryEvent(filter: filter));
                        });
                      }),
              SizedBox(width: 10),
              filter == EnumSummaryFilter.ThisYear
                  ? CIA_PrimaryButton(label: "This Year", isLong: true, onTab: () {})
                  : CIA_SecondaryButton(
                      label: "This Year",
                      onTab: () {
                        setState(() {
                          filter = EnumSummaryFilter.ThisYear;
                          bloc.add(CashFlowBloc_GetSummaryEvent(filter: filter));
                        });
                      }),
            ],
          ),
          SizedBox(height: 10),
          BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
            buildWhen: (previous, current) => current is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState,
            builder: (context, state) {
              DateTime? from;
              DateTime? to;
              if (state is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState) {
                from = state.data.from;
                to = state.data.to;
              }
              return Row(
                children: [
                  FormTextValueWidget(text: "from: ${from == null ? "" : DateFormat("dd-MM-yyyy").format(from!)}"),
                  SizedBox(
                    width: 10,
                  ),
                  FormTextValueWidget(text: "to: ${to == null ? "" : DateFormat("dd-MM-yyyy").format(to!)}"),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              );
            },
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TitleWidget(title: "Expenses Summary"),
                      BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
                        builder: (context, state) {
                          if (state is CashFlowBloC_LoadingCashFlowState) return LoadingWidget();
                          return TableWidget(
                              showGridLines: true,
                              title: "Expenses Summary",
                              dataSource: widget.eS_dataSource as CashFlowSummaryDataGridSource,
                              onCellClick: (value) {
                                /*  selectedCategory = CashFlowSummaryDataSource()
                                          .models[value - 2]
                                          .Category!;
                                      _controller.jumpToPage(1);*/
                              });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          FormTextKeyWidget(text: "Total: EGP "),
                          BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
                            buildWhen: (previous, current) => current is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState,
                            builder: (context, state) {
                              int total = 0;
                              if (state is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState) {
                                (state.data.expenses ?? []).forEach((element) {
                                  total += element.total ?? 0;
                                });
                                expensesTotal = total;
                                bloc.emit(CashFlowBloC_UpdateSummaryNetProfitState(
                                  expensesTotal: expensesTotal,
                                  incomeTotal: incomeTotal,
                                ));
                              }
                              return FormTextValueWidget(
                                text: total.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                    child: Column(
                  children: [
                    TitleWidget(title: "Income Summary"),
                    BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
                      builder: (context, state) {
                        if (state is CashFlowBloC_LoadingCashFlowState) return LoadingWidget();
                        return TableWidget(
                            showGridLines: true,
                            title: "Income Summary",
                            dataSource: widget.iS_dataSource,
                            onCellClick: (value) {
                              try {
                                selectedCategory = widget.iS_dataSource!.models[value - 2].category!.name!;
                                //_controller.jumpToPage(1);
                              } catch (e) {}
                            });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        FormTextKeyWidget(text: "Total: EGP "),
                        BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
                          buildWhen: (previous, current) => current is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState,
                          builder: (context, state) {
                            int total = 0;
                            if (state is CashFlowBloC_LoadedCashFlowSummarySuccessfullyState) {
                              (state.data.income ?? []).forEach((element) {
                                total += element.total ?? 0;
                              });
                              incomeTotal = total;
                              bloc.emit(CashFlowBloC_UpdateSummaryNetProfitState(
                                expensesTotal: expensesTotal,
                                incomeTotal: incomeTotal,
                              ));
                            }
                            return FormTextValueWidget(
                              text: total.toString(),
                            );
                          },
                        ),
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
              BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
                buildWhen: (previous, current) => current is CashFlowBloC_UpdateSummaryNetProfitState,
                builder: (context, state) {
                  return FormTextValueWidget(
                    text: "EGP ${incomeTotal - expensesTotal}",
                  );
                },
              )
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Wrap(
              children: [
                CIA_PrimaryButton(
                    label: "Add Settlement",
                    onTab: () {
                      String _filter = "This month";
                      //                  int newValue = _getXController.expensesSum.value - _getXController.incomeSum.value;
                      int newValue = expensesTotal - incomeTotal;
                      CIA_ShowPopUp(
                        onSave: () {
                          bloc.add(CashFlowBloc_AddSettlementEvent(filter: _filter, value: newValue));
                          return false;
                        },
                        context: context,
                        child: Column(
                          children: [
                            CIA_MultiSelectChipWidget(
                                singleSelect: true,
                                onChange: (item, isSelected) {
                                  if (isSelected) {
                                    _filter = item;
                                  }
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "This month", isSelected: true),
                                  CIA_MultiSelectChipWidgeModel(label: "Last month"),
                                ]),
                            CIA_TextFormField(
                              isNumber: true,
                              label: "Value",
                              controller: TextEditingController(text: "$newValue"),
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
