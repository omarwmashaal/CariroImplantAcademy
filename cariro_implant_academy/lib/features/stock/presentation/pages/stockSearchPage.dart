import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_Events.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Title.dart';

class StockSearchPage extends StatefulWidget {
  StockSearchPage({
    Key? key,
  }) : super(key: key);

  static String routePath = "Stock";
  static String routeName = "Stock";
  static String routeCIAname = "CIAStock";
  static String routeLABname = "LabStock";
  static String routeClinicName = "ClinicStock";

  @override
  State<StockSearchPage> createState() => _StockSearchPageState();
}

class _StockSearchPageState extends State<StockSearchPage> {
  int selectedPage = 0;
  String? search = null;
  late StockDataGridSource stock_dataSource;
  late StockBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<StockBloc>(context);
    bloc.add(StockBloc_GetStockEvent(search: search));
    return Column(
      children: [
        Row(
          children: [
            TitleWidget(
              title: "Stock",
              showBackButton: false,
            ),
            /*  Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CIA_PrimaryButton(
                    onTab: () {

                    },
                    label: "Remove Item",
                    isLong: true,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  CIA_PrimaryButton(
                    onTab: () {
                      bool newItem = false;
                      bool newCategory = false;
                      StockModel newStock = StockModel();
                      CIA_ShowPopUp(
                        context: context,
                        onSave: () async {
                          var res = await StockAPI.AddItem(newStock);
                          if (res.statusCode == 200)
                            ShowSnackBar(context,isSuccess: true, title: "Success", message: "Added Succesffuly");
                          else
                            ShowSnackBar(context,isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                          await stock_dataSource.loadData();
                        },
                        child: StatefulBuilder(builder: (context, setState) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CIA_MultiSelectChipWidget(
                                        onChange: (item, isSelected) {
                                          newItem = isSelected;

                                          setState(() {});
                                        },
                                        labels: [CIA_MultiSelectChipWidgeModel(label: "New Item")]),
                                  ),
                                  newItem
                                      ? Expanded(
                                    flex: 2,
                                    child: CIA_TextFormField(
                                      label: "Name",
                                      controller: TextEditingController(text:newStock.name??""),
                                      onChange: (value) => newStock.name = value,
                                    ),
                                  )
                                      : Expanded(
                                    flex: 2,
                                    child: CIA_DropDownSearch(
                                      label: "Name",
                                      asyncItems: () async {
                                        var res = await StockAPI.GetAllStock();
                                        if (res.statusCode == 200) {
                                          res.result = (res.result as List<StockModel>).map((e) => DropDownDTO(name: e.name, id: e.id)).toList();
                                          return res;
                                        }
                                        return API_Response();
                                      },
                                      onSelect: (value) async{
                                        newStock.name = value.name;
                                        var res = await StockAPI.GetStockById(value.id!);
                                        if(res.statusCode == 200)
                                        {
                                          newStock.category = (res.result as StockModel).category;
                                        }
                                        setState((){});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CIA_MultiSelectChipWidget(
                                        onChange: (item, isSelected) {
                                          newCategory = isSelected;
                                          setState(() {});
                                        },
                                        labels: [CIA_MultiSelectChipWidgeModel(label: "New Category")]),
                                  ),
                                  newCategory
                                      ? Expanded(
                                    flex: 2,
                                    child: CIA_TextFormField(
                                      label: "Category",
                                      controller: TextEditingController(text: (newStock.category ?? DropDownDTO()).name),
                                      onChange: (value) => newStock.category = DropDownDTO(name: value),
                                    ),
                                  )
                                      : Expanded(
                                    flex: 2,
                                    child: CIA_DropDownSearch(
                                      label: "Category",
                                      selectedItem: newStock.category,
                                      asyncItems: SettingsAPI.GetStockCategories,
                                      onSelect: (value) => newStock.category = value,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              CIA_TextFormField(
                                label: "Count",
                                isNumber: true,
                                onChange: (value) => newStock.count = int.parse(value),
                                controller: TextEditingController(
                                  text: (newStock.count ?? 0).toString(),
                                ),
                              ),
                            ],
                          );
                        }),
                      );
                    },
                    label: "Add Item",
                    isLong: true,
                    color: Colors.green,
                  ),
                  SizedBox(width: 30),
                ],
              ),
            )*/
          ],
        ),
        CIA_TextField(
          label: "Search",
          icon: Icons.search,
          onChange: (value) {
            search = value;
            bloc.add(StockBloc_GetStockEvent(search: search));
          },
        ),
        Expanded(
          child: BlocConsumer<StockBloc, StockBloc_States>(
            builder: (context, state) {
              if (state is StockBloc_LoadingState)
                return LoadingWidget();
              else if (state is StockBloc_LoadingErrorState)
                return BigErrorPageWidget(message: state.message);
              else
                return TableWidget(dataSource: stock_dataSource);
            },
            listener: (context, state) {
              if (state is StockBloc_LoadedStockSuccessfullyState)
                stock_dataSource.updateData(state.data);
            },
          ),
        ),
      ],
    );
/*
    TabsLayout(
        onChange: (value) => setState(() => {selectedPage = value}),
        sideWidget: selectedPage == 0
            ? Row(
                children: [
                  CIA_PrimaryButton(
                    onTab: () {},
                    label: "Remove Item",
                    isLong: true,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  CIA_PrimaryButton(
                    onTab: () {},
                    label: "Add Item",
                    isLong: true,
                    color: Colors.green,
                  ),
                  SizedBox(width: 30),
                ],
              )
            : SizedBox(),
        tabs: const [
          "Current Stock",
          "Logs"
        ],
        pages: [
          Expanded(
              flex: 10,
              child: Column(
                children: [
                  Obx(
                    () => TitleWidget(
                      title: siteController.title.value,
                      showBackButton: false,
                    ),
                  ),
                  SearchLayout(
                    radioButtons: [
                      "ID",
                      "Name",
                    ],
                    dataSource: widget.stock_dataSource,
                    columnNames: StockModel.columns,
                    onCellTab: (value) {
                      if (widget.onChange != null) widget.onChange!(value);
                    },
                  ),
                ],
              )),
          Expanded(
              flex: 10,
              child: SearchLayout(
                radioButtons: [
                  "ID",
                  "Name",
                ],
                dataSource: widget.logs_dataSource,
                columnNames: StockModel.logsColumns,
                onCellTab: (value) {
                  if (widget.onChange != null) widget.onChange!(value);
                },
              )),
        ]);*/
  }

  @override
  void initState() {
    stock_dataSource = StockDataGridSource(context: context);
    //todo:fix this
    //siteController.setAppBarWidget(tabs: ["Stock", "Logs"]);
  }
}
