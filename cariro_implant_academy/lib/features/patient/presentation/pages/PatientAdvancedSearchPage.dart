import 'package:cariro_implant_academy/Widgets/CIA_TagsInputWidget.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/advancedSearchBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/advancedSearchFiltersSummaryWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/advancedSearchProstheticFiltersWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/widgets/advancedSearchTreatmentFiltersWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/pages/prsotheticTreatmentPage.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Widgets/CIA_SecondaryButton.dart';
import '../../../../Widgets/Title.dart';
import '../../../patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import '../../../patientsMedical/treatmentFeature/presentation/pages/treatmentPlanPage.dart';
import '../bloc/advancedSearchBloc.dart';
import '../widgets/advancedSearchPatientFiltersWidget.dart';
import 'createOrViewPatientPage.dart';

enum AdvancedSearchEnum { Patient, Treatments, Prosthetic }

enum _ProstheticSearchType {
  DiagnosticImpression,
  ScanAppliance,
  Bite,
  SingleAndBridge,
  FullArch,
}

enum _FinalProstheticSearchType {
  HealingCollar,
  Impression,
  TryIn,
  Delivery,
}

class PatientAdvancedSearchPage extends StatefulWidget {
  PatientAdvancedSearchPage({Key? key, required this.advancedSearchType}) : super(key: key);
  static String routeNamePatients = "PatientsAdvancedSearch";
  static String routeNameTreatments = "TreatmentAdvancedSearch";
  static String routeNameProsthetic = "ProstheticAdvancedSearch";
  static String routePathPatients = "AdvancedSearch/PatientsAdvancedSearch";
  static String routePathTreatments = "AdvancedSearch/TreatmentAdvancedSearch";
  static String routePathProsthetic = "AdvancedSearch/ProstheticAdvancedSearch";
  AdvancedSearchEnum advancedSearchType;

  @override
  State<PatientAdvancedSearchPage> createState() => _PatientsSearchPageState();
}

class _PatientsSearchPageState extends State<PatientAdvancedSearchPage> with TickerProviderStateMixin {
  AdvancedPatientSearchDataGridSource dataSource_patients = AdvancedPatientSearchDataGridSource();
  late AdvancedTreatmentSearchDataGridSource dataSource_treatments;
  AdvancedProstheticSearchDataGridSource dataSource_prosthetic = AdvancedProstheticSearchDataGridSource();
  AdvancedPatientSearchEntity searchDTO = AdvancedPatientSearchEntity();
  AdvancedTreatmentSearchEntity searchTreatmentsDTO = AdvancedTreatmentSearchEntity(done: false);
  AdvancedProstheticSearchRequestEntity searchProstheticDTO = AdvancedProstheticSearchRequestEntity();

  late AdvancedSearchBloc bloc;
  late TabController tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late TreatmentBloc treatmentBloc = treatmentBloc;

  @override
  void initState() {
    dataSource_treatments = AdvancedTreatmentSearchDataGridSource(goToPatient: (id) {
      if (searchTreatmentsDTO.done == true) {
        context.goNamed(SurgicalTreatmentPage.getRouteName(), pathParameters: {"id": id.toString()});
      } else {
        context.goNamed(TreatmentPage.getRouteName(), pathParameters: {"id": id.toString()});
      }
    });
    bloc = sl<AdvancedSearchBloc>();
    treatmentBloc = BlocProvider.of<TreatmentBloc>(context);
    treatmentBloc.add(TreatmentBloc_GetTreatmentItemsEvent());
    search(type: widget.advancedSearchType);
    tabController = TabController(length: 3, vsync: this);
    tabController.index = (widget.advancedSearchType == AdvancedSearchEnum.Treatments
        ? 1
        : widget.advancedSearchType == AdvancedSearchEnum.Patient
            ? 0
            : 2);
  }

  search({required AdvancedSearchEnum type}) {
    bloc.add(AdvancedSearchBloc_SearchPatientsEvents(
      patientQuery: searchDTO,
      treatmentQuery: searchTreatmentsDTO,
      prostheticQuery: searchProstheticDTO,
      type: type,
    ));
  }

  List<TreatmentItemEntity> treatmentItems = [];
  List<BasicNameIdObjectEntity> prostheticItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  addAutomaticKeepAlives: true,
                  children: [
                    AdvancedSearchPatientFilterWidget(searchDTO: searchDTO),
                    BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                        buildWhen: (previous, current) =>
                            current is TreatmentBloc_LoadingTreatmentItemsErrorState ||
                            current is TreatmentBloc_LoadingTreatmentItemsTreatmentDataState ||
                            current is TreatmentBloc_LoadedTreatmentItemsSuccessfullyState,
                        builder: (context, state) {
                          if (state is TreatmentBloc_LoadingTreatmentItemsErrorState)
                            return BigErrorPageWidget(message: state.message);
                          else if (state is TreatmentBloc_LoadingTreatmentItemsTreatmentDataState)
                            return LoadingWidget();
                          else if (state is TreatmentBloc_LoadedTreatmentItemsSuccessfullyState) {
                            treatmentItems = state.data;
                            return AdvancedSearchTreatmentFilterWidget(
                              searchTreatmentsDTO: searchTreatmentsDTO,
                              treatmentItems: treatmentItems,
                            );
                          }
                          return Container();
                        }),
                    AdvancedSearchProstheticFilterWidget(
                      searchProstheticDTO: searchProstheticDTO,
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CIA_SecondaryButton(label: "Dismiss", onTab: () => _key.currentState!.closeEndDrawer()),
                    const SizedBox(width: 10),
                    CIA_PrimaryButton(
                        label: "Search",
                        isLong: true,
                        onTab: () {
                          _key.currentState!.closeEndDrawer();
                          search(type: widget.advancedSearchType);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      drawerScrimColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TitleWidget(
                  title: "Advanced Search",
                  showBackButton: false,
                ),
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, _setState) {
                      search(type: widget.advancedSearchType);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.advancedSearchType == AdvancedSearchEnum.Patient
                                  ? CIA_PrimaryButton(label: "Personal Info", isLong: true, onTab: () => null)
                                  : CIA_SecondaryButton(
                                      label: "Personal Info",
                                      onTab: () => _setState(
                                            () => widget.advancedSearchType = AdvancedSearchEnum.Patient,
                                          )),
                              const SizedBox(width: 10),
                              widget.advancedSearchType == AdvancedSearchEnum.Treatments
                                  ? CIA_PrimaryButton(label: "Treatments", isLong: true, onTab: () => null)
                                  : CIA_SecondaryButton(
                                      label: "Treatments",
                                      onTab: () => _setState(
                                            () => widget.advancedSearchType = AdvancedSearchEnum.Treatments,
                                          )),
                              const SizedBox(width: 10),
                              widget.advancedSearchType == AdvancedSearchEnum.Prosthetic
                                  ? CIA_PrimaryButton(label: "Prosthetic", isLong: true, onTab: () => null)
                                  : CIA_SecondaryButton(
                                      label: "Prosthetic",
                                      onTab: () => _setState(
                                            () => widget.advancedSearchType = AdvancedSearchEnum.Prosthetic,
                                          )),
                            ],
                          ),
                          Visibility(
                            visible: widget.advancedSearchType == AdvancedSearchEnum.Treatments,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FormTextValueWidget(text: "Done"),
                                  const SizedBox(width: 10),
                                  Container(
                                    color: Colors.green,
                                    width: 10,
                                    height: 10,
                                  ),
                                  const SizedBox(width: 10),
                                  FormTextValueWidget(text: "Planned"),
                                  const SizedBox(width: 10),
                                  Container(
                                    color: Colors.orange,
                                    width: 10,
                                    height: 10,
                                  ),
                                  const SizedBox(width: 10),
                                  FormTextValueWidget(text: "Failed"),
                                  const SizedBox(width: 10),
                                  Container(
                                    color: Colors.red,
                                    width: 10,
                                    height: 10,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                /*
                    CIA_SecondaryButton(
                        label: "Load Last Filter",
                        onTab: () {
                          searchTreatmentsDTO = bloc.searchTreatmentQuery;
                          searchDTO = bloc.searchPatientQuery;
                          searchProstheticDTO = bloc.searchProstheticQuery;
                          search(type: widget.advancedSearchType);
                          //bloc.add(AdvancedSearchBloc_SearchPatientsEvents(query: searchDTO));
                        }),*/
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () => _key.currentState!.openEndDrawer(),
                  icon: const Icon(Icons.filter_alt),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocConsumer<AdvancedSearchBloc, AdvancedSearchBloc_States>(listener: (context, state) {
              if (state is AdvancedSearchBloc_LoadedPatientsSuccessfullyState) {
                dataSource_patients.updateData(searchResults: state.data, searchQuery: searchDTO);
              } else if (state is AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState) {
                dataSource_treatments.updateData(
                  state.data,
                  searchTreatmentsDTO,
                );
              } else if (state is AdvancedSearchBloc_LoadedProstheticSuccessfullyState) {
                dataSource_prosthetic.updateData(
                  response: state.data,
                  request: searchProstheticDTO,
                );
              }
            }, builder: (context, state) {
              if (state is AdvancedSearchBloc_LoadingErrorState) {
                return BigErrorPageWidget(message: state.message);
              } else if (state is AdvancedSearchBloc_LoadingState) return const LoadingWidget();
              {
                switch (widget.advancedSearchType) {
                  case AdvancedSearchEnum.Treatments:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AdvancedSearchFiltersSummaryWidget(
                          treatmentItems: treatmentItems,
                          searchDTO: searchDTO,
                          searchProstheticDTO: searchProstheticDTO,
                          searchTreatmentsDTO: searchTreatmentsDTO,
                          onRemove: (onRemoveSearchDTO, onRemoveSearchTreatmentsDTO, onRemoveSearchProstheticDTO) {
                            searchDTO = onRemoveSearchDTO;
                            searchTreatmentsDTO = onRemoveSearchTreatmentsDTO;
                            searchProstheticDTO = onRemoveSearchProstheticDTO;
                            search(type: widget.advancedSearchType);
                          },
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: TableWidget(
                            key: GlobalKey(),
                            headerHeight: 60,
                            headerStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            dataSource: dataSource_treatments,
                            allowGroupingCollapse: true,
                            onCellClick: (value) {
                              // setState(() {
                              //selectedPatientID = dataSource.models[value - 1].id!;

                              //});
                              //internalPagesController.jumpToPage(1);
                              // if (searchTreatmentsDTO.done == true) {
                              //   context.goNamed(SurgicalTreatmentPage.getRouteName(), pathParameters: {
                              //     "id": dataSource_treatments.models.firstWhere((element) => element.secondaryId == value).id.toString()
                              //   });
                              // } else {
                              //   context.goNamed(TreatmentPage.getRouteName(), pathParameters: {
                              //     "id": dataSource_treatments.models.firstWhere((element) => element.secondaryId == value).id.toString()
                              //   });
                              // }
                              print(value);
                            },
                          ),
                        ),
                        const Divider(),
                        Container(
                          height: 40,
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              FormTextKeyWidget(text: "Total Patients: "),
                              FormTextValueWidget(text: dataSource_treatments.models.map((e) => e.id).toSet().length.toString()),
                            ],
                          ),
                        ),
                      ],
                    );
                  case AdvancedSearchEnum.Prosthetic:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AdvancedSearchFiltersSummaryWidget(
                          treatmentItems: treatmentItems,
                          searchDTO: searchDTO,
                          searchProstheticDTO: searchProstheticDTO,
                          searchTreatmentsDTO: searchTreatmentsDTO,
                          onRemove: (onRemoveSearchDTO, onRemoveSearchTreatmentsDTO, onRemoveSearchProstheticDTO) {
                            searchDTO = onRemoveSearchDTO;
                            searchTreatmentsDTO = onRemoveSearchTreatmentsDTO;
                            searchProstheticDTO = onRemoveSearchProstheticDTO;
                            search(type: widget.advancedSearchType);
                          },
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: TableWidget(
                            key: GlobalKey(),
                            headerHeight: 60,
                            headerStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            dataSource: dataSource_prosthetic,
                            onCellClick: (value) {
                              // setState(() {
                              //selectedPatientID = dataSource.models[value - 1].id!;

                              //});
                              //internalPagesController.jumpToPage(1);
                              context.goNamed(ProstheticTreatmentPage.routeName, pathParameters: {
                                "id": dataSource_prosthetic.models.firstWhere((element) => element.secondaryId == value).id.toString()
                              });
                            },
                          ),
                        ),
                        const Divider(),
                        Container(
                          height: 40,
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              FormTextKeyWidget(text: "Total: "),
                              FormTextValueWidget(text: dataSource_prosthetic.models.length.toString()),
                            ],
                          ),
                        ),
                      ],
                    );

                  default:
                    return Column(
                      children: [
                        AdvancedSearchFiltersSummaryWidget(
                          treatmentItems: treatmentItems,
                          searchDTO: searchDTO,
                          searchProstheticDTO: searchProstheticDTO,
                          searchTreatmentsDTO: searchTreatmentsDTO,
                          onRemove: (onRemoveSearchDTO, onRemoveSearchTreatmentsDTO, onRemoveSearchProstheticDTO) {
                            searchDTO = onRemoveSearchDTO;
                            searchTreatmentsDTO = onRemoveSearchTreatmentsDTO;
                            searchProstheticDTO = onRemoveSearchProstheticDTO;
                            search(type: widget.advancedSearchType);
                          },
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: TableWidget(
                            key: GlobalKey(),
                            allowSorting: true,
                            dataSource: dataSource_patients,
                            onCellClick: (value) {
                              // setState(() {
                              //selectedPatientID = dataSource.models[value - 1].id!;

                              //});
                              //internalPagesController.jumpToPage(1);
                              print(value);
                              context.goNamed(CreateOrViewPatientPage.getVisitPatientRouteName(), pathParameters: {
                                "id": dataSource_patients.models.firstWhere((element) => element.secondaryId == value).id.toString()
                              });
                            },
                          ),
                        ),
                        FormTextKeyWidget(text: "Count :${dataSource_patients.models?.length?.toString()}")
                      ],
                    );
                }
              }

              return Container();
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bloc.searchTreatmentQuery = searchTreatmentsDTO;
    bloc.searchPatientQuery = searchDTO;
    bloc.searchProstheticQuery = searchProstheticDTO;
    super.dispose();
  }
}
