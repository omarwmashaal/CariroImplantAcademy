import 'package:calendar_view/calendar_view.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/ImplantModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/UserAPI.dart';
import '../Helpers/CIA_DateConverters.dart';
import 'API_Response.dart';

class CandidateDetails{
  int? patientId;
  DropDownDTO? patient;
  String? procedure;
  DateTime? date;
  int? implantCount;
  List<String>? otherProcedures;
  int? totalImplantCounts;
  int? tooth;
  int? implantId;
  ImplantModel? implant;

  CandidateDetails({this.patientId,this.patient,this.procedure,this.date,this.implantCount,this.otherProcedures, this.totalImplantCounts});

  CandidateDetails.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patient=  DropDownDTO.fromJson(json['patient']??Map<String,dynamic>());
    procedure = json['procedure']??"";

    date = json['date']==null?null: DateTime.parse(json['date']);
    implantCount = json['implantCount'];
    otherProcedures = json['otherProcedures']??[];
    totalImplantCounts = json['totalImplantCounts'];
    tooth = json['tooth'];
    implantId = json['implantId'];
    implant = ImplantModel.fromJson(json['implant']??Map<String,dynamic>());

  }

}



class CandidateDetailsDataSource extends DataGridSource {
  List<CandidateDetails> models = <CandidateDetails>[];

  List<String> columns = [
    "Patient Id",
    "Patient Name",
    "Procedures",
    "Tooth",
    "Date",
    "Implant",
   // "Implant Count",
    //"Other Procedures",
    "Total Implant Counts",
  ];

  /// Creates the visit data source class with required details.
  CandidateDetailsDataSource() {
    init();
  }
  init() {

    _userData = models
        .map<DataGridRow>((e) =>
        DataGridRow(cells: [
          DataGridCell<int>(columnName: 'Patient Id', value: e.patientId),
          DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name),
          DataGridCell<String>(columnName: 'Procedures', value: e.procedure),
          DataGridCell<int>(columnName: 'Tooth', value: e.tooth),
          DataGridCell<DateTime>(columnName: 'Date', value: e.date),
          DataGridCell<String>(columnName: 'Implant', value: e.implant!.size),
          DataGridCell<int>(columnName: 'Implant Count', value: e.implantCount),
         // DataGridCell<List<String>>(columnName: 'Other Procedures', value: e.otherProcedures),
         // DataGridCell<int>(columnName: 'Total Implant Counts', value: e.totalImplantCounts),

        ]))
        .toList();
  }

  List<DataGridRow> _userData = [];

  @override
  List<DataGridRow> get rows => _userData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          var returnedValue = e.value;
          if (returnedValue is Widget) return returnedValue;
          if(e.columnName=="Date")returnedValue = CIA_DateConverters.fromBackendToDateOnly(e.value==null?null: (e.value??"").toString())??"" ;
          return Container(
            alignment: Alignment.center,
            child: Text(
              returnedValue == null ? "" : returnedValue.toString(),
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          );
        }).toList());
  }

  Future<bool> loadData(int id,Function updateTotal,{String? from,String? to}) async {
    late API_Response response;

    response =await UserAPI.GetCandidateDetails(id,from: from,to:to);

    if (response.statusCode == 200) {
      models = response.result as List<CandidateDetails>;
    }
    var _total = 0;
    models.forEach((element) {
      _total+= element.implantCount??0;
    });
    updateTotal(_total);
    init();
    notifyListeners();

    return true;
  }

}
