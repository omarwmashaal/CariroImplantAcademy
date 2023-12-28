import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getAllRequestsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Constants/Fonts.dart';
import '../../../../Helpers/Router.dart';
import '../../../../core/constants/enums/enums.dart';
import 'LapCreateNewRequestPage.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../Widgets/Title.dart';
import '../blocs/labRequestBloc.dart';

class LabRequestsSearchPage extends StatefulWidget {
  LabRequestsSearchPage({
    Key? key,
    this.all = false,
    this.myRequests = false,
  }) : super(key: key);
  bool all;
  bool myRequests;
  static String routeName = "TodaysRequests";
  static String routeNameClinic = "ClinicTodaysRequests";
  static String routePath = "Requests/TodaysRequests";

  static String routeAllName = "AllRequests";
  static String routeAllPath = "Requests/AllRequests";

  static String routeMyName = "MyRequests";
  static String routeMyPath = "Requests/MyRequests";

  @override
  State<LabRequestsSearchPage> createState() => _LabRequestsSearchPageState();
}

class _LabRequestsSearchPageState extends State<LabRequestsSearchPage> {
  String search = "";

  LabRequestDataGridSource dataSource = LabRequestDataGridSource();

  EnumLabRequestStatus? statusEnum;

  EnumLabRequestSources? sourceEnum;

  bool? paid;

  DateTime? from;

  DateTime? to;
  late LabRequestsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reload();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TitleWidget(title: widget.all ? "All Requests" : "Today's Requests"),
            Expanded(child: SizedBox()),
            CIA_PrimaryButton(
              width: 155,
              label: "Add new request",
              onTab: () {
                context.goNamed(LabCreateNewRequestPage.routeName);
              },
              isLong: true,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Requests in Queue ",
              style: TextStyle(fontFamily: Inter_Bold, fontSize: 20),
            ),
            BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
              buildWhen: (previous, current) => current is LabRequestsBloc_LoadedMultiRequestsSuccessfullyState,
              builder: (context, state) {
                int number = 0;
                if (state is LabRequestsBloc_LoadedMultiRequestsSuccessfullyState)
                  number = state.requests.where((element) => element.status==EnumLabRequestStatus.InQueue).length;
                return Text(
                  number.toString(),
                  style: TextStyle(fontFamily: Inter_Bold, fontSize: 30, color: Colors.red),
                );
              },
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
        Expanded(
          child: Column(
            children: [
              CIA_TextField(
                label: "Search",
                icon: Icons.search,
                onChange: (value) {
                  search = value;
                  reload();
                },
              ),
              SizedBox(height:10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CIA_DropDownSearchBasicIdName(
                        onSelect: (v) {
                          if (v.name == "CIA")
                            sourceEnum = EnumLabRequestSources.CIA;
                          else if (v.name == "Clinic")
                            sourceEnum = EnumLabRequestSources.Clinic;
                          else if (v.name == "Outsource")
                            sourceEnum = EnumLabRequestSources.OutSource;
                          else if (v.name == "None") sourceEnum = null;
                          reload();
                        },
                        label: 'Source',
                        selectedItem: BasicNameIdObjectEntity(name: "None"),
                        items: [
                          BasicNameIdObjectEntity(name: "None"),
                          BasicNameIdObjectEntity(name: "CIA"),
                          BasicNameIdObjectEntity(name: "Clinic"),
                          BasicNameIdObjectEntity(name: "Outsource"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CIA_DropDownSearchBasicIdName(
                        onSelect: (v) {
                          if (v.name == "Unpaid")
                            paid = false;
                          else if (v.name == "Paid")
                            paid = true;
                          else if (v.name == "None") paid = null;
                          reload();
                        },
                        label: 'Payment',
                        selectedItem: BasicNameIdObjectEntity(name: "None"),
                        items: [
                          BasicNameIdObjectEntity(name: "None"),
                          BasicNameIdObjectEntity(name: "Paid"),
                          BasicNameIdObjectEntity(name: "Unpaid"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CIA_DropDownSearchBasicIdName(
                        onSelect: (v) {
                          if (v.name == "In Queue")
                            statusEnum = EnumLabRequestStatus.InQueue;
                          else if (v.name == "In Progress")
                            statusEnum = EnumLabRequestStatus.InProgress;
                          else if (v.name == "Finished")
                            statusEnum =EnumLabRequestStatus.Finished;
                          else if (v.name == "None") statusEnum = null;
                          reload();
                        },
                        label: 'Status',
                        selectedItem: BasicNameIdObjectEntity(name: "None"),
                        items: [
                          BasicNameIdObjectEntity(name: "None"),
                          BasicNameIdObjectEntity(name: "In Queue"),
                          BasicNameIdObjectEntity(name: "In Progress"),
                          BasicNameIdObjectEntity(name: "Finished"),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
              ),
              SizedBox(height:10),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
              buildWhen: (previous, current) =>
                  current is LabRequestsBloc_LoadingRequestsState ||
                  current is LabRequestsBloc_LoadingRequestsErrorState ||
                  current is LabRequestsBloc_LoadedMultiRequestsSuccessfullyState,
              builder: (context, state) {
                if (state is LabRequestsBloc_LoadingRequestsState)
                  return LoadingWidget();
                else if (state is LabRequestsBloc_LoadingRequestsErrorState)
                  return BigErrorPageWidget(message: state.message);
                else if (state is LabRequestsBloc_LoadedMultiRequestsSuccessfullyState) {
                  dataSource.updateData(state.requests);
                  return TableWidget(
                      dataSource: dataSource,
                      onCellClick: (value) {
                        context.goNamed(CIA_Router.routeConst_LabView, pathParameters: {"id": value.toString()});
                      });
                }
                return Container();
              }),
        ),
      ],
    );
  }

  reload() async {
    bloc.add(LabRequestsBloc_GetTodaysRequestsEvent(
      getAllRequestsParams: GetAllRequestsParams(
        search: search,
        from: widget.all ? from : DateTime.now(),
          to: widget.all ? to : DateTime.now(),
        source: sourceEnum,
        status: statusEnum,
        paid: paid,
        myRequests: widget.myRequests,
      ),
    ));
  }
}
