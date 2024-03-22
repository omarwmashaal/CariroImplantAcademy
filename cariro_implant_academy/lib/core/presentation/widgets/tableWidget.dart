import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
late Function GlobalLoadFunction;

class TableWidget extends StatefulWidget {
  TableWidget(
      {Key? key,

      this.onCellClick,
      this.isTreatment = false,
      required this.dataSource,
      this.title,
      this.showSum = false,
        this.headerStyle,
        this.headerHeight,
      this.allowSorting = true,
      this.allowGroupingCollapse = false,
      this.showGridLines = false})
      : super(key: key);

  DataGridSource dataSource;
  Function(dynamic index)? onCellClick;
  bool? isTreatment;
  String? title;
  bool showGridLines;
  bool showSum;
  bool allowSorting;
  TextStyle? headerStyle;
  double? headerHeight;
  bool allowGroupingCollapse;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {

    return SfDataGrid(
      //allowExpandCollapseGroup: widget.allowGroupingCollapse,
      isScrollbarAlwaysShown: true,
      horizontalScrollController: ScrollController(),
      horizontalScrollPhysics: BouncingScrollPhysics(),
      allowSorting: widget.allowSorting,
      allowTriStateSorting: widget.allowSorting,
      allowMultiColumnSorting: widget.allowSorting,
      showHorizontalScrollbar: true,
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
          : [],/*
      stackedHeaderRows: title != null
          ? [
              StackedHeaderRow(cells: [
                StackedHeaderCell(columnNames: columnNames, child: Container(alignment: Alignment.center, color: Color_Accent, child: Text(title as String)))
              ])
            ]
          : [],*/
      source: widget.dataSource,
      columnWidthMode: widget.isTreatment! ? ColumnWidthMode.lastColumnFill : ColumnWidthMode.fill,
      navigationMode: GridNavigationMode.row,
      onCellTap: (value) {
        if (widget.onCellClick != null && value.rowColumnIndex.rowIndex != 0) {
          widget.onCellClick!(widget.dataSource.effectiveRows.elementAt(value.rowColumnIndex.rowIndex-1).getCells().firstWhere((element) => element.columnName.toLowerCase()=="id").value as dynamic);


        }
      },
      columns: _buildColumns(),
      headerRowHeight: widget.headerHeight??double.nan,
    );
  }

  List<GridColumn> _buildColumns() {
    List<GridColumn> returnValue = <GridColumn>[];
    final columns =[];// ["ID","Name","Phone","Gender","Age","Marital Status","Relative",'Add to my patients'];
    if (widget.dataSource.rows.isNotEmpty)
      for (var r in widget.dataSource.rows[0].getCells()) {
        returnValue.add(GridColumn(
           // width: columnNames.length > 12 ? 200 : double.nan,
            columnName: r.columnName,

            columnWidthMode: r.columnName == "Treatment" ? ColumnWidthMode.lastColumnFill : ColumnWidthMode.none,
            label: Container(
//padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child:  Text(
                  r.columnName,
                  style: widget.headerStyle??TextStyle(fontWeight: FontWeight.w900),
                ))));
      }
    else
      for (String name in columns) {
        returnValue.add(GridColumn(
           // width: columnNames.length > 12 ? 200 : double.nan,
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
