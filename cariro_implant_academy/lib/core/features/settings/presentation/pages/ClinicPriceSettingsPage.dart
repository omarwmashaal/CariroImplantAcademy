import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
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
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addStockCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addSuppliersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getSuppliersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/helpers/spaceToString.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/widgets/treatmentWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import '../../../../../features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import '../../../../presentation/widgets/CIA_GestureWidget.dart';

import '../../domain/useCases/addMembranesUseCase.dart';
import '../bloc/settingsBloc.dart';
import '../bloc/settingsBloc_Events.dart';
import '../bloc/settingsBloc_States.dart';
import '../widgets/clinicPriceSettingsWidget.dart';

class ClinicPriceSettingsPage extends StatefulWidget {
  const ClinicPriceSettingsPage({Key? key}) : super(key: key);
  static String routeName = "ClinicPriceSettings";
  static String routePath = "ClinicPriceSettings";

  @override
  State<ClinicPriceSettingsPage> createState() => _ClinicPriceSettingsPageState();
}

class _ClinicPriceSettingsPageState extends State<ClinicPriceSettingsPage> {
  PageController _pageController = PageController();
  int currentIndex = 0;
  late SettingsBloc bloc;
  late ClinicTreatmentBloc clinicTreatmentBloc;
  List<ClinicPriceEntity> percentages = [];

  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    clinicTreatmentBloc = BlocProvider.of<ClinicTreatmentBloc>(context);
    bloc.add(SettingsBloc_LoadImplantCompaniesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsBloc_States>(
      listener: (context, state) {
        if (state is SettingsBlocSuccessState)
          ShowSnackBar(context, isSuccess: true);
        else if (state is SettingsBlocErrorState) ShowSnackBar(context, isSuccess: false);
        if (state is SettingsBloc_ChangedImplantCompanyNameSuccessfullyState || state is SettingsBloc_AddedImplantCompaniesSuccessfullyState)
          bloc.add(SettingsBloc_LoadImplantCompaniesEvent());
        else if (state is SettingsBloc_AddedMembraneCompaniesSuccessfullyState)
          bloc.add(SettingsBloc_LoadMembraneCompaniesEvent());
        else if (state is SettingsBloc_AddedTacsCompaniesSuccessfullyState)
          bloc.add(SettingsBloc_LoadTacsEvent());
        else if (state is SettingsBloc_AddedExpensesCategoriesSuccessfullyState)
          bloc.add(SettingsBloc_LoadExpensesCategoriesEvent(website: Website.Clinic));
        else if (state is SettingsBloc_AddedIncomeCategoriesSuccessfullyState)
          bloc.add(SettingsBloc_LoadIncomeCategoriesEvent());
        else if (state is SettingsBloc_AddedStockCategoriesSuccessfullyState)
          bloc.add(SettingsBloc_LoadStockCategoriesEvent(website: Website.Clinic));
        else if (state is SettingsBloc_AddedSuppliersSuccessfullyState)
          bloc.add(SettingsBloc_LoadSuppliersEvent(
              params: GetSuppliersParams(
            website: Website.Clinic,
            medical: false,
          )));
        else if (state is SettingsBloc_AddedPaymentMethodsSuccessfullyState)
          bloc.add(SettingsBloc_LoadPaymentMethodsEvent());
        else if (state is SettingsBloc_EditedRoomsSuccessfullyState)
          bloc.add(SettingsBloc_LoadRoomsEvent());
        else if (state is SettingsBloc_EditedTreatmentPricesSuccessfullyState) bloc.add(SettingsBloc_LoadTreatmentPricesEvent());
      },
      child: siteController.getSite() == Website.Clinic
          ? Column(
              children: [
                Expanded(
                  child: Container(
                    child: DefaultTabController(
                      length: 8,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            child: TabBar(
                              labelColor: Colors.black,
                              onTap: (value) {
                                if (value == 7) {
                                  clinicTreatmentBloc.add(
                                    ClinicTreatmentBloc_GetPriceEvent(
                                      params: GetTeethClinicPircesParams(
                                        category: EnumClinicPrices.values.where((element) => element.name.contains("Doctor")).toList(),
                                      ),
                                      key: "key",
                                    ),
                                  );
                                }
                              },
                              tabs: [
                                Tab(text: "Restoration"),
                                Tab(text: "Implants"),
                                Tab(text: "Ortho"),
                                Tab(text: "TMD"),
                                Tab(text: "Pedo"),
                                Tab(text: "Root Canal Treatment"),
                                Tab(text: "Scaling"),
                                Tab(text: "Percents"),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TabBarView(
                            children: [
                              ClinicPricesSettingsWidget(type: "Restoration"),
                              ClinicPricesSettingsWidget(type: "Implant"),
                              ClinicPricesSettingsWidget(type: "Ortho"),
                              ClinicPricesSettingsWidget(type: "TMD"),
                              ClinicPricesSettingsWidget(type: "Pedo"),
                              ClinicPricesSettingsWidget(type: "RootCanalTreatment"),
                              ClinicPricesSettingsWidget(type: "Scaling"),
                              BlocBuilder<ClinicTreatmentBloc, ClinicTreatmentBloc_States>(
                                  buildWhen: (previous, current) =>
                                      current is ClinicTreatmentBloc_LoadingPricesState ||
                                      current is ClinicTreatmentBloc_LoadingPricesErrorState ||
                                      current is ClinicTreatmentBloc_LoadedPricesSuccessfullyState,
                                  builder: (context, state) {
                                    if (state is ClinicTreatmentBloc_LoadingPricesState)
                                      return LoadingWidget();
                                    else if (state is ClinicTreatmentBloc_LoadingPricesErrorState)
                                      return BigErrorPageWidget(message: state.message);
                                    else if (state is ClinicTreatmentBloc_LoadedPricesSuccessfullyState) {
                                      percentages = state.prices ?? [];
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            FormTextKeyWidget(text: "Doctor's Patient || Doctor's Operation"),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: CIA_TextFormField(
                                                  label: "Doctor's Percent",
                                                  isNumber: true,
                                                  suffix: "%",
                                                  controller: TextEditingController(
                                                      text: percentages
                                                              .firstWhere((element) =>
                                                                  element.category == EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent)
                                                              .price
                                                              ?.toString() ??
                                                          "0"),
                                                  onChange: (v) => percentages
                                                      .firstWhere((element) =>
                                                          element.category == EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent)
                                                      .price = int.parse(v),
                                                )),
                                                SizedBox(width: 10),
                                                Expanded(
                                                    child: CIA_TextFormField(
                                                  label: "Clinic Percent",
                                                  isNumber: true,
                                                  suffix: "%",
                                                  controller: TextEditingController(
                                                      text: percentages
                                                              .firstWhere((element) =>
                                                                  element.category == EnumClinicPrices.DoctorsPatientDoctorsOperation_ClinicPercent)
                                                              .price
                                                              ?.toString() ??
                                                          "0"),
                                                  onChange: (v) => percentages
                                                      .firstWhere((element) =>
                                                          element.category == EnumClinicPrices.DoctorsPatientDoctorsOperation_ClinicPercent)
                                                      .price = int.parse(v),
                                                )),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            FormTextKeyWidget(text: "Doctor's Patient || Another Doctor's Operation"),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: CIA_TextFormField(
                                                        label: "Doctor's Percent",
                                                        isNumber: true,
                                                        suffix: "%",
                                                        controller: TextEditingController(
                                                            text: percentages
                                                                    .firstWhere((element) =>
                                                                        element.category ==
                                                                        EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_DoctorPercent)
                                                                    .price
                                                                    ?.toString() ??
                                                                "0"),
                                                        onChange: (v) => percentages
                                                            .firstWhere((element) =>
                                                                element.category ==
                                                                EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_DoctorPercent)
                                                            .price = int.parse(v),
                                                      )),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                          child: CIA_TextFormField(
                                                        label: "Operator's Percent",
                                                        isNumber: true,
                                                        suffix: "%",
                                                        controller: TextEditingController(
                                                            text: percentages
                                                                    .firstWhere((element) =>
                                                                        element.category ==
                                                                        EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_OperatorPercent)
                                                                    .price
                                                                    ?.toString() ??
                                                                "0"),
                                                        onChange: (v) => percentages
                                                            .firstWhere((element) =>
                                                                element.category ==
                                                                EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_OperatorPercent)
                                                            .price = int.parse(v),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                    child: CIA_TextFormField(
                                                  label: "Clinic Percent",
                                                  isNumber: true,
                                                  suffix: "%",
                                                  controller: TextEditingController(
                                                      text: percentages
                                                              .firstWhere((element) =>
                                                                  element.category ==
                                                                  EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent)
                                                              .price
                                                              ?.toString() ??
                                                          "0"),
                                                  onChange: (v) => percentages
                                                      .firstWhere((element) =>
                                                          element.category == EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent)
                                                      .price = int.parse(v),
                                                )),
                                              ],
                                            ),
                                            CIA_PrimaryButton(
                                                label: "Save Changes",
                                                onTab: () {
                                                  if ((percentages
                                                                  .firstWhere((element) =>
                                                                      element.category ==
                                                                      EnumClinicPrices.DoctorsPatientDoctorsOperation_ClinicPercent)
                                                                  .price!) +
                                                              (percentages
                                                                  .firstWhere((element) =>
                                                                      element.category ==
                                                                      EnumClinicPrices.DoctorsPatientDoctorsOperation_DoctorPercent)
                                                                  .price!) !=
                                                          100 ||
                                                      (percentages
                                                                  .firstWhere((element) =>
                                                                      element.category ==
                                                                      EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_ClinicPercent)
                                                                  .price!) +
                                                              (percentages
                                                                  .firstWhere((element) =>
                                                                      element.category ==
                                                                      EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_OperatorPercent)
                                                                  .price!) +
                                                              (percentages
                                                                  .firstWhere((element) =>
                                                                      element.category ==
                                                                      EnumClinicPrices.DoctorsPatientAnotherDoctorsOperation_DoctorPercent)
                                                                  .price!) !=
                                                          100)
                                                    ShowSnackBar(context, isSuccess: false, message: "Percent Should Add Up to 100%");
                                                  else
                                                    bloc.add(SettingsBloc_EditClinicPricesEvent(prices: percentages));
                                                })
                                          ],
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
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
                          bloc.add(SettingsBloc_LoadImplantCompaniesEvent());
                          // _pageController.jumpToPage(0);
                          currentIndex = 0;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Membranes",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadMembraneCompaniesEvent());
                          //_pageController.jumpToPage(1);
                          currentIndex = 1;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Tacs",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadTacsEvent());
                          //_pageController.jumpToPage(2);
                          currentIndex = 2;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Expenses Categories",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadExpensesCategoriesEvent(website: Website.Clinic));
                          //_pageController.jumpToPage(3);
                          currentIndex = 3;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Income Categories",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadIncomeCategoriesEvent());
                          // _pageController.jumpToPage(4);
                          currentIndex = 4;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Stock Categories",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadStockCategoriesEvent(website: Website.Clinic));
                          // _pageController.jumpToPage(5);
                          currentIndex = 5;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Suppliers",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadSuppliersEvent(params: GetSuppliersParams(medical: false, website: Website.Clinic)));

                          // _pageController.jumpToPage(6);
                          currentIndex = 6;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Payment Methods",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadPaymentMethodsEvent());
                          //   _pageController.jumpToPage(7);
                          currentIndex = 7;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Rooms",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadRoomsEvent());
                          // _pageController.jumpToPage(9);
                          currentIndex = 8;
                        },
                        iconWidget: Container()),
                    SidebarXItem(
                        label: "Treatment Prices",
                        onTap: () {
                          bloc.add(SettingsBloc_LoadTreatmentPricesEvent());

                          //   _pageController.jumpToPage(10);
                          currentIndex = 9;
                        },
                        iconWidget: Container()),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: BlocBuilder<SettingsBloc, SettingsBloc_States>(
                    buildWhen: (previous, current) =>
                        current is SettingsBloc_LoadedImplantCompaniesSuccessfullyState ||
                        current is SettingsBloc_LoadingImplantCompaniesState ||
                        current is SettingsBloc_LoadingImplantCompaniesErrorState ||
                        current is SettingsBloc_LoadedExpensesCategoriesSuccessfullyState ||
                        current is SettingsBloc_LoadingExpensesCategoriesErrorState ||
                        current is SettingsBloc_LoadingExpensesCategoriesState ||
                        current is SettingsBloc_LoadedTacsSuccessfullyState ||
                        current is SettingsBloc_LoadingTacsErrorState ||
                        current is SettingsBloc_LoadingTacsState ||
                        current is SettingsBloc_LoadingMembraneCompaniesErrorState ||
                        current is SettingsBloc_LoadingMembraneCompaniesState ||
                        current is SettingsBloc_LoadedMembraneCompaniesSuccessfullyState ||
                        current is SettingsBloc_LoadedIncomeCategoriesSuccessfullyState ||
                        current is SettingsBloc_LoadingIncomeCategoriesState ||
                        current is SettingsBloc_LoadingIncomeCategoriesErrorState ||
                        current is SettingsBloc_LoadedStockCategoriesSuccessfullyState ||
                        current is SettingsBloc_LoadingStockCategoriesErrorState ||
                        current is SettingsBloc_LoadingStockCategoriesState ||
                        current is SettingsBloc_LoadedSuppliersSuccessfullyState ||
                        current is SettingsBloc_LoadingSuppliersErrorState ||
                        current is SettingsBloc_LoadingSuppliersState ||
                        current is SettingsBloc_LoadedPaymentMethodsSuccessfullyState ||
                        current is SettingsBloc_LoadingPaymentMethodsErrorState ||
                        current is SettingsBloc_LoadingPaymentMethodsState ||
                        current is SettingsBloc_LoadedRoomsSuccessfullyState ||
                        current is SettingsBloc_LoadingRoomsErrorState ||
                        current is SettingsBloc_LoadingRoomsState ||
                        current is SettingsBloc_LoadedTreatmentPricesSuccessfullyState ||
                        current is SettingsBloc_LoadingTreatmentPricesErrorState ||
                        current is SettingsBloc_LoadingTreatmentPricesState,
                    builder: (context, state) {
                      if (state is SettingsBloc_LoadedImplantCompaniesSuccessfullyState ||
                          state is SettingsBloc_LoadingImplantCompaniesState ||
                          state is SettingsBloc_LoadingImplantCompaniesErrorState) {
                        List<BasicNameIdObjectEntity> implantCompanies = [];

                        int lineId = 0;
                        int companyId = 0;
                        if (state is SettingsBloc_LoadedImplantCompaniesSuccessfullyState) {
                          implantCompanies = state.data;
                        }

                        if (implantCompanies.isNotEmpty) {
                          companyId = implantCompanies.first.id!;
                          bloc.add(SettingsBloc_LoadImplantLinesEvent(companyId: implantCompanies.first.id!));
                        }
                        return Row(
                          children: [
                            state is SettingsBloc_LoadingImplantCompaniesErrorState
                                ? BigErrorPageWidget(
                                    message: state.message,
                                    fontSize: 10,
                                  )
                                : state is SettingsBloc_LoadingImplantCompaniesState
                                    ? LoadingWidget()
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: SidebarX(
                                                controller: SidebarXController(selectedIndex: 0, extended: true),
                                                showToggleButton: false,
                                                extendedTheme: SidebarXTheme(
                                                    width: 300,
                                                    selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    decoration: BoxDecoration(
                                                      border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                                                    )),
                                                items: implantCompanies
                                                    .map((e) => SidebarXItem(
                                                          label: e.name ?? "",
                                                          onTap: () {
                                                            companyId = e.id!;
                                                            bloc.add(SettingsBloc_LoadImplantLinesEvent(companyId: e.id!));
                                                          },
                                                          iconWidget: IconButton(
                                                              onPressed: () {
                                                                CIA_ShowPopUp(
                                                                  onSave: () {
                                                                    bloc.add(SettingsBloc_ChangeImplantCompanyNameEvent(value: e));
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
                                                  onSave: () => newName == "" ? null : bloc.add(SettingsBloc_AddImplantCompaniesEvent(name: newName)),
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
                            BlocBuilder<SettingsBloc, SettingsBloc_States>(
                              buildWhen: (previous, current) =>
                                  current is SettingsBloc_LoadedImplantLinesSuccessfullyState ||
                                  current is SettingsBloc_LoadingImplantLinesErrorState ||
                                  current is SettingsBloc_ChangedImplantLineNameSuccessfullyState ||
                                  current is SettingsBloc_AddedImplantLinesSuccessfullyState ||
                                  current is SettingsBloc_LoadingImplantLinesState,
                              builder: (context, state) {
                                if (state is SettingsBloc_ChangedImplantLineNameSuccessfullyState ||
                                    state is SettingsBloc_AddedImplantLinesSuccessfullyState)
                                  bloc.add(SettingsBloc_LoadImplantLinesEvent(companyId: companyId));
                                if (state is SettingsBloc_LoadedImplantLinesSuccessfullyState ||
                                    state is SettingsBloc_LoadingImplantLinesState ||
                                    state is SettingsBloc_LoadingImplantLinesErrorState) {
                                  List<BasicNameIdObjectEntity> implantLines = [];
                                  if (state is SettingsBloc_LoadedImplantLinesSuccessfullyState) implantLines = state.data;
                                  if (implantLines.isNotEmpty) {
                                    lineId = implantLines.first.id!;
                                    bloc.add(SettingsBloc_LoadImplantsEvent(lineId: implantLines.first.id!));
                                  }
                                  if (state is SettingsBloc_LoadingImplantLinesState)
                                    return LoadingWidget();
                                  else if (state is SettingsBloc_LoadingImplantLinesErrorState)
                                    return BigErrorPageWidget(
                                      message: state.message,
                                      fontSize: 10,
                                    );
                                  else
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: SidebarX(
                                              controller: SidebarXController(selectedIndex: 0, extended: true),
                                              showToggleButton: false,
                                              extendedTheme: SidebarXTheme(
                                                  width: 300,
                                                  selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  decoration: BoxDecoration(
                                                    border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                                                  )),
                                              items: implantLines
                                                  .map((e) => SidebarXItem(
                                                      label: e.name ?? "",
                                                      onTap: () {
                                                        lineId = e.id!;
                                                        bloc.add(SettingsBloc_LoadImplantsEvent(lineId: e.id!));
                                                      },
                                                      iconWidget: IconButton(
                                                          onPressed: () {
                                                            CIA_ShowPopUp(
                                                              onSave: () {
                                                                bloc.add(SettingsBloc_ChangeImplantLineNameEvent(value: e));
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
                                                onSave: () => newName == ""
                                                    ? null
                                                    : bloc.add(SettingsBloc_AddImplantLinesEvent(
                                                        value: BasicNameIdObjectEntity(
                                                        name: newName,
                                                        id: companyId,
                                                      ))),
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
                                } else
                                  return Container();
                              },
                            ),
                            Expanded(
                              child: BlocBuilder<SettingsBloc, SettingsBloc_States>(
                                buildWhen: (previous, current) =>
                                    current is SettingsBloc_LoadedImplantsSuccessfullyState ||
                                    current is SettingsBloc_LoadingImplantsErrorState ||
                                    current is SettingsBloc_LoadedImplantLinesSuccessfullyState ||
                                    current is SettingsBloc_UpdatedImplantsSuccessfullyState ||
                                    current is SettingsBloc_LoadingImplantsState,
                                builder: (context, state) {
                                  if (state is SettingsBloc_LoadedImplantsSuccessfullyState ||
                                      state is SettingsBloc_LoadingImplantsErrorState ||
                                      state is SettingsBloc_UpdatedImplantsSuccessfullyState ||
                                      state is SettingsBloc_LoadingImplantsState) {
                                    List<ImplantEntity> implants = [];
                                    if (state is SettingsBloc_UpdatedImplantsSuccessfullyState)
                                      bloc.add(SettingsBloc_LoadImplantsEvent(lineId: lineId));
                                    if (state is SettingsBloc_LoadedImplantsSuccessfullyState)
                                      implants = state.data as List<ImplantEntity>;
                                    else if (state is SettingsBloc_LoadingImplantsErrorState)
                                      return BigErrorPageWidget(
                                        message: state.message,
                                        fontSize: 10,
                                      );
                                    else if (state is SettingsBloc_LoadingImplantsState) return LoadingWidget();
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              children: implants
                                                  .map((e) => Padding(
                                                        padding: EdgeInsets.only(bottom: 10),
                                                        child: CIA_TextFormField(
                                                          label: "Size",
                                                          controller: TextEditingController(text: e.size ?? ""),
                                                          onChange: (value) => e.size = value,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CIA_SecondaryButton(
                                                  label: "Add New",
                                                  onTab: () {
                                                    String newSize = "";
                                                    CIA_ShowPopUp(
                                                        onSave: () {
                                                          implants = [
                                                            ...implants,
                                                            ImplantEntity(
                                                              count: 0,
                                                              size: newSize,
                                                            ),
                                                          ];
                                                          bloc.add(SettingsBloc_UpdateImplantsEvent(
                                                              value: UpdateImplantsParams(
                                                            data: implants,
                                                            lineId: lineId,
                                                          )));
                                                        },
                                                        context: context,
                                                        child: CIA_TextFormField(
                                                          label: "Size",
                                                          controller: TextEditingController(text: ""),
                                                          onChange: (value) => newSize = value,
                                                        ));
                                                  }),
                                              CIA_PrimaryButton(
                                                  isLong: true,
                                                  label: "Save",
                                                  onTab: () {
                                                    bloc.add(SettingsBloc_UpdateImplantsEvent(
                                                        value: UpdateImplantsParams(data: implants, lineId: lineId)));
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else
                                    return Container();
                                },
                              ),
                            )
                          ],
                        );
                      } else if (state is SettingsBloc_LoadedMembraneCompaniesSuccessfullyState ||
                          state is SettingsBloc_LoadingMembraneCompaniesState ||
                          state is SettingsBloc_LoadingMembraneCompaniesErrorState) {
                        List<BasicNameIdObjectEntity> membraneCompanies = [];
                        if (state is SettingsBloc_LoadedMembraneCompaniesSuccessfullyState) membraneCompanies = state.data;
                        int membraneCompanyId = 0;
                        if (membraneCompanies.isNotEmpty) {
                          membraneCompanyId = membraneCompanies.first.id!;
                          bloc.add(SettingsBloc_LoadMembranesEvent(id: membraneCompanies.first.id!));
                        }
                        return Row(
                          children: [
                            state is SettingsBloc_LoadingMembraneCompaniesState
                                ? LoadingWidget()
                                : state is SettingsBloc_LoadingMembraneCompaniesErrorState
                                    ? BigErrorPageWidget(
                                        message: state.message,
                                        fontSize: 10,
                                      )
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: SidebarX(
                                                controller: SidebarXController(selectedIndex: 0, extended: true),
                                                showToggleButton: false,
                                                extendedTheme: SidebarXTheme(
                                                    width: 300,
                                                    selectedTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    decoration: BoxDecoration(
                                                      border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey)),
                                                    )),
                                                items: membraneCompanies
                                                    .map((e) => SidebarXItem(
                                                        label: e.name ?? "",
                                                        onTap: () {
                                                          membraneCompanyId = e.id!;
                                                          bloc.add(SettingsBloc_LoadMembranesEvent(id: e.id!));
                                                        },
                                                        iconWidget: IconButton(
                                                            onPressed: () {
                                                              CIA_ShowPopUp(
                                                                onSave: () {
                                                                  bloc.add(SettingsBloc_AddMembraneCompaniesEvent(model: membraneCompanies));
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
                                                    if (newName != "") {
                                                      membraneCompanies = [
                                                        ...membraneCompanies,
                                                        MembraneCompanyEntity(
                                                          name: newName,
                                                        )
                                                      ];
                                                      bloc.add(SettingsBloc_AddMembraneCompaniesEvent(model: membraneCompanies));
                                                    }
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
                            BlocBuilder<SettingsBloc, SettingsBloc_States>(
                              buildWhen: (previous, current) =>
                                  current is SettingsBloc_LoadedMembranesSuccessfullyState ||
                                  current is SettingsBloc_LoadingMembranesState ||
                                  current is SettingsBloc_AddedMembranesSuccessfullyState ||
                                  current is SettingsBloc_LoadingMembranesErrorState,
                              builder: (context, state) {
                                if (state is SettingsBloc_LoadedMembranesSuccessfullyState ||
                                    state is SettingsBloc_LoadingMembranesState ||
                                    state is SettingsBloc_AddedMembranesSuccessfullyState ||
                                    state is SettingsBloc_LoadingMembranesErrorState) {
                                  if (state is SettingsBloc_AddedMembranesSuccessfullyState)
                                    bloc.add(SettingsBloc_LoadMembranesEvent(id: membraneCompanyId));
                                  List<MembraneEntity> membranes = [];
                                  if (state is SettingsBloc_LoadedMembranesSuccessfullyState) membranes = state.data as List<MembraneEntity>;
                                  return Expanded(
                                    child: state is SettingsBloc_LoadingMembranesState
                                        ? LoadingWidget()
                                        : state is SettingsBloc_LoadingMembranesErrorState
                                            ? BigErrorPageWidget(
                                                message: state.message,
                                                fontSize: 10,
                                              )
                                            : Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      children: membranes
                                                          .map((e) => Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: CIA_TextFormField(
                                                                  label: "Size",
                                                                  controller: TextEditingController(text: e.size ?? ""),
                                                                  onChange: (value) => e.size = value,
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CIA_SecondaryButton(
                                                          label: "Add New",
                                                          onTab: () {
                                                            String newSize = "";
                                                            CIA_ShowPopUp(
                                                                onSave: () {
                                                                  membranes = [
                                                                    ...membranes,
                                                                    MembraneEntity(
                                                                      size: newSize,
                                                                    ),
                                                                  ];
                                                                  bloc.add(SettingsBloc_AddMembranesEvent(
                                                                      value: AddMembraneParams(data: membranes, companyId: membraneCompanyId)));
                                                                },
                                                                context: context,
                                                                child: CIA_TextFormField(
                                                                  label: "Size",
                                                                  controller: TextEditingController(text: ""),
                                                                  onChange: (value) => newSize = value,
                                                                ));
                                                          }),
                                                      CIA_PrimaryButton(
                                                          isLong: true,
                                                          label: "Save",
                                                          onTab: () => bloc.add(SettingsBloc_AddMembranesEvent(
                                                                  value: AddMembraneParams(
                                                                data: membranes,
                                                                companyId: membraneCompanyId,
                                                              )))),
                                                    ],
                                                  )
                                                ],
                                              ),
                                  );
                                } else
                                  return Container();
                              },
                            ),
                          ],
                        );
                      } else if (state is SettingsBloc_LoadedTacsSuccessfullyState ||
                          state is SettingsBloc_LoadingTacsState ||
                          state is SettingsBloc_LoadingTacsErrorState) {
                        List<TacCompanyEntity> tacCompanies = [];
                        if (state is SettingsBloc_LoadedTacsSuccessfullyState)
                          tacCompanies = state.data as List<TacCompanyEntity>;
                        else if (state is SettingsBloc_LoadingTacsState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingTacsErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: tacCompanies
                                      .map((e) => Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CIA_TextFormField(
                                                    label: "Name",
                                                    controller: TextEditingController(text: e.name ?? ""),
                                                    onChange: (value) {
                                                      e.name = value;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CIA_TextFormField(
                                                    label: "Count",
                                                    controller: TextEditingController(text: e.count?.toString() ?? ""),
                                                    isNumber: true,
                                                    onChange: (value) {
                                                      e.count = int.parse(value);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        int count = 0;
                                        String name = "";
                                        CIA_ShowPopUp(
                                            context: context,
                                            title: "Add new",
                                            onSave: () {
                                              tacCompanies = [...tacCompanies, TacCompanyEntity(count: count, name: name)];
                                              bloc.add(SettingsBloc_AddTacsCompaniesEvent(
                                                model: tacCompanies,
                                              ));
                                            },
                                            child: Column(
                                              children: [
                                                CIA_TextFormField(
                                                  label: "Name",
                                                  onChange: (value) => name = value,
                                                  controller: TextEditingController(text: ""),
                                                ),
                                                SizedBox(height: 10),
                                                CIA_TextFormField(
                                                  label: "Count",
                                                  isNumber: true,
                                                  onChange: (value) => count = int.parse(value),
                                                  controller: TextEditingController(text: "0"),
                                                ),
                                              ],
                                            ));
                                      }),
                                  CIA_PrimaryButton(
                                      isLong: true, label: "Save", onTab: () => bloc.add(SettingsBloc_AddTacsCompaniesEvent(model: tacCompanies))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedExpensesCategoriesSuccessfullyState ||
                          state is SettingsBloc_LoadingExpensesCategoriesState ||
                          state is SettingsBloc_LoadingExpensesCategoriesErrorState) {
                        List<BasicNameIdObjectEntity> expensesCategories = [];
                        if (state is SettingsBloc_LoadedExpensesCategoriesSuccessfullyState)
                          expensesCategories = state.data as List<BasicNameIdObjectEntity>;
                        else if (state is SettingsBloc_LoadingExpensesCategoriesState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingExpensesCategoriesErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: expensesCategories
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              controller: TextEditingController(text: e.name ?? ""),
                                              onChange: (value) {
                                                e.name = value;
                                              },
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        String name = "";
                                        CIA_ShowPopUp(
                                            context: context,
                                            title: "Add new",
                                            onSave: () {
                                              expensesCategories = [...expensesCategories, BasicNameIdObjectEntity(name: name)];
                                              bloc.add(SettingsBloc_AddExpensesCategoriesEvent(
                                                model: expensesCategories,
                                              ));
                                            },
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              onChange: (value) => name = value,
                                              controller: TextEditingController(text: ""),
                                            ));
                                      }),
                                  CIA_PrimaryButton(
                                      isLong: true,
                                      label: "Save",
                                      onTab: () => bloc.add(SettingsBloc_AddExpensesCategoriesEvent(model: expensesCategories))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedIncomeCategoriesSuccessfullyState ||
                          state is SettingsBloc_LoadingIncomeCategoriesState ||
                          state is SettingsBloc_LoadingIncomeCategoriesErrorState) {
                        List<BasicNameIdObjectEntity> incomeCategories = [];
                        if (state is SettingsBloc_LoadedIncomeCategoriesSuccessfullyState)
                          incomeCategories = state.data as List<BasicNameIdObjectEntity>;
                        else if (state is SettingsBloc_LoadingIncomeCategoriesState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingIncomeCategoriesErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: incomeCategories
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              controller: TextEditingController(text: e.name ?? ""),
                                              onChange: (value) {
                                                e.name = value;
                                              },
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        String name = "";
                                        CIA_ShowPopUp(
                                            context: context,
                                            title: "Add new",
                                            onSave: () {
                                              incomeCategories = [...incomeCategories, BasicNameIdObjectEntity(name: name)];
                                              bloc.add(SettingsBloc_AddIncomeCategoriesEvent(
                                                model: incomeCategories,
                                              ));
                                            },
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              onChange: (value) => name = value,
                                              controller: TextEditingController(text: ""),
                                            ));
                                      }),
                                  CIA_PrimaryButton(
                                      isLong: true,
                                      label: "Save",
                                      onTab: () => bloc.add(SettingsBloc_AddIncomeCategoriesEvent(model: incomeCategories))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedStockCategoriesSuccessfullyState ||
                          state is SettingsBloc_LoadingStockCategoriesErrorState ||
                          state is SettingsBloc_LoadingStockCategoriesState) {
                        List<BasicNameIdObjectEntity> stockCategories = [];
                        if (state is SettingsBloc_LoadedStockCategoriesSuccessfullyState)
                          stockCategories = state.data as List<BasicNameIdObjectEntity>;
                        else if (state is SettingsBloc_LoadingStockCategoriesState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingStockCategoriesErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: stockCategories
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              controller: TextEditingController(text: e.name ?? ""),
                                              onChange: (value) {
                                                e.name = value;
                                              },
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        String name = "";
                                        CIA_ShowPopUp(
                                            context: context,
                                            title: "Add new",
                                            onSave: () {
                                              stockCategories = [...stockCategories, BasicNameIdObjectEntity(name: name)];
                                              bloc.add(SettingsBloc_AddStockCategoriesEvent(
                                                model: stockCategories,
                                              ));
                                            },
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              onChange: (value) => name = value,
                                              controller: TextEditingController(text: ""),
                                            ));
                                      }),
                                  CIA_PrimaryButton(
                                      isLong: true,
                                      label: "Save",
                                      onTab: () => bloc.add(SettingsBloc_AddStockCategoriesEvent(model: stockCategories))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedSuppliersSuccessfullyState ||
                          state is SettingsBloc_LoadingSuppliersErrorState ||
                          state is SettingsBloc_LoadingSuppliersState) {
                        List<BasicNameIdObjectEntity> Suppliers = [];
                        if (state is SettingsBloc_LoadedSuppliersSuccessfullyState)
                          Suppliers = state.data as List<BasicNameIdObjectEntity>;
                        else if (state is SettingsBloc_LoadingSuppliersState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingSuppliersErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: Suppliers.map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CIA_TextFormField(
                                          label: "Name",
                                          controller: TextEditingController(text: e.name ?? ""),
                                          onChange: (value) {
                                            e.name = value;
                                          },
                                        ),
                                      )).toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        String name = "";
                                        CIA_ShowPopUp(
                                            context: context,
                                            title: "Add new",
                                            onSave: () {
                                              Suppliers = [...Suppliers, BasicNameIdObjectEntity(name: name)];
                                              bloc.add(SettingsBloc_AddSuppliersEvent(
                                                  params: AddSuppliersParams(
                                                medical: false,
                                                model: Suppliers,
                                              )));
                                            },
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              onChange: (value) => name = value,
                                              controller: TextEditingController(text: ""),
                                            ));
                                      }),
                                  CIA_PrimaryButton(
                                      isLong: true,
                                      label: "Save",
                                      onTab: () => bloc.add(SettingsBloc_AddSuppliersEvent(
                                              params: AddSuppliersParams(
                                            medical: false,
                                            model: Suppliers,
                                          )))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedPaymentMethodsSuccessfullyState ||
                          state is SettingsBloc_LoadingPaymentMethodsErrorState ||
                          state is SettingsBloc_LoadingPaymentMethodsState) {
                        List<BasicNameIdObjectEntity> PaymentMethods = [];
                        if (state is SettingsBloc_LoadedPaymentMethodsSuccessfullyState)
                          PaymentMethods = state.data as List<BasicNameIdObjectEntity>;
                        else if (state is SettingsBloc_LoadingPaymentMethodsState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingPaymentMethodsErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: PaymentMethods.map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CIA_TextFormField(
                                          label: "Name",
                                          controller: TextEditingController(text: e.name ?? ""),
                                          onChange: (value) {
                                            e.name = value;
                                          },
                                        ),
                                      )).toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        String name = "";
                                        CIA_ShowPopUp(
                                            context: context,
                                            title: "Add new",
                                            onSave: () {
                                              PaymentMethods = [...PaymentMethods, BasicNameIdObjectEntity(name: name)];
                                              bloc.add(SettingsBloc_AddPaymentMethodsEvent(
                                                model: PaymentMethods,
                                              ));
                                            },
                                            child: CIA_TextFormField(
                                              label: "Name",
                                              onChange: (value) => name = value,
                                              controller: TextEditingController(text: ""),
                                            ));
                                      }),
                                  CIA_PrimaryButton(
                                      isLong: true, label: "Save", onTab: () => bloc.add(SettingsBloc_AddPaymentMethodsEvent(model: PaymentMethods))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedRoomsSuccessfullyState ||
                          state is SettingsBloc_LoadingRoomsErrorState ||
                          state is SettingsBloc_LoadingRoomsState) {
                        List<RoomEntity> Rooms = [];
                        if (state is SettingsBloc_LoadedRoomsSuccessfullyState)
                          Rooms = state.data;
                        else if (state is SettingsBloc_LoadingRoomsState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingRoomsErrorState) return BigErrorPageWidget(message: state.message);
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: Rooms.map((e) => Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CIA_TextFormField(
                                                label: "Name",
                                                controller: TextEditingController(text: e.name ?? ""),
                                                onChange: (value) {
                                                  e.name = value;
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CIA_GestureWidget(
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
                                                            (element) => CIA_GestureWidget(
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
                                                                    border: Border.all(
                                                                        color: selectedColor == element ? Colors.yellow : element, width: 3),
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
                                                  onSave: () {
                                                    e.color = selectedColor;
                                                    bloc.emit(SettingsBloc_LoadedRoomsSuccessfullyState(data: Rooms));
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                color: e.color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )).toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CIA_SecondaryButton(
                                      label: "Add New",
                                      onTab: () {
                                        String name = "";
                                        Color selectedColor = Colors.red;
                                        CIA_ShowPopUp(
                                          context: context,
                                          child: StatefulBuilder(
                                            builder: (context, setState) {
                                              return Column(
                                                children: [
                                                  CIA_TextFormField(
                                                    label: "Name",
                                                    controller: TextEditingController(text: name),
                                                    onChange: (value) => name = value,
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
                                                          (e) => CIA_GestureWidget(
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
                                          title: "Add new",
                                          onSave: () {
                                            Rooms = [...Rooms, RoomEntity(name: name, color: selectedColor)];
                                            bloc.add(SettingsBloc_EditRoomsEvent(
                                              model: Rooms,
                                            ));
                                          },
                                        );
                                      }),
                                  CIA_PrimaryButton(isLong: true, label: "Save", onTab: () => bloc.add(SettingsBloc_EditRoomsEvent(model: Rooms))),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (state is SettingsBloc_LoadedTreatmentPricesSuccessfullyState ||
                          state is SettingsBloc_LoadingTreatmentPricesErrorState ||
                          state is SettingsBloc_LoadingTreatmentPricesState) {
                        if (state is SettingsBloc_LoadedTreatmentPricesSuccessfullyState) {
                          var treatmentItems = state.data;
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                      children: treatmentItems
                                          .map(
                                            (e) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  CIA_TextFormField(
                                                    label: e.name ?? "",
                                                    isNumber: true,
                                                    controller: TextEditingController(text: e.price?.toString() ?? ""),
                                                    onChange: (value) {
                                                      e.price = int.tryParse(value) ?? 0;
                                                    },
                                                  ),
                                                  CIA_CheckBoxWidget(
                                                      text: "Allow Assign", value: e.allowAssign, onChange: (value) => e.allowAssign = value),
                                                  CIA_CheckBoxWidget(
                                                      text: "Show in surgial",
                                                      value: e.showInSurgical,
                                                      onChange: (value) => e.showInSurgical = value),
                                                  CIA_CheckBoxWidget(
                                                      text: "Apply on all teeth",
                                                      value: e.allTeeth,
                                                      onChange: (value) => e.allTeeth = value),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList()),
                                ),
                                Row(
                                  children: [
                                    CIA_PrimaryButton(
                                        isLong: true,
                                        label: "Save",
                                        onTab: () => bloc.add(SettingsBloc_EditTreatmentPricesEvent(prices: treatmentItems))),
                                    CIA_SecondaryButton(
                                        label: "Add New",
                                        onTab: () {
                                          CIA_ShowPopUp(
                                              context: context,
                                              child: Column(
                                                children: [],
                                              ));
                                        })
                                  ],
                                )
                              ],
                            ),
                          );
                        } else if (state is SettingsBloc_LoadingTreatmentPricesState)
                          return LoadingWidget();
                        else if (state is SettingsBloc_LoadingTreatmentPricesErrorState) return BigErrorPageWidget(message: state.message);
                      }

                      return Container();
                    },
                  ),
                )
              ],
            ),
    );
  }
}
