import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/searchToDoListUseCase%20.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/toDoListBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/toDoListBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/createOrViewPatientPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/pages/medicalInfo_MedicalHistoryPage.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Helpers/Router.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';

class ToDoListsSearchPage extends StatefulWidget {
  const ToDoListsSearchPage({Key? key}) : super(key: key);
  static String routePath = "ToDoListsSearchPage";

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ToDoListsSearchPage";
      default:
        return "ToDoListsSearchPage";
    }
  }

  @override
  State<ToDoListsSearchPage> createState() => _ToDoListsSearchPageState();
}

class _ToDoListsSearchPageState extends State<ToDoListsSearchPage> {
  late ToDoListDataGridSource datasource;
  SearchToDoListParams searchParams = SearchToDoListParams();
  late ToDoListBloc bloc;

  @override
  void initState() {
    bloc = context.read<ToDoListBloc>();
    datasource = ToDoListDataGridSource(context, bloc);
    bloc.searchToList(searchParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ToDoListBloc, ToDoListBloc_States>(
      listener: (context, state) {
        if (state is ToDoListBlocState_GettingDataState)
          CustomLoader.show(context);
        else {
          CustomLoader.hide();
          if (state is ToDoListBlocState_UpdatingDataSuccess) bloc.searchToList(searchParams);
        }
      },
      child: Column(
        children: [
          TitleWidget(
            title: "To do lists and reminders",
            showBackButton: false,
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
                            onChange: (value) {
                              searchParams.search = value;
                              bloc.searchToList(searchParams);
                            },
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(text: "Status"),
                              Expanded(
                                child: HorizontalRadioButtons(
                                  groupValue: "All",
                                  names: ["All", "Done", "Not Done"],
                                  onChange: (value) {
                                    if (value == "done")
                                      searchParams.done = true;
                                    else if (value == "not done")
                                      searchParams.done = false;
                                    else
                                      searchParams.done = null;
                                    bloc.searchToList(searchParams);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              FormTextKeyWidget(text: "Due Date"),
                              Expanded(
                                child: HorizontalRadioButtons(
                                  groupValue: "All",
                                  names: ["All", "Over Due", "Not Yet"],
                                  onChange: (value) {
                                    if (value == "over due")
                                      searchParams.overdue = true;
                                    else if (value == "not yet")
                                      searchParams.overdue = false;
                                    else
                                      searchParams.overdue = null;
                                    bloc.searchToList(searchParams);
                                  },
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
                  child: BlocBuilder<ToDoListBloc, ToDoListBloc_States>(
                    buildWhen: (previous, current) =>
                        current is ToDoListBlocState_GettingDataState ||
                        current is ToDoListBlocState_GettingDataFailed ||
                        current is ToDoListBlocState_GettingDataSuccess,
                    builder: (context, state) {
                      if (state is ToDoListBlocState_GettingDataFailed)
                        return BigErrorPageWidget(message: state.message);
                      else if (state is ToDoListBlocState_GettingDataState)
                        return LoadingWidget();
                      else if (state is ToDoListBlocState_GettingDataSuccess) {
                        datasource.models = state.data;
                        datasource.init(datasource.models);
                      }
                      return TableWidget(
                        dataSource: datasource,
                        onCellClick: (value) {
                          context.goNamed(PatientMedicalHistory.getRouteName(), pathParameters: {"id": value.toString()});
                        },
                      );
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
}
