import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Models/StockModel.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/Title.dart';

class StockSharedPage extends StatefulWidget {
  StockSharedPage({
    Key? key,
    required this.stock_dataSource,
    required this.logs_dataSource,
    this.onChange = null,
  }) : super(key: key);

  DataGridSource stock_dataSource;
  DataGridSource logs_dataSource;
  Function? onChange;

  @override
  State<StockSharedPage> createState() => _StockSharedPageState();
}

class _StockSharedPageState extends State<StockSharedPage> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: tabsController,
      children: [
        Column(
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
                        onTab: () {},
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
        ),
        Column(
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
              dataSource: widget.logs_dataSource,
              columnNames: StockModel.logsColumns,
              onCellTab: (value) {
                if (widget.onChange != null) widget.onChange!(value);
              },
            ),
          ],
        )
      ],
    );

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
        ]);
  }

  @override
  void initState() {
    siteController.setAppBarWidget(tabs: ["Stock", "Logs"]);
  }
}
