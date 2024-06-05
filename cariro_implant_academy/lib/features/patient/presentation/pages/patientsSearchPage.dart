import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../../Widgets/CIA_TextField.dart';
import '../../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../../Widgets/Title.dart';
import '../../../../../core/presentation/widgets/tableWidget.dart';
import '../bloc/addOrRemoveMyPatientsBloc.dart';
import '../bloc/addOrRemoveMyPatientsBloc_states.dart';
import '../bloc/patientSeachBlocEvents.dart';
import '../bloc/patientSeachBlocStates.dart';
import '../bloc/patientSearchBloc.dart';
import 'createOrViewPatientPage.dart';

class PatientsSearchPage extends StatefulWidget {
  PatientsSearchPage({Key? key, this.myPatients = false}) : super(key: key);

  bool myPatients;

  static String routePath = "Patients";
  static String routeMyPath = "MyPatients";

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicPatients";
      default:
        return "Patients";
    }
  }

  static String getMyRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicMyPatients";
      default:
        return "MyPatients";
    }
  }

  @override
  State<PatientsSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientsSearchPage> {
  bool? out;
  String filter = "Id";
  String search = "";
  bool listed = true;
  EnumPatientCallHistory? callHistory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listed = true;
    search = "";
    filter = "Id";
    dispatchChangeFilter(context, filter, out, listed, callHistory);
    BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(myPatients: widget.myPatients, query: ""));
    var dataSource = PatientSearchDataSourceTable(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<PatientSearchBloc, PatientSearchBloc_States>(
          listener: (context, state) {
            if (state is LoadingPatientSearchState)
              CustomLoader.show(context);
            else if (state is LoadingError)
              ShowSnackBar(context, isSuccess: false, message: state.message);
            else if (state is LoadedPatientSearchState) dataSource.update(state.result);
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
              BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(myPatients: widget.myPatients));
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
                  width: 160,
                  onTab: () async {
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
                                BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(myPatients: widget.myPatients));
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
                  isLong: true,
                  onTab: () {
                    context.goNamed(CreateOrViewPatientPage.getAddRouteName());
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
                            onChange: (value) {
                              search = value;
                              dispatchSearch(context, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: HorizontalRadioButtons(
                                    groupValue: "Id",
                                    names: ["Id", "Name", "Phone", "All"],
                                    onChange: (value) {
                                      filter = value;

                                      dispatchChangeFilter(context, filter, out, listed, callHistory);
                                    }
                                    // _getXController.searchFilter.value = value;
                                    ,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: CIA_MultiSelectChipWidget(
                                    singleSelect: true,
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "All", isSelected: out == null),
                                      CIA_MultiSelectChipWidgeModel(label: "Active", isSelected: out == false),
                                      CIA_MultiSelectChipWidgeModel(label: "Out", isSelected: out == true),
                                    ],
                                    onChange: (item, isSelected) {
                                      if (item == "All")
                                        out = null;
                                      else if (item == "Active")
                                        out = false;
                                      else if (item == "Out") out = true;

                                      dispatchChangeFilter(context, filter, out, listed, callHistory);
                                      dispatchSearch(context, search);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: FormTextValueWidget(text: listed ? "Listed" : "Unlisted"),
                                          ),
                                          Switch(
                                            value: listed,
                                            onChanged: (value) {
                                              if (value != true) callHistory = null;
                                              setState(() => listed = value);
                                              dispatchChangeFilter(context, filter, out, listed, callHistory);
                                              dispatchSearch(context, search);
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          Visibility(
                                            visible: listed != true,
                                            child: Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Call Status",
                                                items: EnumPatientCallHistory.values
                                                    .map((e) => BasicNameIdObjectEntity(
                                                          name: e.name,
                                                          id: e.index,
                                                        ))
                                                    .toList(),
                                                onSelect: (value) {
                                                  callHistory = EnumPatientCallHistory.values[value.id!];
                                                  dispatchChangeFilter(context, filter, out, listed, callHistory);
                                                  dispatchSearch(context, search);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: BlocBuilder<PatientSearchBloc, PatientSearchBloc_States>(
                      builder: (context, state) {
                        return TableWidget(
                          dataSource: dataSource,
                          onCellClick: (value) {
                            var p = dataSource.models.firstWhere((element) => element.secondaryId == value);
                            //    setState(() {
                            //     selectedPatientID = dataSource.models[value - 1].id!;
                            //    });
                            //internalPagesController.jumpToPage(1);
                            context.goNamed(CreateOrViewPatientPage.getVisitPatientRouteName(goToVisit: p.listed != true),
                                pathParameters: {"id": p.id.toString()});
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispatchSearch(BuildContext context, String query) {
    BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchEvent(query: query, myPatients: widget.myPatients));
  }

  void dispatchChangeFilter(BuildContext context, String filter, bool? out, bool? listed, EnumPatientCallHistory? callHistory) {
    BlocProvider.of<PatientSearchBloc>(context).add(PatientSearchFilterChangedEvent(filter, out, listed, callHistory));
  }
}
