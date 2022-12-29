import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomerInfoModel {
  String? Name;
  int? ID;
  String? Phone;
  String? Phone2;
  String? ClinicName;
  String? ClinicAddress;

  CustomerInfoModel(
    this.ID,
    this.Name,
    this.Phone,
    this.ClinicName,
    this.ClinicAddress,
  );

  static List<CustomerInfoModel> models = <CustomerInfoModel>[];
  static List<String> columns = [
    "ID",
    "Name",
    "Phone",
    "Clinic Name",
    "Clinic Address"
  ];
//CustomerDataSource dataSource = CustomerDataSource();

}

class CustomerDataSource extends DataGridSource {
  List<CustomerInfoModel> models = <CustomerInfoModel>[
    CustomerInfoModel(1, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(2, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(3, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(4, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(5, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(6, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(7, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(8, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(9, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(5, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(5, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(5, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(5, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
    CustomerInfoModel(5, "Omar", "1290447120", "Clinic Name", "Clinic Address"),
  ];

  /// Creates the customer data source class with required details.
  CustomerDataSource() {
    _customerData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Name', value: e.Name),
              DataGridCell<String>(columnName: 'Phone', value: e.Phone),
              DataGridCell<String>(columnName: 'Clinic Name', value: e.Phone),
              DataGridCell<String>(columnName: 'Clinic Phone', value: e.Phone),
            ]))
        .toList();
  }

  List<DataGridRow> _customerData = [];

  @override
  List<DataGridRow> get rows => _customerData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
