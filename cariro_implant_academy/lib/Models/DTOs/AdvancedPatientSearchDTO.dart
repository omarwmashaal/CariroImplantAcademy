import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API_Response.dart';

class AdvancedPatientSearchDTO {
  int? id;
  String? name;
  int? ageRangeFrom;
  int? ageRangeTo;
  int? age;
  EnumGender? gender;
  bool? anyDiseases;
  List<DiseasesEnum>? diseases;
  List<BloodPressureEnum>? bloodPressureCategories;
  BloodPressureEnum? bloodPressure;
  List<DiabetesEnum>? diabetesCategories;
  DiabetesEnum? diabetes;
  int? lastHAB1cFrom;
  int? lastHAB1cTo;
  bool? penecilin;
  bool? illegalDrugs;
  PregnancyEnum? pregnancy;
  bool? chewing;
  SmokingStatus? smokingStatus;
  EnumCooperationScore? cooperationScore;
  EnumOralHygieneRating? oralHygieneRating;
  int? lastHAB1c;

  AdvancedPatientSearchDTO(
      {this.id,
      this.ageRangeFrom,
      this.ageRangeTo,
      this.gender,
      this.anyDiseases,
      this.bloodPressureCategories,
      this.diabetesCategories,
      this.lastHAB1cFrom,
      this.lastHAB1cTo,
      this.penecilin,
      this.illegalDrugs,
      this.pregnancy,
      this.chewing,
      this.smokingStatus,
      this.cooperationScore,
      this.oralHygieneRating});

  AdvancedPatientSearchDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    //ageRangeFrom = json['ageRangeFrom'];
    //ageRangeTo = json['ageRangeTo'];
    gender = json['gender'] == null ? null : EnumGender.values[json['gender']];
    diseases = json['diseases'] == null ? null : ((json['diseases']) as List<dynamic>).map((e) => DiseasesEnum.values[e as int]).toList();
    //bloodPressureCategories = json['bloodPressureCategories'].cast<int>();
    bloodPressure = json['bloodPressure'] == null ? null : BloodPressureEnum.values[json['bloodPressure']];
    //diabetesCategories = json['diabetesCategories'].cast<int>();
    diabetes = json['diabetes'] == null ? null : DiabetesEnum.values[json['diabetes']];
    //lastHAB1cFrom = json['lastHAB1c_From'];
    //lastHAB1cTo = json['lastHAB1c_To'];
    lastHAB1c = json['lastHAB1c'];
    penecilin = json['penecilin'];
    illegalDrugs = json['illegalDrugs'];
    pregnancy = json['pregnancy'] == null ? null : PregnancyEnum.values[json['pregnancy']];
    chewing = json['chewing'];
    smokingStatus = json['smokingStatus'] == null ? null : SmokingStatus.values[json['smokingStatus']];
    oralHygieneRating = json['oralHygieneRating'] == null ? null : EnumOralHygieneRating.values[json['oralHygieneRating']];
    cooperationScore = json['cooperationScore'] == null ? null : EnumCooperationScore.values[json['cooperationScore']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ageRangeFrom'] = this.ageRangeFrom;
    data['ageRangeTo'] = this.ageRangeTo;
    data['gender'] = this.gender == null ? null : this.gender!.index;
    data['anyDiseases'] = this.anyDiseases;
    data['bloodPressureCategories'] = this.bloodPressureCategories == null ? null : this.bloodPressureCategories!.map((e) => e.index).toList();
    data['diabetesCategories'] = this.diabetesCategories == null ? null : this.diabetesCategories!.map((e) => e.index).toList();
    data['lastHAB1c_From'] = this.lastHAB1cFrom;
    data['lastHAB1c_To'] = this.lastHAB1cTo;
    data['penecilin'] = this.penecilin;
    data['illegalDrugs'] = this.illegalDrugs;
    data['pregnancy'] = this.pregnancy == null ? null : this.pregnancy!.index;
    data['chewing'] = this.chewing;
    data['smokingStatus'] = this.smokingStatus == null ? null : this.smokingStatus!.index;
    data['oralHygieneRating'] = this.oralHygieneRating == null ? null : this.oralHygieneRating!.index;
    data['cooperationScore'] = this.cooperationScore == null ? null : this.cooperationScore!.index;

    return data;
  }
}

class AdvancedPatientSearchDataSource extends DataGridSource {
  List<String> columns = [];

  List<AdvancedPatientSearchDTO> models = <AdvancedPatientSearchDTO>[];
  AdvancedPatientSearchDTO searchDTO = AdvancedPatientSearchDTO();
  /// Creates the income data source class with required details.
  AdvancedPatientSearchDataSource() {}

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: (){
          List<DataGridCell> r = [];
           r.add(DataGridCell<int>(columnName: "Id", value: e.id));
           r.add(DataGridCell<String>(columnName: "Name", value: e.name));
          if(searchDTO.gender!=null) r.add(DataGridCell<String>(columnName: "Gender", value: e.gender!=null?e.gender!.name:""));
          if(searchDTO.ageRangeFrom!=null || searchDTO.ageRangeTo!=null) r.add(DataGridCell<int>(columnName: "Age", value: e.age??0));
          if(searchDTO.anyDiseases!=null) r.add(DataGridCell<List<String>>(columnName: "Diseases", value: e.diseases==null?[]:e.diseases!.map((e) => e.name).toList()));
          if(searchDTO.bloodPressureCategories!=null) r.add(DataGridCell<String>(columnName: "Blood Pressure", value: e.bloodPressure==null?"":e.bloodPressure!.name));
          if(searchDTO.diabetesCategories!=null) r.add(DataGridCell<String>(columnName: "Diabetes", value: e.diabetes==null?"":e.diabetes!.name));
          if(searchDTO.lastHAB1cFrom!=null || searchDTO.lastHAB1cTo!=null) r.add(DataGridCell<int>(columnName: "Last HAB1c", value: e.lastHAB1c));
          if(searchDTO.penecilin!=null) r.add(DataGridCell<String>(columnName: "Penecilin", value: e.penecilin==true?"Yes":"No"));
          if(searchDTO.illegalDrugs!=null) r.add(DataGridCell<String>(columnName: "Illegal Drugs", value: e.illegalDrugs==true?"Yes":"No"));
          if(searchDTO.pregnancy!=null) r.add(DataGridCell<String>(columnName: "Pregnancy", value: e.pregnancy==null?"":e.pregnancy!.name));
          if(searchDTO.chewing!=null) r.add(DataGridCell<String>(columnName: "Chewing", value: e.chewing==true?"Yes":"No"));
          if(searchDTO.smokingStatus!=null) r.add(DataGridCell<String>(columnName: "Smoking Status", value: e.smokingStatus==null?"":e.smokingStatus!.name));
          if(searchDTO.cooperationScore!=null) r.add(DataGridCell<String>(columnName: "Cooperation Score", value: e.cooperationScore==null?"":e.cooperationScore!.name));
          if(searchDTO.oralHygieneRating!=null) r.add(DataGridCell<String>(columnName: "Oral Hygiene Rating", value: e.oralHygieneRating==null?"":e.oralHygieneRating!.name));
          return r;
    }()))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value.toString(),
        ),
      );
    }).toList());
  }

  Future<List<String>> loadData({ required AdvancedPatientSearchDTO msearchDTO}) async {
    searchDTO = msearchDTO;
    columns = [];
 columns.add("Id");
 columns.add("Name");
    if(searchDTO.gender!=null) columns.add("Gender");
    if(searchDTO.ageRangeFrom!=null|| searchDTO.ageRangeTo!=null) columns.add("Age");
    if(searchDTO.anyDiseases!=null) columns.add("Diseases");
    if(searchDTO.bloodPressureCategories!=null) columns.add("Blood Pressure");
    if(searchDTO.diabetesCategories!=null) columns.add("Diabetes");
    if(searchDTO.lastHAB1cTo!=null || searchDTO.lastHAB1cFrom!=null) columns.add("Last HAB1c");
    if(searchDTO.penecilin!=null) columns.add("Penecilin");
    if(searchDTO.illegalDrugs!=null) columns.add("Illegal Drugs");
    if(searchDTO.pregnancy!=null) columns.add("Pregnancy");
    if(searchDTO.chewing!=null) columns.add("Chewing");
    if(searchDTO.smokingStatus!=null) columns.add("SmokingStatus");
    if(searchDTO.cooperationScore!=null) columns.add("CooperationScore");
    if(searchDTO.oralHygieneRating!=null) columns.add("Oral Hygiene Rating");


    API_Response response = await PatientAPI.AdvancedSearchPatient(msearchDTO);

    if (response.statusCode == 200) models = response.result as List<AdvancedPatientSearchDTO>;
    init();
    notifyListeners();


    return columns;
  }
}
