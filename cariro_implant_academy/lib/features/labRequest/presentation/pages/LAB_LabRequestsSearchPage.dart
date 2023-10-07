import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getAllRequestsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Constants/Fonts.dart';
import '../../../../core/constants/enums/enums.dart';
import 'LapCreateNewRequestPage.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../Widgets/Title.dart';
import '../blocs/labRequestBloc.dart';

class LabTodaysRequestsSearch extends StatefulWidget {
  LabTodaysRequestsSearch({Key? key}) : super(key: key);
  static String routeName = "TodaysRequests";
  static String routePath = "Requests/TodaysRequests";

  @override
  State<LabTodaysRequestsSearch> createState() => _LabTodaysRequestsSearchState();
}

class _LabTodaysRequestsSearchState extends State<LabTodaysRequestsSearch> {
  String search = "";

  LabRequestDataGridSource dataSource = LabRequestDataGridSource();

  EnumLabRequestStatus? statusEnum;

  EnumLabRequestSources? sourceEnum;

  bool? paid;

  String? from;

  String? to;
  late LabRequestsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TitleWidget(title: "Today's Requests"),
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
              buildWhen: (previous, current) => current is LabRequestsBloc_UpdateQueueNumberState,
              builder: (context, state) {
                int number = 0;
                if (state is LabRequestsBloc_UpdateQueueNumberState) number = state.number;
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
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CIA_TextField(
                    label: "Search",
                    icon: Icons.search,
                    onChange: (value) {
                      search = value;
                      reload();
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: HorizontalRadioButtons(
                          names: ["Sender Name", "Sender Phone", "Assigned To"],
                        ),
                      ),
                      Expanded(flex: 2, child: SizedBox())
                    ],
                  ),
                ),
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
                            else if (v.name == "Finished and Handled")
                              statusEnum = EnumLabRequestStatus.FinishedAndHandeled;
                            else if (v.name == "Finished Not Handled")
                              statusEnum = EnumLabRequestStatus.FinishedNotHandeled;
                            else if (v.name == "None") statusEnum = null;
                            reload();
                          },
                          label: 'Status',
                          selectedItem: BasicNameIdObjectEntity(name: "None"),
                          items: [
                            BasicNameIdObjectEntity(name: "None"),
                            BasicNameIdObjectEntity(name: "In Queue"),
                            BasicNameIdObjectEntity(name: "In Progress"),
                            BasicNameIdObjectEntity(name: "Finished and Handled"),
                            BasicNameIdObjectEntity(name: "Finished Not Handled"),
                          ],
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
          flex: 3,
          child: TableWidget(
              dataSource: dataSource,
              onCellClick: (value) {
                //context.goNamed(CIA_Router.routeConst_LabView, pathParameters: {"id": dataSource.models[value - 1].id.toString()});
              }),
        ),
      ],
    );
  }

  reload() async {
    bloc.add(LabRequestsBloc_GetTodaysRequestsEvent(
        getAllRequestsParams: GetAllRequestsParams(
      search: search,
      from: DateTime.now().toString(),
      to: DateTime.now().toString(),
      source: sourceEnum,
      status: statusEnum,
      paid: paid,
    )));
  }
}

class LabAllRequestsSearch extends StatelessWidget {
  LabAllRequestsSearch({Key? key, this.myRequests = false}) : super(key: key);
  static String routeName = "AllRequests";
  static String routePath = "Requests/AllRequests";

  static String routeMyName = "MyRequests";
  static String routeMyPath = "Requests/MyRequests";

  bool myRequests;
  LabRequestDataGridSource dataSource = LabRequestDataGridSource();
  EnumLabRequestStatus? statusEnum;
  EnumLabRequestSources? sourceEnum;
  bool? paid;
  String? from;
  String? to;
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TitleWidget(title: "All Requests"),
            Expanded(child: SizedBox()),
            CIA_PrimaryButton(
              width: 155,
              label: "Add new request",
              onTab: () {
                context.goNamed(LabCreateNewRequestSharedPage.routeName);
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
            Obx(() => Text(
              _GetXController.inQueueCount.value,
              style: TextStyle(fontFamily: Inter_Bold, fontSize: 30, color: Colors.red),
            )),
            SizedBox(
              width: 30,
            )
          ],
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CIA_TextField(
                    label: "Search",
                    icon: Icons.search,
                    onChange: (value) {
                      Search = value;
                      search = value;
                      reload();
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: HorizontalRadioButtons(
                          names: ["Sender Name", "Sender Phone", "Assigned To"],
                        ),
                      ),
                      Expanded(flex: 2, child: SizedBox())
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CIA_DropDownSearch(
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
                          selectedItem: DropDownDTO(name: "None"),
                          items: [
                            DropDownDTO(name: "None"),
                            DropDownDTO(name: "CIA"),
                            DropDownDTO(name: "Clinic"),
                            DropDownDTO(name: "Outsource"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Obx(() => Row(
                            children: [
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "From Date",
                                  controller: TextEditingController(text: _GetXController.from.value),
                                  enabled: false,
                                  onTap: () {
                                    CIA_PopupDialog_DateOnlyPicker(context, "From Date", (v) {
                                      from = v;
                                      _GetXController.from.value = v;
                                      reload();
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    from = null;
                                    _GetXController.from.value = "";
                                    reload();
                                  },
                                  icon: Icon(Icons.clear))
                            ],
                          ))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Obx(() => Row(
                            children: [
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "To Date",
                                  controller: TextEditingController(text: _GetXController.to.value),
                                  enabled: false,
                                  onTap: () {
                                    CIA_PopupDialog_DateOnlyPicker(context, "To Date", (v) {
                                      to = v;
                                      _GetXController.to.value = v;
                                      reload();
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    to = null;
                                    _GetXController.to.value = "";
                                    reload();
                                  },
                                  icon: Icon(Icons.clear))
                            ],
                          ))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CIA_DropDownSearch(
                          onSelect: (v) {
                            if (v.name == "Unpaid")
                              paid = false;
                            else if (v.name == "Paid")
                              paid = true;
                            else if (v.name == "None") paid = null;
                            reload();
                          },
                          label: 'Payment',
                          selectedItem: DropDownDTO(name: "None"),
                          items: [
                            DropDownDTO(name: "None"),
                            DropDownDTO(name: "Paid"),
                            DropDownDTO(name: "Unpaid"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CIA_DropDownSearch(
                          onSelect: (v) {
                            if (v.name == "In Queue")
                              statusEnum = EnumLabRequestStatus.InQueue;
                            else if (v.name == "In Progress")
                              statusEnum = EnumLabRequestStatus.InProgress;
                            else if (v.name == "Finished and Handled")
                              statusEnum = EnumLabRequestStatus.FinishedAndHandeled;
                            else if (v.name == "Finished Not Handled")
                              statusEnum = EnumLabRequestStatus.FinishedNotHandeled;
                            else if (v.name == "None") statusEnum = null;
                            reload();
                          },
                          label: 'Status',
                          selectedItem: DropDownDTO(name: "None"),
                          items: [
                            DropDownDTO(name: "None"),
                            DropDownDTO(name: "In Queue"),
                            DropDownDTO(name: "In Progress"),
                            DropDownDTO(name: "Finished and Handled"),
                            DropDownDTO(name: "Finished Not Handled"),
                          ],
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
          flex: 3,
          child: CIA_Table(
              columnNames: dataSource.columns,
              dataSource: dataSource,
              loadFunction: () async {
                sourceEnum = null;
                statusEnum = null;
                paid = null;
                from = null;
                to = null;
                search = "";
                var res = await reload();
                if (res.statusCode == 200)
                  _GetXController.inQueueCount.value = ((res.result) as List<LAB_RequestModel>)
                      .where((element) => element.status == EnumLabRequestStatus.InQueue)
                      .toList()
                      .length
                      .toString();

                return res;
              },
              onCellClick: (value) {

                context.goNamed(CIA_Router.routeConst_LabView,pathParameters: {"id":dataSource.models[value - 1].id.toString()});
              }),
        ),
      ],
    );*/
  }

  reload() async {
 //   var res = await dataSource.loadData(search: search, from: from, to: to, source: sourceEnum, status: statusEnum, paid: paid, myRequests: myRequests);
 //   if (res.statusCode == 200)
 //     _GetXController.inQueueCount.value =
 //         ((res.result) as List<LabRequestEntity>).where((element) => element.status == EnumLabRequestStatus.InQueue).toList().length.toString();

 //   return res;
  }
}
