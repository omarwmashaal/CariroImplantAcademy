import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class CIA_Table extends StatefulWidget {
  /// Creates the home page.
  CIA_Table({Key? key}) : super(key: key);

  @override
  _CIA_TableState createState() => _CIA_TableState();
}
late EmployeeDataSource employeeDataSource;
late List<Employee> employees = <Employee>[];
class _CIA_TableState extends State<CIA_Table> {


  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: employeeDataSource,
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
      footer: Container(
          color: Colors.grey[400],
          child: MaterialButton(
              onPressed: () async {
                // Function Load by button
                await employeeDataSource.addMoreRows();
              },
              child: const Text(
                'LoadMore',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ))),
      columnWidthMode: ColumnWidthMode.fill,
      allowFiltering: true,
      allowSorting: true,
      navigationMode: GridNavigationMode.row,
      onCellTap: (value) {
        print(value.rowColumnIndex.rowIndex);
      },
      columns: <GridColumn>[
        GridColumn(
            columnName: 'id',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'ID',
                ))),
        GridColumn(
            columnName: 'name',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('Name'))),
        GridColumn(
            columnName: 'designation',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'Designation',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'salary',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('Salary'))),
      ],
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'عمر', 'Project Lead', 20000),
      Employee(10002, 'وائل', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),  Employee(10001, 'عمر', 'Project Lead', 20000),
      Employee(10002, 'وائل', 'Manager', 30000),


    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'designation', value: e.designation),
      DataGridCell<int>(columnName: 'salary', value: e.salary),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
/*
// Infinite Scroll
  @override
  Future<Function> handleLoadMoreRows() async {
    await Future.delayed(const Duration(seconds: 10));

    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
   // notifyListeners();
    _employeeData = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'designation', value: e.designation),
      DataGridCell<int>(columnName: 'salary', value: e.salary),
    ]))
        .toList();
    notifyListeners();
    Function s = (){};
    return  s;
  }
*/
  // Load by button
  addMoreRows() async{

    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    employees.add( Employee(10003, 'Lara', 'Developer', 15000));
    // notifyListeners();
    _employeeData = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(
          columnName: 'designation', value: e.designation),
      DataGridCell<int>(columnName: 'salary', value: e.salary),
    ]))
        .toList();
    notifyListeners();
  }



}
