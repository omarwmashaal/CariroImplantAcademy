import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/API/StockAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Models/StockModel.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Title.dart';

class StockListSharedPage extends StatefulWidget {
  StockListSharedPage({
    Key? key,
  }) : super(key: key);

  static String routeName = "Stock";
  StockDataSource stock_dataSource = StockDataSource();

  @override
  State<StockListSharedPage> createState() => _StockListSharedPageState();
}

class _StockListSharedPageState extends State<StockListSharedPage> {
  int selectedPage = 0;
  String? search = null;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TitleWidget(
              title: "Stock",
              showBackButton: false,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CIA_PrimaryButton(
                    onTab: () {},
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
                          await widget.stock_dataSource.loadData();
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
            )
          ],
        ),
        CIA_TextField(
          label: "Search",
          icon: Icons.search,
          onChange: (value) {
            search = value;
            widget.stock_dataSource.loadData(search: value);
          },
        ),
        Expanded(
          child: CIA_Table(columnNames: widget.stock_dataSource.columns, dataSource: widget.stock_dataSource,loadFunction: ()async{
            return widget.stock_dataSource.loadData(search:search);
          },),
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
    //todo:fix this
    //siteController.setAppBarWidget(tabs: ["Stock", "Logs"]);
  }
}

class StockLogsSharedPage extends StatefulWidget {
   StockLogsSharedPage({Key? key}) : super(key: key);
  StockLogsDataSource logs_dataSource = StockLogsDataSource();
   static String routeName = "StockLogs";

   @override
  State<StockLogsSharedPage> createState() => _StockLogsSharedPageState();
}

class _StockLogsSharedPageState extends State<StockLogsSharedPage> {
  String? search;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          title: "Logs",
          showBackButton: false,
        ),
        CIA_TextField(
          label: "Search",
          icon: Icons.search,
          onChange: (value) {
            search = value;
            widget.logs_dataSource.loadData(search: value);
          },
        ),
        Expanded(
          child: CIA_Table(columnNames: widget.logs_dataSource.columns, dataSource: widget.logs_dataSource,loadFunction: ()async{
            return widget.logs_dataSource.loadData(search:search);
          },),
        ),


      ],
    );
  }
}
