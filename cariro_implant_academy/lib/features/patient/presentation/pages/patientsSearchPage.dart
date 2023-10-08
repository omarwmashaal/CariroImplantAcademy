import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/Router.dart';
import 'package:cariro_implant_academy/Models/ComplainsModel.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/addOrRemoveMyPatientsDataSource.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../../Widgets/CIA_Table.dart';
import '../../../../../Widgets/CIA_TextField.dart';
import '../../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../../Widgets/Title.dart';
import '../../../../../core/injection_contianer.dart';
import '../../../../../core/presentation/widgets/tableWidget.dart';
import '../../../labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import '../bloc/addOrRemoveMyPatientsBloc.dart';
import '../bloc/addOrRemoveMyPatientsBloc_states.dart';
import '../bloc/patientSeachBlocEvents.dart';
import '../bloc/patientSeachBlocStates.dart';
import '../bloc/patientSearchBloc.dart';
import 'createOrViewPatientPage.dart';

class PatientsSearchPage extends StatelessWidget {
  PatientsSearchPage({Key? key, this.myPatients = false}) : super(key: key);
  static String routeName = "Patients";
  static String myPatientsRouteName = "MyPatients";
  bool myPatients;

  @override
  Widget build(BuildContext context) {

    var dataSource = PatientSearchDataSourceTable(context);
    BlocProvider.of<PatientSearchBloc>(context).add( PatientSearchEvent(myPatients: myPatients));
    return MultiBlocListener(
      listeners: [
        BlocListener<PatientSearchBloc, PatientSearchBloc_States>(
          listener: (context, state) {
            if (state is LoadingPatientSearchState)
              CustomLoader.show(context);
            else if (state is LoadingError)
              ShowSnackBar(context, isSuccess: false, message: state.message);
            else if (state is LoadedPatientSearchState)
              dataSource.update(state.result);
            if (state is! LoadingPatientSearchState) CustomLoader.hide();
          },
        ),
        BlocListener<AddToMyPatientsRangeBloc, AddToMyPatientsRangeBloc_States>(
          listener: (context, state) {
            if (state is LoadingPatientSearchState)
              CustomLoader.show(context);
            else if (state is ErrorState)
              ShowSnackBar(context, isSuccess: false, message: state.message);
            else if (state is DoneState) {
              ShowSnackBar(context, isSuccess: true);
              BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(myPatients: myPatients));
            }

            if (state is! LoadingPatientSearchState) CustomLoader.hide();
          },
        ),
      ],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TitleWidget(
                  title: "Patients Search",
                  showBackButton: false,
                ),
              ),
              CIA_SecondaryButton(
                  label: "Add Range to my patients",
                  onTab: () {
                    int fromId = 0;
                    int toId = 0;
                    CIA_ShowPopUp(
                      height: 100,
                      context: context,
                      onSave: () async {
                        context.read<AddToMyPatientsRangeBloc>().addToMyPatientsRange(fromId, toId);
                        return false;
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "From Id",
                                  isNumber: true,
                                  controller: TextEditingController(),
                                  onChange: (v) => fromId = int.parse(v),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "To Id",
                                  isNumber: true,
                                  controller: TextEditingController(),
                                  onChange: (v) => toId = int.parse(v),
                                ),
                              ),
                            ],
                          ),
                          BlocConsumer<AddToMyPatientsRangeBloc, AddToMyPatientsRangeBloc_States>(
                            builder: (context, state) {
                              if (state is ErrorState)
                                return Text(
                                  state.message,
                                  style: TextStyle(color: Colors.red, fontSize: 15),
                                );
                              else
                                return Container();
                            },
                            listener: (context, state) {
                              if (state is LoadingState)
                                CustomLoader.show(context);
                              else {
                                CustomLoader.hide();
                              }
                              if (state is DoneState) {
                                dialogHelper.dismissSingle(context);
                                ShowSnackBar(context, isSuccess: true);
                                BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(myPatients: myPatients));
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }),
              SizedBox(width: 10),
              CIA_PrimaryButton(
                  label: "Add Patient",
                  onTab: () {
                    context.goNamed(CreateOrViewPatientPage.addPatientRouteName);
                  })
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: CIA_TextField(
                            label: "Search",
                            icon: Icons.search,
                            onChange: (value) => dispatchSearch(context, value),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: HorizontalRadioButtons(
                                  groupValue: "Name",
                                  names: ["Name", "Phone", "All"],
                                  onChange: (value) => dispatchChangeFilter(context, value)
                                  // _getXController.searchFilter.value = value;
                                  ,
                                ),
                              ),
                              Expanded(child: SizedBox())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TableWidget(
                    dataSource: dataSource,
                    onCellClick: (value) {
                      //    setState(() {
                      //     selectedPatientID = dataSource.models[value - 1].id!;
                      //    });
                      //internalPagesController.jumpToPage(1);
                         context.goNamed(CIA_Router.routeConst_PatientInfo, pathParameters: {"id":value.toString()});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispatchSearch(BuildContext context, String query) {
    BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(query: query,myPatients: myPatients));
  }

  void dispatchChangeFilter(BuildContext context, String filter) {
    BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchFilterChangedEvent(filter));
  }
}
