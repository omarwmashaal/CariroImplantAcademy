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

import '../../API/StockAPI.dart';
import '../../API/UserAPI.dart';
import '../../Constants/Controllers.dart';
import '../../Models/DTOs/DropDownDTO.dart';
import '../../Models/Enum.dart';
import '../../Models/ImplantModel.dart';
import '../../Models/MedicalModels/TreatmentPrices.dart';
import '../../Models/StockModel.dart';
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
        TitleWidget(
          title: "Settings",
          showBackButton: true,
          mainPages: true,
        ),
        Expanded(
          child: PageView(
            key: GlobalKey(),
            children: [
              //ViewUserData(userId: siteController.getUser().idInt!),
              SettingsPage(),
              UsersSettingsPage()
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {}
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

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static String routeName = "Settings";
  static String routePath = "Settings";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              width: 300,
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
                label: "Screws",
                onTap: () {
                  _pageController.jumpToPage(8);
                  currentIndex = 8;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Rooms",
                onTap: () {
                  _pageController.jumpToPage(9);
                  currentIndex = 9;
                },
                iconWidget: Container()),
            SidebarXItem(
                label: "Treatment Prices",
                onTap: () {
                  _pageController.jumpToPage(10);
                  currentIndex = 10;
                },
                iconWidget: Container()),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: PageView.builder(
            itemCount: 11,
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
                      (list as List<TacCompanyModel>).add(TacCompanyModel());
                      return Column(
                        children: [
                          StatefulBuilder(
                            builder: (context,mySetState) {
                              return Expanded(
                                child: ListView(
                                  children: (list as List<TacCompanyModel>)
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      list.removeWhere((element) => element.id == e.id);
                                                      list.removeWhere((element) => element.name==""||element.name==null);
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
                                                    onChange: (v) => e.count = int.parse(v),
                                                    controller: TextEditingController(text: (e.count ?? 0).toString()),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      if(list.last.name!=null&&list.last.name!="")
                                                        {
                                                          list.add(TacCompanyModel());
                                                          mySetState(() {});
                                                        }
                                                    },
                                                    icon: Icon(Icons.add)),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              );
                            }
                          ),
                          CIA_PrimaryButton(
                              label: "Save Changes",
                              isLong: true,
                              onTab: () async {
                                list.removeWhere((x)=>x.name==null||x.name=="");
                                await SettingsAPI.AddTacsCompanies!(list).then((value) {
                                  if (value.statusCode == 200)
                                    ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                  else
                                    ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                });
                                setState(() {});
                              }),
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
                    return Future.value();
                  },
                  loadFunction1: () async {
                    return await StockAPI.GetStockByName("Screws");
                  },
                  anotherWidget: (item) {
                    int extraNumber = 0;
                    return Column(
                      children: [
                        Row(
                          children: [
                            FormTextKeyWidget(text: "Screws"),
                            SizedBox(width: 10),
                            FormTextValueWidget(text: ((item as StockModel).count).toString())
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CIA_SecondaryButton(
                                label: "Add Screws",
                                onTab: () {
                                  CIA_ShowPopUp(
                                      context: context,
                                      child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return CIA_TextFormField(
                                            label: "Extra number",
                                            isNumber: true,
                                            controller: TextEditingController(text: extraNumber.toString()),
                                            onChange: (value) => extraNumber = int.parse(value),
                                          );
                                        },
                                      ),
                                      onSave: () async {
                                        await StockAPI.AddItem(
                                          StockModel(name: "Screws", count: extraNumber, category: DropDownDTO(name: "Screws")),
                                        );
                                        setState(() {});
                                      });
                                }),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    );
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
                                              list.removeWhere((element) => element.name==""||element.name==null);

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
                                                      ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                                    else
                                                      ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
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
                                      ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                    else
                                      ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                  });
                                  setState(() {});
                                }),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                CIA_FutureBuilder(
                  loadFunction: SettingsAPI.GetTreatmentPrices(),
                  onSuccess: (data) {
                    var prices = data as TreatmentPrices;
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Extraction",
                          controller: TextEditingController(
                            text: (prices.extraction ?? 0).toString(),
                          ),
                          isNumber: true,
                          suffix: "EGP",
                          onChange: (v) => prices.extraction = int.parse(v),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Scaling",
                          controller: TextEditingController(
                            text: (prices.scaling ?? 0).toString(),
                          ),
                          isNumber: true,
                          suffix: "EGP",
                          onChange: (v) => prices.scaling = int.parse(v),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Crown",
                          controller: TextEditingController(
                            text: (prices.crown ?? 0).toString(),
                          ),
                          isNumber: true,
                          suffix: "EGP",
                          onChange: (v) => prices.crown = int.parse(v),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Restoration",
                          controller: TextEditingController(
                            text: (prices.restoration ?? 0).toString(),
                          ),
                          isNumber: true,
                          suffix: "EGP",
                          onChange: (v) => prices.restoration = int.parse(v),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_TextFormField(
                          label: "Root Canal Treatment",
                          controller: TextEditingController(
                            text: (prices.rootCanalTreatment ?? 0).toString(),
                          ),
                          isNumber: true,
                          suffix: "EGP",
                          onChange: (v) => prices.rootCanalTreatment = int.parse(v),
                        ),
                        Expanded(child: SizedBox()),
                        CIA_TextFormField(
                          label: "Other",
                          controller: TextEditingController(
                            text: (prices.other ?? 0).toString(),
                          ),
                          isNumber: true,
                          suffix: "EGP",
                          onChange: (v) => prices.other = int.parse(v),
                        ),
                        Expanded(child: SizedBox()),
                        CIA_PrimaryButton(
                            label: "Save",
                            onTab: () async {
                              await SettingsAPI.EditTreatmentPrices(prices).then((value) {
                                if (value.statusCode == 200)
                                  ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                else
                                  ShowSnackBar(context, isSuccess: false, title: "Failed", message: "");
                              });
                              setState(() {});
                            })
                      ],
                    );
                  },
                )
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
                                      ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                    else
                                      ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
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
                    width: 300,
                    selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    decoration: BoxDecoration(
                      border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                    )),
                items: widget.list1
                    .map((e) => SidebarXItem(
                        label: e.id,
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
                                          widget.list1.removeWhere((element) => element.id==""||element.id==null);

                                          if (widget.addFunction1 != null)
                                            await widget.addFunction1!(widget.list1).then((value) {
                                              if (value.statusCode == 200)
                                                ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                              else
                                                ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
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
                                                controller: TextEditingController(text: e.id),
                                                onChange: (value) => tempName = value,
                                              ),
                                              onSave: () async {
                                                widget.list1.firstWhere((element) => element.id == e.id).id = tempName;
                                                if (widget.addFunction1 != null)
                                                  await widget.addFunction1!(widget.list1).then((value) {
                                                    if (value.statusCode == 200)
                                                      ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                                    else
                                                      ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                                  });
                                                setState(() {});
                                              });
                                        }),
                                  ),
                                ],
                              ),
                              direction: PopoverDirection.right,
                              backgroundColor: Colors.white,
                              width: 300,
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
                widget.list2.add(DropDownDTO());
                return widget.selectedList1Id == null
                    ? Container()
                    :Column(
                  children: [
                    StatefulBuilder(
                      builder: (context,mySetState) {
                        return Expanded(
                          child: ListView(
                            children: widget.list2
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                widget.list2.removeWhere((element) => element.id == e.id);
                                                widget.list2.removeWhere((element) => element.name==""||element.name==null);

                                                if (widget.addFunction2 != null)
                                                  await widget.addFunction2!(widget.selectedList1Id, widget.list2).then((value) {
                                                    if (value.statusCode == 200)
                                                      ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                                    else
                                                      ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
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
                                          IconButton(onPressed: (){
                                            if(widget.list2.last.name!=null&&widget.list2.last.name!="")
                                              {
                                                widget.list2.add(DropDownDTO());
                                                mySetState((){});
                                              }
                                          }, icon: Icon(Icons.add))
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      }
                    ),
                     CIA_PrimaryButton(
                            label: "Save Changes",
                            isLong: true,
                            onTab: () async {
                              widget.list2.removeWhere((element) => element.name==null||element.name=="");
                              if (widget.addFunction2 != null)
                                await widget.addFunction2!(widget.selectedList1Id, widget.list2).then((value) {
                                  if (value.statusCode == 200)
                                    ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                  else
                                    ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                });
                              setState(() {});
                            }),
                  ],
                );
              },
            ),
          ));
        }
        else if (widget.loadFunction1 != null && widget.anotherWidget != null) {
          r.add(Expanded(
            child: CIA_FutureBuilder(
              loadFunction: widget.loadFunction1!(),
              onSuccess: (data) {
                var tempName = "";
                try {
                  widget.list1 = data as List<dynamic>;
                  return widget.anotherWidget!(widget.list1);
                } catch (e) {
                  return widget.anotherWidget!(data);
                }
              },
            ),
          ));
        }
        else if (widget.loadFunction1 != null) {
          r.add(Expanded(
            child: CIA_FutureBuilder(
              loadFunction: widget.loadFunction1!(),
              onSuccess: (data) {
                var tempName = "";

                widget.list1 = data as List<DropDownDTO>;
                widget.list1.add(DropDownDTO());
                return Column(
                  children: [
                    Expanded(
                      child: StatefulBuilder(
                        builder: (context,mySetState) {
                          return ListView(
                            children: widget.list1
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                widget.list1.removeWhere((element) => element.id == e.id);
                                                widget.list1.removeWhere((element) => element.id==""||element.id==null);
                                                if (widget.addFunction1 != null)
                                                  await widget.addFunction1!(widget.list1).then((value) {
                                                    if (value.statusCode == 200)
                                                      ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                                                    else
                                                      ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                                                  });
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.remove)),
                                          Expanded(
                                              child: CIA_TextFormField(
                                            label: widget.field ?? "Value",
                                            controller: TextEditingController(text: e.id ?? ""),
                                            onChange: (v) => e.id = v,
                                          )),
                                          IconButton(
                                              onPressed: ()  {
                                                if(widget.list1.last.id!=null&&widget.list1.last.id!="")
                                                  {
                                                    widget.list1.add(DropDownDTO());
                                                    mySetState((){});
                                                  }
                                              },
                                              icon: Icon(Icons.add)),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          );
                        }
                      ),
                    ),
                    CIA_PrimaryButton(
                        label: "Save Changes",
                        isLong: true,
                        onTab: () async {
                          widget.list1.removeWhere((element) => element.id==""||element.id==null);
                          if (widget.addFunction1 != null)
                            await widget.addFunction1!(widget.list1).then((value) {
                              if (value.statusCode == 200)
                                ShowSnackBar(context, isSuccess: true, title: "Success", message: "");
                              else
                                ShowSnackBar(context, isSuccess: false, title: "Faild", message: value.errorMessage ?? "");
                            });
                          setState(() {});
                        }),
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
                  width: 300,
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
                  width: 300,
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
              implants.add(ImplantModel());
              return selectedList2Id == 0
                  ? Container()
                  : Column(
                      children: [
                        StatefulBuilder(
                            builder: (context, mySetState) => Expanded(
                              child: ListView(
                                    children: implants
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Expanded(child: CIA_TextFormField(label: "Size",onChange: (v)=>e.size=v, controller: TextEditingController(text: e.size ?? ""))),
                                                  IconButton(
                                                      onPressed: () {

                                                        if (implants.last.size != "" && implants.last.size != null)
                                                        {
                                                          implants.add(ImplantModel());
                                                          mySetState(() {});
                                                        }
                                                      },
                                                      icon: Icon(Icons.add)),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                            )),
                        CIA_PrimaryButton(
                            label: "Save",
                            isLong: true,
                            onTab: () async {
                              implants.removeWhere((element) => element.size == null || element.size == "");
                              await SettingsAPI.AddImplants(selectedList2Id, implants);
                              setState(() {});
                              /*CIA_ShowPopUp(
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
                                });*/
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

class UsersSettingsPage extends StatefulWidget {
  const UsersSettingsPage({Key? key}) : super(key: key);
  static String routeName = "UsersSettings";
  static String routePath = "UsersSettings";

  @override
  State<UsersSettingsPage> createState() => _UsersSettingsPageState();
}

class _UsersSettingsPageState extends State<UsersSettingsPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CIA_SecondaryButton(
            label: "Add new",
            onTab: () {
              var role = "";
              if (tabController.index == 0)
                role = "admin";
              else if (tabController.index == 1)
                role = "instructor";
              else if (tabController.index == 2)
                role = "assistant";
              else if (tabController.index == 3)
                role = "candidate";
              else if (tabController.index == 4) role = "secretary";
              else if (tabController.index == 5) role = "labmoderator";
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
                            visible: tabController.index != 3,
                            child: CIA_TextFormField(
                              label: "Email",
                              controller: TextEditingController(text: newUser.email ?? ""),
                              onChange: (value) => newUser.email = value,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: tabController.index != 3,
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
                        Visibility(
                          visible: role != "secretary",
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CIA_TextFormField(
                              label: "Graduated From",
                              controller: TextEditingController(text: newUser.graduatedFrom ?? ""),
                              onChange: (value) => newUser.graduatedFrom = value,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: role != "secretary",
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CIA_TextFormField(
                              label: "Class Year",
                              controller: TextEditingController(text: newUser.classYear ?? ""),
                              onChange: (value) => newUser.classYear = value,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: role != "secretary",
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CIA_TextFormField(
                              label: "Speciality",
                              controller: TextEditingController(text: newUser.speciality ?? ""),
                              onChange: (value) => newUser.speciality = value,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: tabController.index == 3,
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
                  await AuthenticationAPI.Register(newUser);

                  setState(() {});
                },
              );
            }),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: TabBar(
                  onTap: (value) {
                    setState(() {});
                  },
                  controller: tabController,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Admins",
                    ),
                    Tab(
                      text: "Instructor",
                    ),
                    Tab(
                      text: "Assistants",
                    ),
                    Tab(
                      text: "Candidates",
                    ),
                    Tab(
                      text: "Secretaries",
                    ),
                    Tab(
                      text: "Lab Moderators",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _buildWidget(UserRoles.Admin),
                    _buildWidget(UserRoles.Instructor),
                    _buildWidget(UserRoles.Assistant),
                    _buildWidget(UserRoles.Candidate),
                    _buildWidget(UserRoles.Secretary),
                    _buildWidget(UserRoles.LabModerator),
                  ],
                ),
              ),
            ],
          ),
        ),
        /* Row(
          children: [
            Expanded(child: SizedBox()),


        ),*/
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

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
  }
}
