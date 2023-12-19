import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TeethChart.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneCompanyEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addExpensesCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addImplantsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemShadesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addStockCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/treatmentWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import '../../../../../Widgets/SlidingTab.dart';
import '../../../../../features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import '../../../../presentation/widgets/CIA_GestureWidget.dart';
import '../../domain/entities/treatmentPricesEntity.dart';
import '../../domain/useCases/addLabItemsUseCase.dart';
import '../../domain/useCases/addMembranesUseCase.dart';
import '../bloc/settingsBloc.dart';
import '../bloc/settingsBloc_Events.dart';
import '../bloc/settingsBloc_States.dart';
import '../widgets/clinicPriceSettingsWidget.dart';
import 'ClinicPriceSettingsPage.dart';
import 'UserSettingsPage.dart';

class LabItemSettingsPage extends StatefulWidget {
  const LabItemSettingsPage({Key? key}) : super(key: key);

  static String routePath = "ItemsSettings";
  static String routeName = "LabItemsSettings";

  @override
  State<LabItemSettingsPage> createState() => _LabItemSettingsPageState();
}

class _LabItemSettingsPageState extends State<LabItemSettingsPage> {
  PageController _pageController = PageController();
  int currentIndex = 0;
  int currentItemId = 0;
  late SettingsBloc bloc;
  late ClinicTreatmentBloc clinicTreatmentBloc;
  List<ClinicPriceEntity> percentages = [];

  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    clinicTreatmentBloc = BlocProvider.of<ClinicTreatmentBloc>(context);
    bloc.add(SettingsBloc_LoadLabItemsParentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsBloc_States>(
      listener: (context, state) {},
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
          if (state.data.isNotEmpty) {
            currentItemId = state.data.first.id!;
            bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(id: currentItemId));
          }
          sideBarItem = state.data
              .map((e) => SidebarXItem(
                    label: e.name,
                    iconWidget: Container(),
                    onTap: () {
                      bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(id: e.id!));
                      currentIndex = e.id!;
                      currentItemId = e.id!;
                    },
                  ))
              .toList();
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
                items: sideBarItem,
              ),
              SizedBox(width: 10),
              Expanded(
                child: BlocConsumer<SettingsBloc, SettingsBloc_States>(
                  listener: (context, state) {
                    if (state is SettingsBloc_UpdatingLabItemsCompaniesState) {
                      CustomLoader.show(context);
                    } else {
                      CustomLoader.hide();
                      if (state is SettingsBloc_UpdatingLabItemsCompaniesErrorState) {
                        ShowSnackBar(context, isSuccess: false, message: state.message);
                        bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(id: currentItemId));
                      } else if (state is SettingsBloc_UpdatedLabItemsCompaniesSuccessfullyState) {
                        ShowSnackBar(context, isSuccess: true);
                        bloc.add(SettingsBloc_LoadLabItemCompaniesEvent(id: currentItemId));
                      }
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState ||
                      current is SettingsBloc_LoadingLabItemsCompaniesState ||
                      current is SettingsBloc_LoadingLabItemsCompaniesErrorState,
                  builder: (context, state) {
                    List<BasicNameIdObjectEntity> labItemCompanies = [];

                    int shadeId = 0;
                    int companyId = 0;

                    if (state is SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState) {
                      labItemCompanies = state.data;
                    }
                    if (labItemCompanies.isNotEmpty) {
                      companyId = labItemCompanies.first.id!;
                      bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: labItemCompanies.first.id!));
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
                                                        bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: e.id!));
                                                      },
                                                      iconWidget: IconButton(
                                                          onPressed: () {
                                                            CIA_ShowPopUp(
                                                              onSave: () {
                                                                bloc.add(
                                                                  SettingsBloc_UpdateLabItemCompaniesEvent(
                                                                    params: UpdateLabItemsCompaniesParams(
                                                                      data: labItemCompanies,
                                                                      parentItemId: currentItemId,
                                                                    ),
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
                                                          icon: Icon(Icons.edit)),
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
                                                        BasicNameIdObjectEntity(
                                                          name: newName,
                                                        ),
                                                      ];
                                                bloc.add(
                                                  SettingsBloc_UpdateLabItemCompaniesEvent(
                                                    params: UpdateLabItemsCompaniesParams(
                                                      data: labItemCompanies,
                                                      parentItemId: currentItemId,
                                                    ),
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
                        BlocConsumer<SettingsBloc, SettingsBloc_States>(
                          listener: (context, state) {
                            if (state is SettingsBloc_UpdatingLabItemsShadesState) {
                              CustomLoader.show(context);
                            } else {
                              CustomLoader.hide();
                              if (state is SettingsBloc_UpdatingLabItemsShadesErrorState) {
                                ShowSnackBar(context, isSuccess: false, message: state.message);
                                bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: companyId));
                              } else if (state is SettingsBloc_UpdatedLabItemsShadesSuccessfullyState) {
                                ShowSnackBar(context, isSuccess: true);
                                bloc.add(SettingsBloc_LoadLabItemsShadesEvent(companyId: companyId));
                              }
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is SettingsBloc_LoadedLabItemsShadesSuccessfullyState ||
                              current is SettingsBloc_LoadingLabItemsShadesErrorState ||
                              current is SettingsBloc_LoadingLabItemsShadesState,
                          builder: (context, state) {
                            List<BasicNameIdObjectEntity> itemShades = [];
                            if (state is SettingsBloc_LoadedLabItemsShadesSuccessfullyState) itemShades = state.data;
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
                            else
                              return Column(
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
                                                            SettingsBloc_UpdateLabItemShadesEvent(
                                                              params: UpdateLabItemsShadesParams(
                                                                companyId: companyId,
                                                                data: itemShades,
                                                              ),
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
                                                    icon: Icon(Icons.edit))))
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
                                                    BasicNameIdObjectEntity(
                                                      name: newName,
                                                    )
                                                  ];

                                            bloc.add(
                                              SettingsBloc_UpdateLabItemShadesEvent(
                                                params: UpdateLabItemsShadesParams(
                                                  companyId: companyId,
                                                  data: itemShades,
                                                ),
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
                              );
                          },
                        ),
                        BlocConsumer<SettingsBloc, SettingsBloc_States>(
                          listener: (context, state) {
                            if (state is SettingsBloc_UpdatingLabItemsState) {
                              CustomLoader.show(context);
                            } else {
                              CustomLoader.hide();
                              if (state is SettingsBloc_UpdatingLabItemsErrorState) {
                                ShowSnackBar(context, isSuccess: false, message: state.message);
                                bloc.add(SettingsBloc_LoadLabItemsEvent(shadeId: shadeId));
                              } else if (state is SettingsBloc_UpdatedLabItemsSuccessfullyState) {
                                ShowSnackBar(context, isSuccess: true);
                                bloc.add(SettingsBloc_LoadLabItemsEvent(shadeId: shadeId));
                              }
                            }
                          },

                          builder: (context, state) {
                            List<LabItemEntity> labItems = [];
                            if (state is SettingsBloc_LoadedLabItemsSuccessfullyState) {
                              labItems = state.data;
                              if (labItems.isEmpty) labItems = [LabItemEntity(labItemShadeId: shadeId)];
                            }

                            if (state is SettingsBloc_LoadingLabItemsState)
                              return LoadingWidget();
                            else if (state is SettingsBloc_LoadingLabItemsErrorState)
                              return BigErrorPageWidget(
                                message: state.message,
                                fontSize: 10,
                              );
                            else
                              return Expanded(
                                child: Column(
                                  children: [
                                    FormTextKeyWidget(text: "Lab Items"),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: labItems.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: CIA_TextFormField(
                                                      label: "Code",
                                                      controller: TextEditingController(text: labItems[index].code),
                                                      onChange: (value) => labItems[index].code = value),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: CIA_TextFormField(
                                                      label: "Size",
                                                      controller: TextEditingController(text: labItems[index].size),
                                                      onChange: (value) => labItems[index].size = value),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: CIA_TextFormField(
                                                      label: "Unit Price",
                                                      isNumber: true,
                                                      suffix: "EGP",
                                                      controller: TextEditingController(text: labItems[index].unitPrice?.toString()),
                                                      onChange: (value) => labItems[index].unitPrice = int.tryParse(value)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      labItems.add(LabItemEntity(labItemShadeId: shadeId));
                                                      bloc.emit(SettingsBloc_LoadedLabItemsSuccessfullyState(data: labItems));
                                                    },
                                                    icon: Icon(Icons.add)),
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
                                    CIA_PrimaryButton(label: "Save", onTab: (){
                                      bloc.add(SettingsBloc_UpdateLabItemEvent(params: UpdateLabItemsParams(
                                        data: labItems,
                                        shadeId: shadeId,
                                      )));
                                    })


                                  ],
                                ),
                              );
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        }

        return Container(
          height: 100,
          width: 100,
          color: Colors.red,
        );
      },
    );
  }
}
