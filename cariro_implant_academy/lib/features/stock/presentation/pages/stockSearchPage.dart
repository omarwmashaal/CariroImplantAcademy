import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemParentsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsLinesUseCase.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getLabStockUseCase.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_Events.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';

class StockSearchPage extends StatefulWidget {
  StockSearchPage({
    Key? key,
  }) : super(key: key);

  static String routePath = "Stock";

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicStock";
      case Website.Lab:
        return "LabStock";
      default:
        return "CIAStock";
    }
  }

  @override
  State<StockSearchPage> createState() => _StockSearchPageState();
}

class _StockSearchPageState extends State<StockSearchPage> {
  int selectedPage = 0;
  String? search = null;
  BasicNameIdObjectEntity? parent;
  BasicNameIdObjectEntity? company;
  BasicNameIdObjectEntity? shade;
  String consumedFilter = "All";
  late StockDataGridSource stock_dataSource;
  late StockBloc bloc;

  void performSearch() {
    bloc.add(StockBloc_GetStockEvent(
        search: search,
        getLabStockParams: GetLabStockParams(
          companyId: company?.id,
          parentId: parent?.id,
          shadeId: shade?.id,
          search: search,
          consumed: consumedFilter == "All"
              ? null
              : consumedFilter == "Consumed"
                  ? true
                  : false,
        )));
  }

  @override
  Widget build(BuildContext context) {
    performSearch();
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
            performSearch();
          },
        ),
        SizedBox(height: 10),
        Visibility(
          visible: siteController.getSite() == Website.Lab,
          child: StatefulBuilder(builder: (context, _setState) {
            return Row(
              children: [
                Expanded(
                  child: CIA_DropDownSearchBasicIdName(
                    label: "Type",
                    asyncUseCaseDynamic: sl<GetLabItemParentsUseCase>(),
                    selectedItem: parent,
                    onSelect: (value) {
                      shade = null;
                      company = null;
                      parent = value;
                      _setState(() => null);
                      performSearch();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CIA_DropDownSearchBasicIdName(
                    label: "Company",
                    asyncUseCase: sl<GetLabItemsCompaniesUseCase>(),
                    selectedItem: company,
                    searchParams: parent?.id ?? 0,
                    onSelect: (value) {
                      shade = null;
                      company = value;
                      _setState(() => null);
                      performSearch();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CIA_DropDownSearchBasicIdName(
                    label: "Shade",
                    asyncUseCase: sl<GetLabItemsLinesUseCase>(),
                    selectedItem: shade,
                    searchParams: GetLabItemsLinesParams(
                      companyId: company?.id,
                      parentId: parent?.id,
                    ),
                    onSelect: (value) {
                      shade = value;
                      _setState(() => null);
                      performSearch();
                    },
                  ),
                ),
                SizedBox(width: 10),
                CIA_MultiSelectChipWidget(
                  singleSelect: true,
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "All", isSelected: consumedFilter == "All"),
                    CIA_MultiSelectChipWidgeModel(label: "Consumed", isSelected: consumedFilter == "Consumed"),
                    CIA_MultiSelectChipWidgeModel(label: "Not Consumed", isSelected: consumedFilter == "Not Consumed"),
                  ],
                  onChange: (item, isSelected) {
                    consumedFilter = item;
                    _setState(() => null);
                    performSearch();
                  },
                ),
                IconButton(
                    onPressed: () {
                      parent = null;
                      company = null;
                      shade = null;
                      consumedFilter = "All";
                      _setState(() => null);
                      performSearch();
                    },
                    icon: Icon(Icons.clear))
              ],
            );
          }),
        ),
        SizedBox(height: 10),
        Expanded(
          child: BlocConsumer<StockBloc, StockBloc_States>(
            buildWhen: (previous, current) => current is StockBloc_LoadingErrorState || current is StockBloc_LoadedStockSuccessfullyState,
            builder: (context, state) {
              if (state is StockBloc_LoadingState)
                return LoadingWidget();
              else if (state is StockBloc_LoadingErrorState)
                return BigErrorPageWidget(message: state.message);
              else
                return TableWidget(dataSource: stock_dataSource);
            },
            listener: (context, state) {
              if (state is StockBloc_LoadedStockSuccessfullyState) stock_dataSource.updateData(state.data);
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
    bloc = BlocProvider.of<StockBloc>(context);

    stock_dataSource = StockDataGridSource(context: context, bloc: bloc);
    //todo:fix this
    //siteController.setAppBarWidget(tabs: ["Stock", "Logs"]);
  }
}
