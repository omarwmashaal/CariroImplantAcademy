import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/addOrRemoveMyPatientsBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSeachBlocEvents.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSeachBlocStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../domain/entities/patientInfoEntity.dart';
import '../../domain/usecases/patientSearchUseCase.dart';

const SERVER_EXCEPTION_MESSAGE = "Internal Server Error";
const DATA_CONVERSION_EXCEPTION_MESSAGE = "Server responded with incorrect data";

class PatientSearchBloc extends Bloc<PatientSearchBloc_Events, PatientSearchBloc_States> {
  final PatientSearchUseCase searchUseCase;
  String _filter = "Name";

  PatientSearchBloc({required this.searchUseCase}) : super(LoadingPatientSearchState()) {
    on<PatientSearchEvent>(
      (event, emit) async {
        emit(LoadingPatientSearchState());
        final result = await searchUseCase(PatientSearchParams(filter: this._filter, query: event.query, myPatients: event.myPatients));
        result.fold(
          (l) {
            if (l is HttpInternalServerErrorFailure)
              emit(LoadingError(message: SERVER_EXCEPTION_MESSAGE));
            else if (l is DataConversionFailure) emit(LoadingError(message: DATA_CONVERSION_EXCEPTION_MESSAGE));
          },
          (r) {
            emit(LoadedPatientSearchState(r));
          },
        );
      },
    );
    on<PatientSearchFilterChangedEvent>((event, emit) {
      this._filter = event.filter;
    },);
  }
}

class MyPatientsSearchBloc extends Bloc<PatientSearchBloc_Events, PatientSearchBloc_States> {
  final PatientSearchUseCase searchUseCase;

  MyPatientsSearchBloc({required this.searchUseCase}) : super(LoadingPatientSearchState()) {
    on<PatientSearchEvent>(
      (event, emit) {
        emit(LoadingPatientSearchState());
      },
    );
  }
}

class PatientSearchDataSourceTable extends DataGridSource {
  //List<PatientSearchResponseEntity> models = <PatientSearchResponseEntity>[];
  late SharedPreferences pref;
  BuildContext context;
  /// Creates the patient data source class with required details.
  PatientSearchDataSourceTable(this.context) ;

  init(List<PatientInfoEntity> models) async {
    pref = await SharedPreferences.getInstance();
    if (pref.getString("role") != "secretary") {
      _patientData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<String>(columnName: 'Name', value: e.name),
                DataGridCell<String>(columnName: 'Phone', value: e.phone),
                DataGridCell<String>(columnName: 'Gender', value: getEnumName(e.gender)),
                DataGridCell<int>(columnName: 'Age', value: e.age),
                DataGridCell<String>(columnName: 'Marital Status', value:getEnumName(e.maritalStatus)),
                DataGridCell<String>(columnName: 'Relative', value: e.relative),
                DataGridCell<Widget>(
                  columnName: 'Add to my patients',
                  value: Center(
                    child: e.doctorId == pref.getInt("userid")
                        ? IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () async {
                              context.read<AddToMyPatientsRangeBloc>().removeFromMyPatients(e.id!);

                            },
                          )
                        : e.doctorId == null
                            ? IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () async {
                                  context.read<AddToMyPatientsRangeBloc>().addToMyPatients(e.id!);
                                },
                              )
                            : Text(e.doctor ?? ""),
                  ),
                ),
              ]))
          .toList();
    } else {
      _patientData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<String>(columnName: 'Name', value: e.name),
                DataGridCell<String>(columnName: 'Phone', value: e.phone),
                DataGridCell<String>(columnName: 'Gender', value: getEnumName(e.gender)),
                DataGridCell<int>(columnName: 'Age', value: e.age),
                DataGridCell<String>(columnName: 'Marital Status', value: getEnumName(e.maritalStatus)),
                DataGridCell<String>(columnName: 'Relative', value: e.relative),
              ]))
          .toList();
    }
  }

  List<DataGridRow> _patientData = [];

  @override
  List<DataGridRow> get rows => _patientData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.value is Widget) return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future update(List<PatientInfoEntity> models) async {

    await init(models);
    notifyListeners();
    //notifyDataSourceListeners();

  }
}