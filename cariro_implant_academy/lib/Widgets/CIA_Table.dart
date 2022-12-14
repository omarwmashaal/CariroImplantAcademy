import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class CIA_Table extends StatefulWidget {
  /// Creates the home page.
  CIA_Table({Key? key, required this.dataSource, required this.columnNames, this.loadMoreFunction, this.onClick}) : super(key: key);

  DataGridSource dataSource;
  List<String> columnNames;
  Function? loadMoreFunction;
  Function? onClick;

  @override
  _CIA_TableState createState() => _CIA_TableState();


}
class _CIA_TableState extends State<CIA_Table> {




  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: widget.dataSource,
      loadMoreViewBuilder: (BuildContext context, LoadMoreRows loadMoreRows) {
        Future loadRows() async {
          await loadMoreRows();
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
      },
      /*footer: Container(
          color: Colors.grey[400],
          child: MaterialButton(
              onPressed: () async {
                // Function Load by button
                //await widget.dataSource.addMoreRows();
              },
              child: const Text(
                'LoadMore',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ))),*/

      columnWidthMode: ColumnWidthMode.fill,
      allowFiltering: true,
      navigationMode: GridNavigationMode.row,
      onCellTap: (value) {
        if(widget.onClick!=null) widget.onClick!(value.rowColumnIndex.rowIndex);
        //if enable sorting addd tablecontroller and add to it while building rows
      },
      columns: _buildColumns(),
    );
  }

  List<GridColumn> _buildColumns()
  {
    List<GridColumn> returnValue = <GridColumn>[];
    for(String name in widget.columnNames)
      {
        returnValue.add(GridColumn(
            columnName: name,
            label: Container(
                //padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  name,
                ))));
      }
    return returnValue;
  }


}


