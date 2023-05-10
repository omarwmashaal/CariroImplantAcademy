import 'package:cariro_implant_academy/API/AuthenticationAPI.dart';
import 'package:cariro_implant_academy/API/LoadinAPI.dart';
import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/CIA_RoomModel.dart';
import 'package:cariro_implant_academy/Pages/CIA_Pages/ViewUserPage.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/Horizontal_RadioButtons.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SlidingTab.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:popover/popover.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../API/UserAPI.dart';
import '../../Constants/Controllers.dart';
import '../../Models/DTOs/DropDownDTO.dart';
import '../../Models/Enum.dart';
import '../../Models/ImplantModel.dart';
import '../../Models/TacCompanyModel.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/CIA_SecondaryButton.dart';
import '../../Widgets/Title.dart';

class CIA_SettingsPage extends StatefulWidget {
  const CIA_SettingsPage({Key? key}) : super(key: key);

  @override
  State<CIA_SettingsPage> createState() => _CIA_SettingsPageState();
}

class _CIA_SettingsPageState extends State<CIA_SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => TitleWidget(
            title: siteController.title.value,
            showBackButton: false,
          ),
        ),
        Expanded(
          child: PageView(
            key: GlobalKey(),
            controller: tabsController,
            children: [
              //  ViewUserData(userId: siteController.getUser().idInt!),
              _SettingsPage(),
              //_UsersSettingsPage()
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    siteController.setAppBarWidget(tabs: ["My Profile", "Settings", "Users"]);
  }
}

class _MyProfile extends StatefulWidget {
  const _MyProfile({Key? key}) : super(key: key);

  @override
  State<_MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<_MyProfile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _SettingsPage extends StatefulWidget {
  const _SettingsPage({Key? key}) : super(key: key);

  @override
  State<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<_SettingsPage> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SidebarX(
          controller: SidebarXController(selectedIndex: currentIndex, extended: true),
          showToggleButton: false,
          extendedTheme: SidebarXTheme(
              width: 200,
              selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              decoration: BoxDecoration(
                border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
              )),
          items: [
            SidebarXItem(
                label: "Implants",
                onTap: () {
                  _pageController.jumpToPage(0);
                  currentIndex = 0;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Membranes",
                onTap: () {
                  _pageController.jumpToPage(1);
                  currentIndex = 1;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Tacs",
                onTap: () {
                  _pageController.jumpToPage(2);
                  currentIndex = 2;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Expenses Categories",
                onTap: () {
                  _pageController.jumpToPage(3);
                  currentIndex = 3;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Income Categories",
                onTap: () {
                  _pageController.jumpToPage(4);
                  currentIndex = 4;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Stock Categories",
                onTap: () {
                  _pageController.jumpToPage(5);
                  currentIndex = 5;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Suppliers",
                onTap: () {
                  _pageController.jumpToPage(6);
                  currentIndex = 6;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Payment Methods",
                onTap: () {
                  _pageController.jumpToPage(7);
                  currentIndex = 7;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Rooms",
                onTap: () {
                  _pageController.jumpToPage(8);
                  currentIndex = 8;
                },
                iconWidget: Container()),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: PageView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              var pages = [
                _ImplantsSettings(),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddMembraneCompanies(value);
                  },
                  addFunction2: (id, list) async {
                    return await SettingsAPI.AddMembranes(id, list);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetMembraneCompanies();
                  },
                  loadFunction2: (id) async {
                    return await SettingsAPI.GetMembranes(id);
                  },
                  label1: "Company",
                  label2: "Membrane",
                  field: "Size",
                ),
                _CommonSettingsWidget(
                    addFunction1: (value) async {
                      return await SettingsAPI.AddTacsCompanies(value);
                    },
                    loadFunction1: () async {
                      return await SettingsAPI.GetTacsCompanies();
                    },
                    label1: "Tacs",
                    anotherWidget: (list) {
                      var tempName = "";
                      var tempNumber = 0;
                      return Column(
                        children: [
                          Column(
                            children: (list as List<TacCompanyModel>)
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                list.removeWhere((element) => element.id == e.id);
                                                await SettingsAPI.AddTacsCompanies!(list);
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.remove)),
                                          Expanded(
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              onChange: (v) => e.name = v,
                                              controller: TextEditingController(text: e.name ?? ""),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: CIA_TextFormField(
                                              label: "Number",
                                              isNumber: true,
                                              onChange: (v) => e.number = int.parse(v),
                                              controller: TextEditingController(text: (e.number??0).toString()),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          Expanded(child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CIA_SecondaryButton(
                                  label: "Add Tac Company",
                                  onTab: () {
                                    CIA_ShowPopUp(
                                        context: context,
                                        child: StatefulBuilder(
                                          builder: (context, setState) {
                                            return Column(
                                              children: [
                                                CIA_TextFormField(
                                                  label: "Name",
                                                  controller: TextEditingController(text: tempName),
                                                  onChange: (value) => tempName = value,
                                                ),
                                                 SizedBox(height:10),
                                                 CIA_TextFormField(
                                                  label: "Number",
                                                  isNumber:true,
                                                  controller: TextEditingController(text: tempNumber.toString()),
                                                  onChange: (value) => tempNumber = int.parse(value),
                                                ),

                                              ],
                                            );
                                          },
                                        ),
                                        onSave: () async {
                                          list.add(TacCompanyModel(name: tempName,number: tempNumber));
                                          await SettingsAPI.AddTacsCompanies!(list);
                                          setState(() {});
                                        });
                                  }),
                              SizedBox(width: 10),
                              CIA_PrimaryButton(
                                  label: "Save Changes",
                                  isLong: true,
                                  onTab: () async {
                                    await SettingsAPI.AddTacsCompanies!(list).then((value) {
                                      if (value.statusCode == 200)
                                        ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                      else
                                        ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                    });
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ],
                      );
                    }),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddExpensesCategories(value);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetExpensesCategories();
                  },
                ),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddIncomeCategories(value);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetIncomeCategories();
                  },
                ),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddStockCategories(value);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetStockCategories();
                  },
                ),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddSuppliers(value);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetSuppliers();
                  },
                ),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddPaymentMethods(value);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetPaymentMethods();
                  },
                ),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.EditRooms(value);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetRooms();
                  },
                  anotherWidget: (list) {
                    var tempName = "";
                    return Column(
                      children: [
                        Column(
                          children: (list as List<CIA_RoomModel>)
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              list.removeWhere((element) => element.id == e.id);
                                              await SettingsAPI.EditRooms!(list);
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.remove)),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            label: "Value",
                                            onChange: (v) => e.name = v,
                                            controller: TextEditingController(text: e.name ?? ""),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Color selectedColor = e.color!;
                                            CIA_ShowPopUp(
                                                context: context,
                                                child: StatefulBuilder(builder: (context, mySetState) {
                                                  return Row(
                                                    children: () {
                                                      List<Widget> r = [];
                                                      List<Color> colors = [
                                                        Colors.red,
                                                        Colors.blue,
                                                        Colors.black,
                                                        Colors.orange,
                                                        Colors.brown,
                                                        Colors.indigo,
                                                        Colors.green,
                                                      ];
                                                      r.addAll(
                                                        colors.map(
                                                          (element) => GestureDetector(
                                                            onTap: () {
                                                              selectedColor = element;
                                                              mySetState(() {});
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets.all(5),
                                                              child: Container(
                                                                width: 30,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  color: element,
                                                                  border: Border.all(color: selectedColor == element ? Colors.yellow : element, width: 3),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      return r;
                                                    }(),
                                                  );
                                                }),
                                                onSave: () async {
                                                  e.color = selectedColor;
                                                  await SettingsAPI.EditRooms(list).then((value) {
                                                    if (value.statusCode == 200)
                                                      ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                                    else
                                                      ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                                  });
                                                  setState(() {});
                                                });
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            color: e.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CIA_SecondaryButton(
                                label: "Add Room",
                                onTab: () {
                                  Color selectedColor = Colors.red;
                                  CIA_ShowPopUp(
                                      context: context,
                                      child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return Column(
                                            children: [
                                              CIA_TextFormField(
                                                label: "Value",
                                                controller: TextEditingController(text: tempName),
                                                onChange: (value) => tempName = value,
                                              ),
                                              Row(
                                                children: () {
                                                  List<Widget> r = [];
                                                  List<Color> colors = [
                                                    Colors.red,
                                                    Colors.blue,
                                                    Colors.black,
                                                    Colors.orange,
                                                    Colors.brown,
                                                    Colors.indigo,
                                                    Colors.green,
                                                  ];
                                                  r.addAll(
                                                    colors.map(
                                                      (e) => GestureDetector(
                                                        onTap: () {
                                                          selectedColor = e;
                                                          ShowSnackBar(isSuccess: true, title: e.value.toString(), message: "");
                                                          setState(() {});
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.all(5),
                                                          child: Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                              color: e,
                                                              border: Border.all(color: selectedColor == e ? Colors.yellow : e, width: 3),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                  return r;
                                                }(),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      onSave: () async {
                                        list.add(CIA_RoomModel(name: tempName, color: selectedColor));
                                        await SettingsAPI.EditRooms!(list);
                                        setState(() {});
                                      });
                                }),
                            SizedBox(width: 10),
                            CIA_PrimaryButton(
                                label: "Save Changes",
                                isLong: true,
                                onTab: () async {
                                  await SettingsAPI.EditRooms!(list).then((value) {
                                    if (value.statusCode == 200)
                                      ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                    else
                                      ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                  });
                                  setState(() {});
                                }),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ];
              return pages[index];
            },
            controller: _pageController,
          ),
        )
      ],
    );
  }
}

class _ImplantsSettings extends StatefulWidget {
  const _ImplantsSettings({Key? key}) : super(key: key);

  @override
  State<_ImplantsSettings> createState() => _ImplantsSettingsState();
}

class _CommonSettingsWidget extends StatefulWidget {
  _CommonSettingsWidget(
      {Key? key,
      this.label1 = "",
      this.field,
      this.label2 = "",
      this.loadFunction1,
      this.loadFunction2,
      this.addFunction1,
      this.addFunction2,
      this.anotherWidget})
      : super(key: key);

  List<dynamic> list1 = [];
  int? selectedList1Id;
  List<DropDownDTO> list2 = [];
  Future<API_Response> Function()? loadFunction1;
  Future<API_Response> Function(dynamic?)? loadFunction2;
  Future<API_Response> Function(dynamic)? addFunction1;
  Future<API_Response> Function(dynamic?, dynamic?)? addFunction2;
  String label1;
  String label2;
  String? field;
  Function? anotherWidget;

  @override
  State<_CommonSettingsWidget> createState() => _CommonSettingsWidgetState();
}

class _CommonSettingsWidgetState extends State<_CommonSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: () {
        List<Widget> r = [];
        if (widget.loadFunction1 != null && widget.loadFunction2 != null) {
          r.add(CIA_FutureBuilder(
            loadFunction: widget.loadFunction1!()!,
            onSuccess: (data) {
              var tempName = "";
              if (widget.selectedList1Id == null) widget.list2 = [];
              widget.list1 = data as List<DropDownDTO>;
              return SidebarX(
                footerBuilder: (context, extended) => Column(
                  children: [
                    CIA_PrimaryButton(
                        label: "Add ${widget.label1}",
                        isLong: true,
                        onTab: () {
                          CIA_ShowPopUp(
                              context: context,
                              child: CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(),
                                onChange: (value) => tempName = value,
                              ),
                              onSave: () async {
                                widget.list1.add(DropDownDTO(name: tempName));
                                if (widget.addFunction1 != null)
                                  await widget.addFunction1!(widget.list1).then((value) {
                                    if (value.statusCode == 200)
                                      ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                    else
                                      ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                  });
                                setState(() {});
                              });
                        }),
                    SizedBox(height: 10),
                  ],
                ),
                headerBuilder: (context, extended) {
                  return Column(
                    children: [
                      FormTextKeyWidget(text: widget.label1),
                      FormTextValueWidget(
                        text: "Please click on item to view information",
                        secondaryInfo: true,
                        align: TextAlign.center,
                      )
                    ],
                  );
                },
                controller: SidebarXController(
                    selectedIndex: widget.list1!.indexWhere((element) => element.id == widget.selectedList1Id) != -1
                        ? widget.list1.indexWhere((element) => element.id == widget.selectedList1Id)
                        : 0,
                    extended: true),
                showToggleButton: false,
                extendedTheme: SidebarXTheme(
                    width: 200,
                    selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    decoration: BoxDecoration(
                      border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                    )),
                items: widget.list1
                    .map((e) => SidebarXItem(
                        label: e.name,
                        onTap: () {
                          widget.selectedList1Id = e.id!;
                          widget.list2 = [];
                          setState(() {});
                        },
                        iconWidget: IconButton(
                          onPressed: () {
                            showPopover(
                              context: context,
                              onPop: (() {}),
                              bodyBuilder: (context) => ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CIA_SecondaryButton(
                                        icon: Icon(Icons.remove),
                                        label: "Delete",
                                        onTab: () async {
                                          widget.list1.removeWhere((element) => element.id == e.id);
                                          if (widget.addFunction1 != null)
                                            await widget.addFunction1!(widget.list1).then((value) {
                                              if (value.statusCode == 200)
                                                ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                              else
                                                ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                            });
                                          setState(() {});
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CIA_SecondaryButton(
                                        icon: Icon(Icons.edit),
                                        label: "Rename",
                                        onTab: () {
                                          CIA_ShowPopUp(
                                              context: context,
                                              child: CIA_TextFormField(
                                                label: "New Name",
                                                controller: TextEditingController(text: e.name),
                                                onChange: (value) => tempName = value,
                                              ),
                                              onSave: () async {
                                                widget.list1.firstWhere((element) => element.id == e.id).name = tempName;
                                                if (widget.addFunction1 != null)
                                                  await widget.addFunction1!(widget.list1).then((value) {
                                                    if (value.statusCode == 200)
                                                      ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                                    else
                                                      ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                                  });
                                                setState(() {});
                                              });
                                        }),
                                  ),
                                ],
                              ),
                              direction: PopoverDirection.right,
                              backgroundColor: Colors.white,
                              width: 200,
                              height: 100,
                              arrowHeight: 15,
                              arrowWidth: 30,
                            );
                          },
                          icon: Icon(Icons.edit),
                        )))
                    .toList(),
              );
            },
          ));
          r.add(Expanded(
            child: CIA_FutureBuilder(
              loadFunction: widget.selectedList1Id == null
                  ? Future(() => API_Response(statusCode: 200, result: <DropDownDTO>[]))
                  : widget.loadFunction2!(widget.selectedList1Id),
              onSuccess: (data) {
                var tempName = "";
                widget.list2 = data as List<DropDownDTO>;
                return Column(
                  children: [
                    Column(
                      children: widget.list2
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          widget.list2.removeWhere((element) => element.id == e.id);
                                          if (widget.addFunction2 != null)
                                            await widget.addFunction2!(widget.selectedList1Id, widget.list2).then((value) {
                                              if (value.statusCode == 200)
                                                ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                              else
                                                ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                            });
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.remove)),
                                    Expanded(
                                        child: CIA_TextFormField(
                                      label: widget.field ?? "Name",
                                      controller: TextEditingController(text: e.name ?? ""),
                                      onChange: (v) => e.name = v,
                                    )),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    Expanded(child: SizedBox()),
                    widget.selectedList1Id == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CIA_SecondaryButton(
                                  label: "Add ${widget.label2}",
                                  onTab: () {
                                    CIA_ShowPopUp(
                                        context: context,
                                        child: CIA_TextFormField(
                                          label: "Value",
                                          controller: TextEditingController(),
                                          onChange: (value) => tempName = value,
                                        ),
                                        onSave: () async {
                                          widget.list2.add(DropDownDTO(name: tempName));
                                          if (widget.addFunction2 != null)
                                            await widget.addFunction2!(widget.selectedList1Id, widget.list2).then((value) {
                                              if (value.statusCode == 200)
                                                ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                              else
                                                ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                            });
                                          setState(() {});
                                        });
                                  }),
                              SizedBox(width: 10),
                              CIA_PrimaryButton(
                                  label: "Save Changes",
                                  isLong: true,
                                  onTab: () async {
                                    if (widget.addFunction2 != null)
                                      await widget.addFunction2!(widget.selectedList1Id, widget.list2).then((value) {
                                        if (value.statusCode == 200)
                                          ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                        else
                                          ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                      });
                                    setState(() {});
                                  }),
                            ],
                          ),
                  ],
                );
              },
            ),
          ));
        } else if (widget.loadFunction1 != null && widget.anotherWidget != null) {
          r.add(Expanded(
            child: CIA_FutureBuilder(
              loadFunction: widget.loadFunction1!(),
              onSuccess: (data) {
                var tempName = "";

                widget.list1 = data as List<dynamic>;
                return widget.anotherWidget!(widget.list1);
              },
            ),
          ));
        } else if (widget.loadFunction1 != null) {
          r.add(Expanded(
            child: CIA_FutureBuilder(
              loadFunction: widget.loadFunction1!(),
              onSuccess: (data) {
                var tempName = "";

                widget.list1 = data as List<DropDownDTO>;
                return Column(
                  children: [
                    Column(
                      children: widget.list1
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          widget.list1.removeWhere((element) => element.id == e.id);
                                          if (widget.addFunction1 != null)
                                            await widget.addFunction1!(widget.list1).then((value) {
                                              if (value.statusCode == 200)
                                                ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                              else
                                                ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                            });
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.remove)),
                                    Expanded(
                                        child: CIA_TextFormField(
                                      label: widget.field ?? "Value",
                                      controller: TextEditingController(text: e.name ?? ""),
                                      onChange: (v) => e.name = v,
                                    )),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CIA_SecondaryButton(
                            label: "Add ${widget.label2}",
                            onTab: () {
                              CIA_ShowPopUp(
                                  context: context,
                                  child: CIA_TextFormField(
                                    label: "Value",
                                    controller: TextEditingController(),
                                    onChange: (value) => tempName = value,
                                  ),
                                  onSave: () async {
                                    widget.list1.add(DropDownDTO(name: tempName));
                                    if (widget.addFunction1 != null)
                                      await widget.addFunction1!(widget.list1).then((value) {
                                        if (value.statusCode == 200)
                                          ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                        else
                                          ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                      });
                                    setState(() {});
                                  });
                            }),
                        SizedBox(width: 10),
                        CIA_PrimaryButton(
                            label: "Save Changes",
                            isLong: true,
                            onTab: () async {
                              if (widget.addFunction1 != null)
                                await widget.addFunction1!(widget.list1).then((value) {
                                  if (value.statusCode == 200)
                                    ShowSnackBar(isSuccess: true, title: "Success", message: "");
                                  else
                                    ShowSnackBar(isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                });
                              setState(() {});
                            }),
                      ],
                    ),
                  ],
                );
              },
            ),
          ));
        }

        return r;
      }(),
    );
  }
}

class _ImplantsSettingsState extends State<_ImplantsSettings> {
  List<DropDownDTO> list1 = [];
  int selectedList1Id = 0;
  List<DropDownDTO> list2 = [];
  int selectedList2Id = 0;
  List<ImplantModel> implants = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CIA_FutureBuilder(
          loadFunction: SettingsAPI.GetImplantCompanies(),
          onSuccess: (data) {
            var tempName = "";
            if (selectedList1Id == 0) list2 = [];
            list1 = data as List<DropDownDTO>;
            return SidebarX(
              footerBuilder: (context, extended) => CIA_PrimaryButton(
                  label: "Add Company",
                  isLong: true,
                  onTab: () {
                    CIA_ShowPopUp(
                        context: context,
                        child: CIA_TextFormField(
                          label: "Name",
                          controller: TextEditingController(),
                          onChange: (value) => tempName = value,
                        ),
                        onSave: () async {
                          await SettingsAPI.AddImplantCompanies(tempName);
                          setState(() {});
                        });
                  }),
              headerBuilder: (context, extended) {
                return FormTextKeyWidget(text: "Implant Companies");
              },
              controller: SidebarXController(
                  selectedIndex:
                      list1.indexWhere((element) => element.id == selectedList1Id) != -1 ? list1.indexWhere((element) => element.id == selectedList1Id) : 0,
                  extended: true),
              showToggleButton: false,
              extendedTheme: SidebarXTheme(
                  width: 200,
                  selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                  )),
              items: list1
                  .map((e) => SidebarXItem(
                      label: e.name,
                      onTap: () {
                        selectedList1Id = e.id!;
                        selectedList2Id = 0;
                        list2 = [];
                        setState(() {});
                      },
                      iconWidget: Container()))
                  .toList(),
            );
          },
        ),
        CIA_FutureBuilder(
          loadFunction:
              selectedList1Id == 0 ? Future(() => API_Response(statusCode: 200, result: <DropDownDTO>[])) : SettingsAPI.GetImplantLines(selectedList1Id),
          onSuccess: (data) {
            list2 = data as List<DropDownDTO>;
            var tempName = "";
            return SidebarX(
              footerBuilder: (context, extended) => selectedList1Id == 0
                  ? Container()
                  : CIA_PrimaryButton(
                      label: "Add Line",
                      isLong: true,
                      onTab: () {
                        CIA_ShowPopUp(
                            context: context,
                            child: CIA_TextFormField(
                              label: "Name",
                              controller: TextEditingController(),
                              onChange: (value) => tempName = value,
                            ),
                            onSave: () async {
                              await SettingsAPI.AddImplantLines(selectedList1Id, tempName);
                              setState(() {});
                            });
                      }),
              headerBuilder: (context, extended) {
                return FormTextKeyWidget(text: "Implant Lines");
              },
              controller: SidebarXController(
                  selectedIndex:
                      list2.indexWhere((element) => element.id == selectedList2Id) != -1 ? list2.indexWhere((element) => element.id == selectedList2Id) : 0,
                  extended: true),
              showToggleButton: false,
              extendedTheme: SidebarXTheme(
                  width: 200,
                  selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  decoration: BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                  )),
              items: list2
                  .map((e) => SidebarXItem(
                      label: e.name,
                      onTap: () {
                        selectedList2Id = e.id!;
                        implants = [];
                        setState(() {});
                      },
                      iconWidget: Container()))
                  .toList(),
            );
          },
        ),
        Expanded(
          child: CIA_FutureBuilder(
            loadFunction:
                selectedList2Id == 0 ? Future(() => API_Response(statusCode: 200, result: <ImplantModel>[])) : SettingsAPI.GetImplants(selectedList2Id),
            onSuccess: (data) {
              var tempName = "";
              implants = data as List<ImplantModel>;
              return Column(
                children: [
                  Column(
                    children: implants
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CIA_TextFormField(label: "Size", controller: TextEditingController(text: e.size ?? "")),
                            ))
                        .toList(),
                  ),
                  Expanded(child: SizedBox()),
                  selectedList2Id == 0
                      ? Container()
                      : CIA_PrimaryButton(
                          label: "Add Implant",
                          isLong: true,
                          onTab: () {
                            CIA_ShowPopUp(
                                context: context,
                                child: CIA_TextFormField(
                                  label: "Size : mXn",
                                  controller: TextEditingController(),
                                  onChange: (value) => tempName = value,
                                ),
                                onSave: () async {
                                  implants.add(ImplantModel(size: tempName));
                                  await SettingsAPI.AddImplants(selectedList2Id, implants);
                                  setState(() {});
                                });
                          }),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class _MembranesSettings extends StatefulWidget {
  const _MembranesSettings({Key? key}) : super(key: key);

  @override
  State<_MembranesSettings> createState() => _MembranesSettingsState();
}

class _MembranesSettingsState extends State<_MembranesSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TacsSettings extends StatefulWidget {
  const _TacsSettings({Key? key}) : super(key: key);

  @override
  State<_TacsSettings> createState() => _TacsSettingsState();
}

class _TacsSettingsState extends State<_TacsSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _ExpensesCategoriesSettings extends StatefulWidget {
  const _ExpensesCategoriesSettings({Key? key}) : super(key: key);

  @override
  State<_ExpensesCategoriesSettings> createState() => _ExpensesCategoriesSettingsState();
}

class _ExpensesCategoriesSettingsState extends State<_ExpensesCategoriesSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _IncomeCategoriesSettings extends StatefulWidget {
  const _IncomeCategoriesSettings({Key? key}) : super(key: key);

  @override
  State<_IncomeCategoriesSettings> createState() => _IncomeCategoriesSettingsState();
}

class _IncomeCategoriesSettingsState extends State<_IncomeCategoriesSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _StockCategoriesSettings extends StatefulWidget {
  const _StockCategoriesSettings({Key? key}) : super(key: key);

  @override
  State<_StockCategoriesSettings> createState() => _StockCategoriesSettingsState();
}

class _StockCategoriesSettingsState extends State<_StockCategoriesSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _SuppliersSettings extends StatefulWidget {
  const _SuppliersSettings({Key? key}) : super(key: key);

  @override
  State<_SuppliersSettings> createState() => _SuppliersSettingsState();
}

class _SuppliersSettingsState extends State<_SuppliersSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _PaymentMethodsSettings extends StatefulWidget {
  const _PaymentMethodsSettings({Key? key}) : super(key: key);

  @override
  State<_PaymentMethodsSettings> createState() => _PaymentMethodsSettingsState();
}

class _PaymentMethodsSettingsState extends State<_PaymentMethodsSettings> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _UsersSettingsPage extends StatefulWidget {
  const _UsersSettingsPage({Key? key}) : super(key: key);

  @override
  State<_UsersSettingsPage> createState() => _UsersSettingsPageState();
}

class _UsersSettingsPageState extends State<_UsersSettingsPage> {
  TabsController controller = TabsController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: SizedBox()),
            SlidingTab(
              titles: [
                "Admins",
                "Instructors",
                "Assistants",
                "Candidates",
                "Secretaries",
              ],
              weight: 800,
              controller: controller,
              onChange: (value) {
                controller.jumpToPage(value);
              },
            ),
            Expanded(child: SizedBox()),
            CIA_SecondaryButton(
                label: "Add new",
                onTab: () {
                  var role = "";
                  if (controller.index.value == 0)
                    role = "admin";
                  else if (controller.index.value == 1)
                    role = "instructor";
                  else if (controller.index.value == 2)
                    role = "assistant";
                  else if (controller.index.value == 3)
                    role = "candidate";
                  else if (controller.index.value == 4) role = "secretary";
                  ApplicationUserModel newUser = ApplicationUserModel(role: role, gender: "Male");
                  bool newBatch = false;
                  CIA_ShowPopUp(
                    title: "Add new $role",
                    height: 600,
                    context: context,
                    child: StatefulBuilder(builder: (context, setState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CIA_TextFormField(
                                label: "Name",
                                controller: TextEditingController(text: newUser.name ?? ""),
                                onChange: (value) => newUser.name = value,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Visibility(
                                visible: controller.index.value != 3,
                                child: CIA_TextFormField(
                                  label: "Email",
                                  controller: TextEditingController(text: newUser.email ?? ""),
                                  onChange: (value) => newUser.email = value,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.index.value != 3,
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: FormTextValueWidget(
                                    text: r"Default passowrd: Pa$$word1",
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: HorizontalRadioButtons(
                                  names: ["Male", "Female"],
                                  groupValue: "Male",
                                  onChange: (v) {
                                    newUser.gender = v;
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CIA_TextFormField(
                                label: "Phone Number",
                                isNumber: true,
                                controller: TextEditingController(text: newUser.phoneNumber ?? ""),
                                onChange: (value) => newUser.phoneNumber = value,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CIA_TextFormField(
                                onTap: () {
                                  CIA_PopupDialog_DateOnlyPicker(context, "Birthday", (v) {
                                    setState(() {
                                      newUser.dateOfBirth = v;
                                    });
                                  });
                                },
                                label: "Date of Birth",
                                controller: TextEditingController(text: newUser.dateOfBirth ?? ""),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CIA_TextFormField(
                                label: "Graduated From",
                                controller: TextEditingController(text: newUser.graduatedFrom ?? ""),
                                onChange: (value) => newUser.graduatedFrom = value,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CIA_TextFormField(
                                label: "Class Year",
                                controller: TextEditingController(text: newUser.classYear ?? ""),
                                onChange: (value) => newUser.classYear = value,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CIA_TextFormField(
                                label: "Speciality",
                                controller: TextEditingController(text: newUser.speciality ?? ""),
                                onChange: (value) => newUser.speciality = value,
                              ),
                            ),
                            Visibility(
                              visible: controller.index.value == 3,
                              child: Column(
                                children: [
                                  CIA_MultiSelectChipWidget(
                                    onChange: (item, isSelected) {
                                      if (isSelected)
                                        newUser.batchId = null;
                                      else
                                        newUser.batch = null;
                                      setState(() => newBatch = isSelected);
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                        label: "New Batch",
                                      ),
                                    ],
                                  ),
                                  newBatch
                                      ? Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_TextFormField(
                                            label: "New Batch Name",
                                            controller: TextEditingController(text: newUser.batch == null ? "" : newUser.batch!.name ?? ""),
                                            onChange: (value) {
                                              newUser.batch = DropDownDTO(name: value);
                                              newUser.batchId = null;
                                            },
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CIA_DropDownSearch(
                                            asyncItems: LoadinAPI.LoadCandidatesBatches,
                                            label: "Batch",
                                            onSelect: (value) {
                                              newUser.batchId = value.id;
                                              newUser.batch = null;
                                            },
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    onSave: () async {
                      if (role == "candidate") {
                        await UserAPI.AddCandidate(newUser);
                      } else {
                        await AuthenticationAPI.Register(newUser);
                      }
                      setState(() {});
                    },
                  );
                })
          ],
        ),
        Expanded(
          child: PageView(
            controller: controller,
            children: [
              _buildWidget(UserRoles.Admin),
              _buildWidget(UserRoles.Instructor),
              _buildWidget(UserRoles.Assistant),
              _buildWidget(UserRoles.Candidate),
              _buildWidget(UserRoles.Secretary),
            ],
          ),
        )
      ],
    );
  }

  _buildWidget(UserRoles type) {
    ApplicationUserDataSource dataSource = ApplicationUserDataSource(type: type);
    return CIA_Table(
      columnNames: dataSource.columns,
      dataSource: dataSource,
      loadFunction: dataSource.loadData,
    );
  }
}
