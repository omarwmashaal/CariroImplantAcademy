import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
late Function GlobalLoadFunction;

class CIA_Table extends StatefulWidget {
  /// Creates the home page.
  CIA_Table(
      {Key? key,
      this.loadFunction,
      //required this.models,
      required this.columnNames,
      this.onCellClick,
      this.isTreatment = false,
      required this.dataSource,
      this.title,
      this.showSum = false,
      this.allowSorting = false,
      this.showGridLines = false})
      : super(key: key);

  List<String> columnNames;
  DataGridSource dataSource;
  Function? loadFunction;
  Function(int index)? onCellClick;
  bool? isTreatment;
  String? title;
  bool showGridLines;
  bool showSum;
  bool allowSorting;

  // List<Object> models;
  @override
  _CIA_TableState createState() => _CIA_TableState();
}

class _CIA_TableState extends State<CIA_Table> {
  Future<int> wait() async {
    await Future.delayed(Duration(milliseconds: 500));
    return 0;
  }

  @override
  void initState() {
    if (widget.loadFunction != null) GlobalLoadFunction = widget.loadFunction!;
    super.initState();
    // employees = getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.loadFunction != null ? widget.loadFunction!() : wait(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {


        if (snapshot.hasData || snapshot.connectionState == ConnectionState.done) {

          return SfDataGrid(
            isScrollbarAlwaysShown: true,
            horizontalScrollController: ScrollController(),
            horizontalScrollPhysics: ScrollPhysics(),

            allowSorting: widget.allowSorting,
            allowTriStateSorting: widget.allowSorting,
            allowMultiColumnSorting: widget.allowSorting,
            highlightRowOnHover: true,
            gridLinesVisibility: widget.showGridLines ? GridLinesVisibility.both : GridLinesVisibility.horizontal,
            headerGridLinesVisibility: widget.showGridLines ? GridLinesVisibility.both : GridLinesVisibility.horizontal,

            tableSummaryRows: widget.showSum
                ? [
                    GridTableSummaryRow(
                        showSummaryInRow: false,
                        title: 'Amount',
                        columns: <GridSummaryColumn>[
                          GridSummaryColumn(name: 'Amount', columnName: 'Amount', summaryType: GridSummaryType.sum),
                        ],
                        position: GridTableSummaryRowPosition.bottom),
                  ]
                : [],
            stackedHeaderRows: widget.title != null
                ? [
                    StackedHeaderRow(cells: [
                      StackedHeaderCell(
                          columnNames: widget.columnNames,
                          child: Container(alignment: Alignment.center, color: Color_Accent, child: Text(widget.title as String)))
                    ])
                  ]
                : [],
            source: widget.dataSource,
            /*loadMoreViewBuilder: (BuildContext context, LoadMoreRows loadMoreRows) {
          Future loadRows() async {
           // await loadMoreRows();
            return Future.value('Completed');
          }

          return FutureBuilder(
            initialData: 'loading',
            future: loadRows(),
            builder: (context, snapShot) {
              if (snapShot.data == 'loading') {
                return Container(
                    height: 98.0,
                    color: Colors.white,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.deepPurple)));
              } else {
                return SizedBox.fromSize(size: Size.zero);
              }
            },
          );
        },*/
            /* footer: Container(
                color: Colors.grey[400],
                child: MaterialButton(
                    onPressed: () async {
                      // Function Load by button
                      await widget.loadFunction();
                    },
                    child: const Text(
                      'LoadMore',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))),*/
            columnWidthMode: widget.isTreatment! ? ColumnWidthMode.lastColumnFill : ColumnWidthMode.fill,
            // allowFiltering: true,
            navigationMode: GridNavigationMode.row,
            onCellTap: (value) {

              if (widget.onCellClick != null && value.rowColumnIndex.rowIndex!=0) {
                widget.onCellClick!(value.rowColumnIndex.rowIndex);
              }
            },
            columns: _buildColumns(),
          );
        } else
          return Center(
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [Color_Accent],
            ),
          );
      },
    );
  }

  List<GridColumn> _buildColumns() {
    List<GridColumn> returnValue = <GridColumn>[];
    if (widget.dataSource.rows.isNotEmpty)
      for (var r in widget.dataSource.rows[0].getCells()) {
        returnValue.add(GridColumn(
            width: widget.columnNames.length > 12 ? 200 : double.nan,
            columnName: r.columnName,
            columnWidthMode: r.columnName == "Treatment" ? ColumnWidthMode.lastColumnFill : ColumnWidthMode.none,
            label: Container(
                //padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  r.columnName,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ))));
      }
    else
      for (String name in widget.columnNames) {
        returnValue.add(GridColumn(
            width: widget.columnNames.length > 12 ? 200 : double.nan,
            columnName: name,
            columnWidthMode: name == "Treatment" ? ColumnWidthMode.lastColumnFill : ColumnWidthMode.none,
            label: Container(
                //padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ))));
      }
    return returnValue;
  }
}
