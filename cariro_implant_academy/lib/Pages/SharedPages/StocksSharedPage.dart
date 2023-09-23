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


class StockLogsSharedPages extends StatefulWidget {
   StockLogsSharedPages({Key? key}) : super(key: key);
  StockLogsDataSource logs_dataSource = StockLogsDataSource();
   static String routeName = "StockLogs";
   static String routePath = "StockLogs";
   static String routeCIAname = "CIAStockLogs";
   static String routeLABname = "LabStockLogs";
   static String routeClinicName = "ClinicStockLogs";

   @override
  State<StockLogsSharedPages> createState() => _StockLogsSharedPageState();
}

class _StockLogsSharedPageState extends State<StockLogsSharedPages> {
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
