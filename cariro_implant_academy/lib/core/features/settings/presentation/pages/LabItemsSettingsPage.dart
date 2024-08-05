import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labPricesForDoctorEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addImplantsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemParentsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabOptionsUseCase.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';

import '../bloc/settingsBloc.dart';
import '../bloc/settingsBloc_Events.dart';
import '../bloc/settingsBloc_States.dart';
import 'package:collection/collection.dart';

class LabItemSettingsPage extends StatefulWidget {
  const LabItemSettingsPage({Key? key}) : super(key: key);

  static String routePath = "ItemsSettings";
  static String routeName = "LabItemsSettings";

  @override
  State<LabItemSettingsPage> createState() => _LabItemSettingsPageState();
}

class _LabItemSettingsPageState extends State<LabItemSettingsPage> with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int currentIndex = 0;
  int currentItemId = 0;
  late SettingsBloc bloc;
  late ClinicTreatmentBloc clinicTreatmentBloc;
  List<ClinicPriceEntity> percentages = [];
  List<LabItemParentEntity> labItemParetns = [];
  LabItemParentEntity? selectedLabItemParent;
  late TabController tabController;
  int? doctorId;
  BasicNameIdObjectEntity? doctor;
  List<LabPriceForDoctorEntity> priceList = [];
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    bloc = BlocProvider.of<SettingsBloc>(context);
    clinicTreatmentBloc = BlocProvider.of<ClinicTreatmentBloc>(context);
    bloc.add(SettingsBloc_LoadLabItemsParentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          onTap: (value) {
            if (value == 0) {
              bloc.add(SettingsBloc_LoadLabItemsParentsEvent());
            } else {
              bloc.add(SettingsBloc_LoadLabOptionsEvent(
                  params: GetLabOptionsParams(
                doctorId: doctorId,
              )));
            }
          },
          labelColor: Colors.black,
          controller: tabController,
          tabs: [
            Tab(text: "Blocks"),
            Tab(text: "Options visible in requests"),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              BlocConsumer<SettingsBloc, SettingsBloc_States>(
                listener: (context, state) {
                  if (state is SettingsBloc_UpdatingLabItemsParentsState ||
                      state is SettingsBloc_UpdatingLabItemsCompaniesState ||
                      state is SettingsBloc_UpdatingLabItemsShadesState ||
                      state is SettingsBloc_UpdatingLabItemsState) {
                    CustomLoader.show(context);
                  } else {
                    CustomLoader.hide();
                    if (state is SettingsBloc_UpdatingLabItemsParentsErrorState) {
                      ShowSnackBar(context, isSuccess: false, message: state.message);
                      bloc.add(SettingsBloc_LoadLabItemsParentsEvent());
                    } else if (state is SettingsBloc_UpdatingLabItemsCompaniesErrorState) {
                      ShowSnackBar(context, isSuccess: false, message: state.message);
                    } else if (state is SettingsBloc_UpdatingLabItemsShadesErrorState) {
                      ShowSnackBar(context, isSuccess: false, message: state.message);
                    } else if (state is SettingsBloc_UpdatingLabItemsErrorState) {
                      ShowSnackBar(context, isSuccess: false, message: state.message);
                    } else if (state is SettingsBloc_UpdatedLabItemsParentsSuccessfullyState ||
                        state is SettingsBloc_UpdatedLabItemsCompaniesSuccessfullyState ||
                        state is SettingsBloc_UpdatedLabItemsShadesSuccessfullyState ||
                        state is SettingsBloc_UpdatedLabItemsSuccessfullyState) {
                      ShowSnackBar(context, isSuccess: true);
                      if (state is SettingsBloc_UpdatedLabItemsParentsSuccessfullyState) bloc.add(SettingsBloc_LoadLabItemsParentsEvent());
                    }
                  }
                },
                buildWhen: (previous, current) =>
                    current is SettingsBloc_LoadingLabItemParentsState ||
                    current is SettingsBloc_LoadingLabItemParentsErrorState ||
                    current is SettingsBloc_LoadedLabItemParentsSuccessfullyState,
                builder: (context, state) {
                  if (state is SettingsBloc_LoadingLabItemParentsState)
                    return LoadingWidget();
                  else if (state is SettingsBloc_LoadingLabItemParentsErrorState)
                    return BigErrorPageWidget(message: state.message);
                  else if (state is SettingsBloc_LoadedLabItemParentsSuccessfullyState) {
                    List<SidebarXItem> sideBarItem = [];
                    labItemParetns = state.data;
                    if (state.data.isNotEmpty) {
                      currentItemId = state.data.first.id!;
                      selectedLabItemParent = state.data.firstOrNull;
                      if (selectedLabItemParent?.hasCompanies == true)
                        bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(parentId: selectedLabItemParent!.id!));
                      else if (selectedLabItemParent?.hasShades == true)
                        bloc.add(SettingsBloc_LoadLabItemsShadesEvent(parentId: selectedLabItemParent!.id));
                      else
                        bloc.add(SettingsBloc_LoadLabItemsEvent(parentId: selectedLabItemParent!.id));
                    }
                    sideBarItem = state.data
                        .mapIndexed((i, e) => SidebarXItem(
                              label: "${e.name}",
                              iconWidget: IconButton(
                                  onPressed: () {
                                    CIA_ShowPopUp(
                                      onSave: () {
                                        bloc.add(SettingsBloc_UpdateLabItemParentEvent(labItemParents: labItemParetns));
                                      },
                                      context: context,
                                      title: "Edit: Can't chnage companies, shades, codes and sizes options after creation!",
                                      child: Column(
                                        children: [
                                          CIA_TextFormField(
                                            label: "Name",
                                            controller: TextEditingController(text: e.name?.toString() ?? ""),
                                            onChange: (value) => e.name = value,
                                          ),
                                          SizedBox(height: 10),
                                          CIA_TextFormField(
                                            label: "Threshold",
                                            isNumber: true,
                                            controller: TextEditingController(text: e.threshold?.toString() ?? "10"),
                                            onChange: (value) => e.threshold = int.tryParse(value) ?? 10,
                                          ),
                                          SizedBox(height: 10),
                                          CIA_CheckBoxWidget(
                                            text: "Has Companies",
                                            value: e.hasCompanies ?? false,
                                          ),
                                          CIA_CheckBoxWidget(
                                            text: "Has Shades",
                                            value: e.hasCompanies ?? false,
                                          ),
                                          CIA_CheckBoxWidget(
                                            text: "Has Sizes",
                                            value: e.hasCompanies ?? false,
                                          ),
                                          CIA_CheckBoxWidget(
                                            text: "Has Codes",
                                            value: e.hasCompanies ?? false,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: !siteController.getRole()!.contains("admin") ? Container() : Icon(Icons.edit)),
                              onTap: () {
                                selectedLabItemParent = e;
                                if (e.hasCompanies == true)
                                  bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(parentId: e.id!));
                                else if (e.hasShades == true)
                                  bloc.add(SettingsBloc_LoadLabItemsShadesEvent(parentId: e.id));
                                else
                                  bloc.add(SettingsBloc_LoadLabItemsEvent(parentId: e.id));

                                currentIndex = i;
                                currentItemId = e.id!;
                                bloc.emit(SettingsBloc_SelectedParentState(data: state.data));
                              },
                            ))
                        .toList();
                    return BlocBuilder<SettingsBloc, SettingsBloc_States>(
                        buildWhen: (previous, current) => current is SettingsBloc_SelectedParentState,
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SidebarX(
                                      controller: SidebarXController(selectedIndex: currentIndex, extended: true),
                                      showToggleButton: false,
                                      extendedTheme: SidebarXTheme(
                                          width: 300,
                                          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          decoration: BoxDecoration(
                                            border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                                          )),
                                      items: sideBarItem,
                                    ),
                                  ),
                                  CIA_PrimaryButton(
                                    label: "Add new",
                                    onTab: () {
                                      LabItemParentEntity newLabItemParent = LabItemParentEntity();
                                      CIA_ShowPopUp(
                                        onSave: () {
                                          labItemParetns = [...labItemParetns, newLabItemParent];
                                          bloc.add(SettingsBloc_UpdateLabItemParentEvent(labItemParents: labItemParetns));
                                        },
                                        context: context,
                                        title: "Edit: Can't chnage companies, shades, codes and sizes options after creation!",
                                        child: Column(
                                          children: [
                                            CIA_TextFormField(
                                              label: "Name",
                                              controller: TextEditingController(text: newLabItemParent.name?.toString() ?? ""),
                                              onChange: (value) => newLabItemParent.name = value,
                                            ),
                                            SizedBox(height: 10),
                                            CIA_TextFormField(
                                              label: "Threshold",
                                              isNumber: true,
                                              controller: TextEditingController(text: newLabItemParent.threshold?.toString() ?? "10"),
                                              onChange: (value) => newLabItemParent.threshold = int.tryParse(value) ?? 10,
                                            ),
                                            SizedBox(height: 10),
                                            CIA_CheckBoxWidget(
                                              text: "Has Companies",
                                              value: newLabItemParent.hasCompanies ?? false,
                                              onChange: (value) => newLabItemParent.hasCompanies = value,
                                            ),
                                            CIA_CheckBoxWidget(
                                              text: "Has Shades",
                                              value: newLabItemParent.hasCompanies ?? false,
                                              onChange: (value) => newLabItemParent.hasShades = value,
                                            ),
                                            CIA_CheckBoxWidget(
                                              text: "Has Sizes",
                                              value: newLabItemParent.hasCompanies ?? false,
                                              onChange: (value) => newLabItemParent.hasSize = value,
                                            ),
                                            CIA_CheckBoxWidget(
                                              text: "Has Codes",
                                              value: newLabItemParent.hasCompanies ?? false,
                                              onChange: (value) => newLabItemParent.hasCode = value,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: selectedLabItemParent?.hasCompanies == true
                                    ? _LabCompaniesSettingsWidget(
                                        bloc: bloc,
                                        currentItemId: currentItemId,
                                        selectedLabItemParent: selectedLabItemParent,
                                      )
                                    : selectedLabItemParent?.hasShades == true
                                        ? _LabShadesSettingsWidget(
                                            bloc: bloc,
                                            selectedLabItemParent: selectedLabItemParent,
                                          )
                                        : _LabItemsSettingsWidget(
                                            bloc: bloc,
                                            selectedLabItemParent: selectedLabItemParent,
                                          ),
                              )
                            ],
                          );
                        });
                  }

                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  );
                },
              ),
              BlocConsumer<SettingsBloc, SettingsBloc_States>(
                listener: (context, state) {
                  if (state is SettingsBloc_UpdatingLabOptionsState)
                    CustomLoader.show(context);
                  else {
                    CustomLoader.hide();
                    if (state is SettingsBloc_UpdatingLabOptionsErrorState)
                      ShowSnackBar(context, isSuccess: false, message: state.message);
                    else if (state is SettingsBloc_UpdatedLabOptionsSuccessfullyState) {
                      ShowSnackBar(context, isSuccess: true);
                      bloc.add(
                        SettingsBloc_LoadLabOptionsEvent(
                          params: GetLabOptionsParams(
                            doctorId: doctorId,
                          ),
                        ),
                      );
                    }
                  }
                },
                buildWhen: (previous, current) =>
                    current is SettingsBloc_LoadingLabOptionsErrorState ||
                    current is SettingsBloc_LoadedLabOptionsSuccessfullyState ||
                    current is SettingsBloc_LoadingLabOptionsState,
                builder: (context, state) {
                  List<LabOptionEntity> options = [];
                  if (state is SettingsBloc_LoadingLabOptionsState)
                    return LoadingWidget();
                  else if (state is SettingsBloc_LoadingLabOptionsErrorState)
                    return BigErrorPageWidget(message: state.message);
                  else if (state is SettingsBloc_LoadedLabOptionsSuccessfullyState) {
                    if (doctorId != null) {
                      priceList = state.data
                          .map((e) => LabPriceForDoctorEntity(
                                doctorId: doctorId,
                                optionId: e.id!,
                                price: e.price ?? 0,
                              ))
                          .toList();
                    }
                    options = state.data;
                    if (options.isEmpty)
                      options = [
                        ...options,
                        LabOptionEntity(
                          price: 0,
                        )
                      ];
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                          "These options that will be visible in any request. The options will be linked in:\n 1- DropDown lists for choosing the corresponding companies, shades, blocks \n 2- Consuming the corresponding blocks. \n 3- Linkning the right price for each step in the request."),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                              onClear: () {
                                doctorId = null;
                                doctor = null;
                                priceList = [];
                                bloc.add(SettingsBloc_LoadLabOptionsEvent(
                                    params: GetLabOptionsParams(
                                  doctorId: doctorId,
                                )));
                              },
                              asyncUseCase: sl<LoadUsersUseCase>(),
                              searchParams: LoadUsersEnum.allDoctors,
                              label: "Select Doctor",
                              onSelect: (value) {
                                doctor = value;
                                doctorId = value.id;
                                bloc.add(SettingsBloc_LoadLabOptionsEvent(
                                    params: GetLabOptionsParams(
                                  doctorId: doctorId,
                                )));
                              },
                              selectedItem: doctorId == null ? BasicNameIdObjectEntity(name: "Default Prices") : doctor,
                            ),
                          ),
                          Visibility(
                            visible: doctorId == null,
                            child: FormTextValueWidget(
                              text: "Save Before Selecting Doctor",
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: options
                              .mapIndexed((i, e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text("${i + 1}. "),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            label: "Option Name",
                                            controller: TextEditingController(text: e.name),
                                            onChange: (value) => e.name = value,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            label: "Price",
                                            isNumber: true,
                                            controller: TextEditingController(text: e.price?.toString() ?? "0"),
                                            onChange: (value) => e.price = int.tryParse(value) ?? 0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_DropDownSearchBasicIdName(
                                            onClear: () {
                                              e.labItemParent = null;
                                              e.labItemParentId = null;
                                            },
                                            asyncUseCaseDynamic: sl<GetLabItemParentsUseCase>(),
                                            label: "Linked Parent",
                                            selectedItem: e.labItemParent,
                                            onSelect: (value) {
                                              e.labItemParentId = value.id;
                                              e.labItemParent = LabItemParentEntity(name: value.name, id: value.id);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        doctorId == null
                                            ? IconButton(
                                                onPressed: () {
                                                  options = [
                                                    ...options,
                                                    LabOptionEntity(
                                                      price: 0,
                                                    )
                                                  ];
                                                  bloc.emit(SettingsBloc_LoadedLabOptionsSuccessfullyState(data: options));
                                                },
                                                icon: Icon(Icons.add),
                                              )
                                            : FormTextValueWidget(
                                                text: "You can only add items in the default view! Clear Doctor Selection First",
                                                color: Colors.red,
                                              ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      CIA_PrimaryButton(
                          label: "Save",
                          onTab: () {
                            bloc.add(SettingsBloc_UpdateLabOptionsEvent(
                              options: options,
                              doctorId: doctorId,
                              priceList: priceList,
                            ));
                          })
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _LabCompaniesSettingsWidget extends StatelessWidget {
  _LabCompaniesSettingsWidget({
    super.key,
    required this.currentItemId,
    required this.bloc,
    this.selectedLabItemParent,
  });
  int currentItemId;
  SettingsBloc bloc;
  LabItemParentEntity? selectedLabItemParent;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsBloc_States>(
      listener: (context, state) {
        if (state is SettingsBloc_UpdatingLabItemsCompaniesState) {
          CustomLoader.show(context);
        } else {
          CustomLoader.hide();
          if (state is SettingsBloc_UpdatingLabItemsCompaniesErrorState) {
            ShowSnackBar(context, isSuccess: false, message: state.message);
            bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(parentId: currentItemId));
          } else if (state is SettingsBloc_UpdatedLabItemsCompaniesSuccessfullyState) {
            ShowSnackBar(context, isSuccess: true);
            bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(parentId: currentItemId));
          }
        }
      },
      buildWhen: (previous, current) =>
          current is SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState ||
          current is SettingsBloc_LoadingLabItemsCompaniesState ||
          current is SettingsBloc_LoadingLabItemsCompaniesErrorState,
      builder: (context, state) {
        List<LabItemCompanyEntity> labItemCompanies = [];
        int shadeId = 0;
        int companyId = 0;
        if (state is SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState) {
          labItemCompanies = state.data;
        }
        if (labItemCompanies.isNotEmpty) {
          companyId = labItemCompanies.first.id!;
          if (selectedLabItemParent?.hasShades == true)
            bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: labItemCompanies.first.id!));
          else
            bloc.add(SettingsBloc_LoadLabItemsEvent(companyId: labItemCompanies.first.id!));
        }
        return Row(
          children: [
            state is SettingsBloc_LoadingLabItemsCompaniesErrorState
                ? BigErrorPageWidget(
                    message: state.message,
                    fontSize: 10,
                  )
                : state is SettingsBloc_LoadingLabItemsCompaniesState
                    ? LoadingWidget()
                    : Column(
                        children: [
                          FormTextKeyWidget(text: "Companies"),
                          Expanded(
                            child: SidebarX(
                                controller: SidebarXController(selectedIndex: 0, extended: true),
                                showToggleButton: false,
                                extendedTheme: SidebarXTheme(
                                    width: 200,
                                    selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    decoration: BoxDecoration(
                                      border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                                    )),
                                items: labItemCompanies
                                    .map((e) => SidebarXItem(
                                          label: e.name ?? "",
                                          onTap: () {
                                            companyId = e.id!;
                                            if (selectedLabItemParent?.hasShades == true)
                                              bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: companyId));
                                            else
                                              bloc.add(SettingsBloc_LoadLabItemsEvent(companyId: companyId));
                                          },
                                          iconWidget: IconButton(
                                              onPressed: () {
                                                CIA_ShowPopUp(
                                                  onSave: () {
                                                    bloc.add(
                                                      SettingsBloc_UpdateLabItemCompaniesEvent(
                                                        companies: labItemCompanies,
                                                      ),
                                                    );
                                                  },
                                                  context: context,
                                                  title: "Edit Name",
                                                  child: CIA_TextFormField(
                                                    label: "Name",
                                                    controller: TextEditingController(text: e.name ?? ""),
                                                    onChange: (value) => e.name = value,
                                                  ),
                                                );
                                              },
                                              icon: !siteController.getRole()!.contains("admin") ? Container() : Icon(Icons.edit)),
                                        ))
                                    .toList()),
                          ),
                          IconButton(
                              onPressed: () {
                                String newName = "";
                                CIA_ShowPopUp(
                                  context: context,
                                  onSave: () {
                                    newName == ""
                                        ? null
                                        : labItemCompanies = [
                                            ...labItemCompanies,
                                            LabItemCompanyEntity(
                                              name: newName,
                                              labItemParentId: selectedLabItemParent!.id!,
                                            ),
                                          ];
                                    bloc.add(
                                      SettingsBloc_UpdateLabItemCompaniesEvent(companies: labItemCompanies),
                                    );
                                  },
                                  child: CIA_TextFormField(
                                    label: "Name",
                                    controller: TextEditingController(text: ""),
                                    onChange: (value) => newName = value,
                                  ),
                                );
                              },
                              icon: Icon(Icons.add))
                        ],
                      ),
            selectedLabItemParent?.hasShades == true
                ? _LabShadesSettingsWidget(
                    bloc: bloc,
                    companyId: companyId,
                    selectedLabItemParent: selectedLabItemParent,
                  )
                : _LabItemsSettingsWidget(
                    bloc: bloc,
                    companyId: companyId,
                    selectedLabItemParent: selectedLabItemParent,
                  ),
          ],
        );
      },
    );
  }
}

class _LabShadesSettingsWidget extends StatelessWidget {
  _LabShadesSettingsWidget({
    super.key,
    this.companyId,
    required this.bloc,
    this.selectedLabItemParent,
  });
  int? companyId;
  SettingsBloc bloc;
  LabItemParentEntity? selectedLabItemParent;
  int? shadeId;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<SettingsBloc, SettingsBloc_States>(
        listener: (context, state) {
          if (state is SettingsBloc_UpdatingLabItemsShadesState) {
            CustomLoader.show(context);
          } else {
            CustomLoader.hide();
            if (state is SettingsBloc_UpdatingLabItemsShadesErrorState) {
              ShowSnackBar(context, isSuccess: false, message: state.message);
              bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: companyId, parentId: selectedLabItemParent!.id!));
            } else if (state is SettingsBloc_UpdatedLabItemsShadesSuccessfullyState) {
              ShowSnackBar(context, isSuccess: true);
              bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: companyId, parentId: selectedLabItemParent!.id!));
            }
          }
        },
        buildWhen: (previous, current) =>
            current is SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState ||
            current is SettingsBloc_LoadingLabItemsCompaniesState ||
            current is SettingsBloc_LoadingLabItemsCompaniesErrorState ||
            current is SettingsBloc_LoadedLabItemsShadesSuccessfullyState ||
            current is SettingsBloc_LoadingLabItemsShadesErrorState ||
            current is SettingsBloc_LoadingLabItemsShadesState,
        builder: (context, state) {
          List<LabItemShadeEntity> itemShades = [];
          if (state is SettingsBloc_LoadedLabItemsShadesSuccessfullyState) {
            itemShades = state.data;
            companyId = state.comapnyId;
          }
          if (itemShades.isNotEmpty) {
            shadeId = itemShades.first.id!;
            bloc.add(SettingsBloc_LoadLabItemsEvent(shadeId: itemShades.first.id!));
          }
          if (state is SettingsBloc_LoadingLabItemsShadesState)
            return LoadingWidget();
          else if (state is SettingsBloc_LoadingLabItemsShadesErrorState)
            return BigErrorPageWidget(
              message: state.message,
              fontSize: 10,
            );

          return Row(
            children: [
              state is SettingsBloc_LoadingLabItemsShadesErrorState
                  ? BigErrorPageWidget(
                      message: state.message,
                      fontSize: 10,
                    )
                  : state is SettingsBloc_LoadingLabItemsShadesState
                      ? LoadingWidget()
                      : Column(
                          children: [
                            FormTextKeyWidget(text: "Shades"),
                            Expanded(
                              child: SidebarX(
                                  controller: SidebarXController(selectedIndex: 0, extended: true),
                                  showToggleButton: false,
                                  extendedTheme: SidebarXTheme(
                                      width: 200,
                                      selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      decoration: BoxDecoration(
                                        border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                                      )),
                                  items: itemShades
                                      .map((e) => SidebarXItem(
                                          label: e.name ?? "",
                                          onTap: () {
                                            shadeId = e.id!;
                                            bloc.add(SettingsBloc_LoadLabItemsEvent(shadeId: e.id!));
                                          },
                                          iconWidget: IconButton(
                                              onPressed: () {
                                                CIA_ShowPopUp(
                                                  onSave: () {
                                                    bloc.add(
                                                      SettingsBloc_UpdateLabItemShadesEvent(shades: itemShades),
                                                    );
                                                  },
                                                  context: context,
                                                  title: "Edit Name",
                                                  child: CIA_TextFormField(
                                                    label: "Name",
                                                    controller: TextEditingController(text: e.name ?? ""),
                                                    onChange: (value) => e.name = value,
                                                  ),
                                                );
                                              },
                                              icon: !siteController.getRole()!.contains("admin") ? Container() : Icon(Icons.edit))))
                                      .toList()),
                            ),
                            IconButton(
                                onPressed: () {
                                  String newName = "";
                                  CIA_ShowPopUp(
                                    context: context,
                                    onSave: () {
                                      newName == ""
                                          ? null
                                          : itemShades = [
                                              ...itemShades,
                                              LabItemShadeEntity(
                                                  name: newName, labItemCompanyId: companyId, labItemParentId: selectedLabItemParent!.id!)
                                            ];

                                      bloc.add(
                                        SettingsBloc_UpdateLabItemShadesEvent(
                                          shades: itemShades,
                                        ),
                                      );
                                    },
                                    child: CIA_TextFormField(
                                      label: "Name",
                                      controller: TextEditingController(text: ""),
                                      onChange: (value) => newName = value,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
              _LabItemsSettingsWidget(
                bloc: bloc,
                companyId: companyId,
                shadeId: shadeId,
                selectedLabItemParent: selectedLabItemParent,
              )
            ],
          );
        },
      ),
    );
  }
}

class _LabItemsSettingsWidget extends StatelessWidget {
  _LabItemsSettingsWidget({
    super.key,
    this.companyId,
    required this.bloc,
    this.selectedLabItemParent,
    this.shadeId,
  });
  int? companyId;
  SettingsBloc bloc;
  LabItemParentEntity? selectedLabItemParent;
  int? shadeId;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<SettingsBloc, SettingsBloc_States>(
        listener: (context, state) {
          if (state is SettingsBloc_UpdatingLabItemsState) {
            CustomLoader.show(context);
          } else {
            CustomLoader.hide();
            if (state is SettingsBloc_UpdatingLabItemsErrorState) {
              ShowSnackBar(context, isSuccess: false, message: state.message);
              bloc.add(SettingsBloc_LoadLabItemsEvent(shadeId: shadeId, companyId: companyId, parentId: selectedLabItemParent!.id));
            } else if (state is SettingsBloc_UpdatedLabItemsSuccessfullyState) {
              ShowSnackBar(context, isSuccess: true);
              bloc.add(SettingsBloc_LoadLabItemsEvent(shadeId: shadeId, companyId: companyId, parentId: selectedLabItemParent!.id));
            }
          }
        },
        builder: (context, state) {
          List<LabItemEntity> labItems = [];
          if (state is SettingsBloc_LoadedLabItemsSuccessfullyState) {
            labItems = state.data;
            shadeId = state.shadeId;
            companyId = state.companyId;

            if (labItems.isEmpty)
              labItems = [LabItemEntity(labItemShadeId: shadeId, labItemCompanyId: companyId, labItemParentId: selectedLabItemParent?.id)];
          }

          if (state is SettingsBloc_LoadingLabItemsState)
            return LoadingWidget();
          else if (state is SettingsBloc_LoadingLabItemsErrorState)
            return BigErrorPageWidget(
              message: state.message,
              fontSize: 10,
            );
          return Column(
            children: [
              FormTextKeyWidget(text: "Lab Items"),
              SizedBox(height: 10),
              FormTextKeyWidget(
                text: "Cost Of Buying The block \n Prices will be deducted as Cashflow expenses when adding new items ONLY!",
                color: Colors.red,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: labItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Visibility(
                            visible: selectedLabItemParent?.hasCode == true,
                            child: Expanded(
                              child: CIA_TextFormField(
                                  label: "Code",
                                  controller: TextEditingController(text: labItems[index].code),
                                  onChange: (value) => labItems[index].code = value),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: selectedLabItemParent?.hasSize == true,
                            child: Expanded(
                              child: CIA_TextFormField(
                                  label: "Size",
                                  controller: TextEditingController(text: labItems[index].size),
                                  onChange: (value) => labItems[index].size = value),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CIA_TextFormField(
                                enabled: labItems[index].id == null,
                                label: "Price",
                                suffix: "EGP",
                                isNumber: true,
                                controller: TextEditingController(text: labItems[index].price?.toString() ?? "0"),
                                onChange: (value) => labItems[index].price = int.tryParse(value) ?? 0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              labItems = [
                                ...labItems,
                                LabItemEntity(
                                  labItemShadeId: shadeId,
                                  labItemCompanyId: companyId,
                                  labItemParentId: selectedLabItemParent?.id,
                                  price: labItems.lastOrNull?.price,
                                )
                              ];
                              bloc.emit(SettingsBloc_LoadedLabItemsSuccessfullyState(data: labItems));
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FormTextKeyWidget(text: "Items with empty fields will be deleted!", color: Colors.red),
              SizedBox(
                height: 10,
              ),
              CIA_PrimaryButton(
                  label: "Save",
                  onTab: () {
                    bloc.add(SettingsBloc_UpdateLabItemEvent(
                      items: labItems,
                    ));
                  })
            ],
          );
        },
      ),
    );
  }
}
