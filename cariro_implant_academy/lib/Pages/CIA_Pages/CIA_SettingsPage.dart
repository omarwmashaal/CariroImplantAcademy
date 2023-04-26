import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:popover/popover.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../Constants/Controllers.dart';
import '../../Models/DTOs/DropDownDTO.dart';
import '../../Models/ImplantModel.dart';
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
              //_MyProfile(),
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
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: PageView.builder(
            itemCount: 8,
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
                ),
                _CommonSettingsWidget(
                  addFunction1: (value) async {
                    return await SettingsAPI.AddTacsCompanies(value);
                  },
                  addFunction2: (id, list) async {
                    return await SettingsAPI.AddTacs(id, list);
                  },
                  loadFunction1: () async {
                    return await SettingsAPI.GetTacsCompanies();
                  },
                  loadFunction2: (id) async {
                    return await SettingsAPI.GetTacs(id);
                  },
                  label1: "Company",
                  label2: "Tacs",
                ),
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
  _CommonSettingsWidget({
    Key? key,
    this.label1 = "",
    this.label2 = "",
    this.loadFunction1,
    this.loadFunction2,
    this.addFunction1,
    this.addFunction2,
  }) : super(key: key);

  List<DropDownDTO> list1 = [];
  int? selectedList1Id;
  List<DropDownDTO> list2 = [];
  Future<API_Response> Function()? loadFunction1;
  Future<API_Response> Function(dynamic?)? loadFunction2;
  Future<API_Response> Function(List<DropDownDTO> list)? addFunction1;
  Future<API_Response> Function(dynamic?, dynamic?)? addFunction2;
  String label1;
  String label2;

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
                                if (widget.addFunction1 != null) await widget.addFunction1!(widget.list1);
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
                                    child: CIA_SecondaryButton(icon: Icon(Icons.remove), label: "Delete", onTab: () async{
                                      widget.list1.removeWhere((element) => element.id == e.id);
                                      if (widget.addFunction1 != null) await widget.addFunction1!(widget.list1);
                                      setState(() {});
                                    }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CIA_SecondaryButton(icon: Icon(Icons.edit), label: "Rename", onTab: () {
                                      CIA_ShowPopUp(
                                          context: context,
                                          child: CIA_TextFormField(
                                            label: "New Name",
                                            controller: TextEditingController(text: e.name),
                                            onChange: (value) => tempName = value,
                                          ),
                                          onSave: () async {
                                            widget.list1.firstWhere((element) => element.id == e.id).name = tempName;
                                            if (widget.addFunction1 != null) await widget.addFunction1!(widget.list1);
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
                                    IconButton(onPressed: ()async{
                                      widget.list2.removeWhere((element) => element.id == e.id);
                                      if (widget.addFunction2 != null) await widget.addFunction2!(widget.selectedList1Id,widget.list2);
                                      setState(() {});
                                    }, icon: Icon(Icons.remove)),
                                    Expanded(child: CIA_TextFormField(label: "Name", controller: TextEditingController(text: e.name ?? ""))),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    Expanded(child: SizedBox()),
                    widget.selectedList1Id == null
                        ? Container()
                        : CIA_PrimaryButton(
                            label: "Add ${widget.label2}",
                            isLong: true,
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
                                    if (widget.addFunction2 != null) await widget.addFunction2!(widget.selectedList1Id, widget.list2);
                                    setState(() {});
                                  });
                            }),
                  ],
                );
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
                return Column(
                  children: [
                    Column(
                      children: widget.list1
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    IconButton(onPressed: ()async{
                                      widget.list1.removeWhere((element) => element.id == e.id);
                                      if (widget.addFunction1 != null) await widget.addFunction1!(widget.list1);
                                      setState(() {});
                                    }, icon: Icon(Icons.remove)),

                                    Expanded(child: CIA_TextFormField(label: "Value", controller: TextEditingController(text: e.name ?? ""))),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    Expanded(child: SizedBox()),
                    CIA_PrimaryButton(
                        label: "Add ${widget.label2}",
                        isLong: true,
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
                                if (widget.addFunction1 != null) await widget.addFunction1!(widget.list1);
                                setState(() {});
                              });
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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
