import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getStockLogUseCase.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_Events.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Title.dart';

class StockLogsSearchPage extends StatefulWidget {
  StockLogsSearchPage({
    Key? key,
  }) : super(key: key);

  static String routeName = "StockLogs";
   static String routeNameClinic = "ClinicStockLogs";
  static String routePath = "StockLogs";
  static String routeCIAname = "CIAStockLogs";
  static String routeLABname = "LabStockLogs";
  static String routeClinicName = "ClinicStockLogs";

  @override
  State<StockLogsSearchPage> createState() => _StockLogsSearchPageState();
}

class _StockLogsSearchPageState extends State<StockLogsSearchPage> {
  int selectedPage = 0;
  String? search = null;
  DateTime? from;
  DateTime? to;
  int? categoryId;
  int? operatorId;
  String? status;
  late StockLogsDataGridSource stockLog_dataSource;
  late StockBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<StockBloc>(context);
    reload();

    return Column(
      children: [
        Row(
          children: [
            TitleWidget(
              title: "Stock Logs",
              showBackButton: false,
            ),
          ],
        ),
        CIA_TextField(
          label: "Search",
          icon: Icons.search,
          onChange: (value) {
            search = value;
            reload();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: CIA_DateTimeTextFormField(
              label: "From",
              controller: TextEditingController(text: from == null ? "" : DateFormat("dd-MM-yyyy").format(from!)),
              onChange: (value) {
                from = value;
                reload();
              },
            )),
            IconButton(
                onPressed: () {
                  from = null;
                  reload();
                },
                icon: Icon(Icons.remove)),
            SizedBox(width: 10),
            Expanded(
                child: CIA_DateTimeTextFormField(
              label: "To",
              controller: TextEditingController(text: to == null ? "" : DateFormat("dd-MM-yyyy").format(to!)),
              onChange: (value) {
                to = value;
                reload();
              },
            )),
            IconButton(
                onPressed: () {
                  to = null;
                  reload();
                },
                icon: Icon(Icons.remove)),
            SizedBox(width: 10),
            Expanded(
              child: CIA_DropDownSearchBasicIdName(
                label: "Status",
                onSelect: (value) {
                  if (value.name == "All")
                    status = null;
                  else
                    status = value.name!.toLowerCase();
                  reload();
                },
                items: [
                  BasicNameIdObjectEntity(name: "All"),
                  BasicNameIdObjectEntity(name: "Consumed"),
                  BasicNameIdObjectEntity(name: "Added"),
                  BasicNameIdObjectEntity(name: "Removed"),
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: BlocConsumer<StockBloc, StockBloc_States>(
            buildWhen: (previous, current) => current is StockBloc_LoadingErrorState || current is StockBloc_LoadedStockLogSuccessfullyState,
            builder: (context, state) {
              if (state is StockBloc_LoadingState)
                return LoadingWidget();
              else if (state is StockBloc_LoadingErrorState)
                return BigErrorPageWidget(message: state.message);
              else
                return TableWidget(dataSource: stockLog_dataSource);
            },
            listener: (context, state) {
              if (state is StockBloc_LoadedStockLogSuccessfullyState) stockLog_dataSource.updateData(state.data);
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

  reload() {
    bloc.add(StockBloc_GetStockLogEvent(
      params: GetStockLogParams(
        search: search,
        from: from,
        to: to,
        status: status,
        operatorId: operatorId,
        categoryId: categoryId,
      ),
    ));
  }

  @override
  void initState() {
    stockLog_dataSource = StockLogsDataGridSource();
    //todo:fix this
    //siteController.setAppBarWidget(tabs: ["Stock", "Logs"]);
  }
}
