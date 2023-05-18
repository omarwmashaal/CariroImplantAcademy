import 'package:cariro_implant_academy/API/LAB_RequestsAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Models/LAB_RequestModel.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_CreateNewLabRequest.dart';
import 'package:cariro_implant_academy/Pages/LAB_Pages/LAB_ViewRequest.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/TabsLayout.dart';
import 'package:cariro_implant_academy/Widgets/Title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Widgets/CIA_Table.dart';
import '../../Widgets/CIA_TextField.dart';
import '../../Widgets/Horizontal_RadioButtons.dart';
import 'LAB_ViewTask.dart';

class _GetXController extends GetxController {
  static RxString inQueueCount = "0".obs;
  static RxString from = "".obs;
  static RxString to = "".obs;
}

class LabRequestsSearchPage extends StatefulWidget {
  const LabRequestsSearchPage({Key? key}) : super(key: key);

  @override
  State<LabRequestsSearchPage> createState() => _LabRequestsSearchPageState();
}

class _LabRequestsSearchPageState extends State<LabRequestsSearchPage> {
  LabRequestDataSource dataSource = LabRequestDataSource();
  EnumLabRequestStatus? statusEnum;
  EnumLabRequestSources? sourceEnum;
  bool? paid;
  String? from;
  String? to;
  String search = "";
  late LAB_RequestModel selectedTodayLabRequests = LAB_RequestModel();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        var pages = [
          PageView(
            controller: tabsController,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(() => TitleWidget(title: siteController.title.value)),
                      Expanded(child: SizedBox()),
                      CIA_PrimaryButton(
                        width: 155,
                        label: "Add new request",
                        onTab: () {
                          internalPagesController.jumpToPage(2);
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
                          return reload();
                        },
                        onCellClick: (value) {
                          print(dataSource.models[value - 1].id);
                          selectedTodayLabRequests = dataSource.models[value - 1];

                          internalPagesController.jumpToPage(1);
                        }),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(() => TitleWidget(title: siteController.title.value)),
                      Expanded(child: SizedBox()),
                      CIA_PrimaryButton(
                        width: 155,
                        label: "Add new request",
                        onTab: () {
                          internalPagesController.jumpToPage(2);
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
                          var res = await LAB_RequestsAPI.GetAllRequests();
                          if (res.statusCode == 200)
                            _GetXController.inQueueCount.value = ((res.result) as List<LAB_RequestModel>)
                                .where((element) => element.status == EnumLabRequestStatus.InQueue)
                                .toList()
                                .length
                                .toString();

                          return dataSource.loadData(
                            search: search,
                            from: DateTime.now().toString(),
                            to: DateTime.now().toString(),
                            source: sourceEnum,
                            status: statusEnum,
                            paid: paid,
                          );
                        },
                        onCellClick: (value) {
                          print(dataSource.models[value - 1].id);
                          selectedTodayLabRequests = dataSource.models[value - 1];
                          internalPagesController.jumpToPage(1);
                        }),
                  ),
                ],
              ),
            ],
          ),
          siteController.getRole() == "technician" ? LAB_ViewTaskPage(id:selectedTodayLabRequests!.id??0) : LAB_ViewRequestPage(request: selectedTodayLabRequests),
          LAB_CreateNewLabRequest()
        ];
        return pages[index];
      },
      itemCount: 3,
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget(tabs: ["Today's Requests", "All Requests"]);
  }

  reload() async {
    var res = await dataSource.loadData(
      search: search,
      from: DateTime.now().toString(),
      to: DateTime.now().toString(),
      source: sourceEnum,
      status: statusEnum,
      paid: paid,
    );
    if (res.statusCode == 200)
      _GetXController.inQueueCount.value =
          ((res.result) as List<LAB_RequestModel>).where((element) => element.status == EnumLabRequestStatus.InQueue).toList().length.toString();

    return res;
  }
}
