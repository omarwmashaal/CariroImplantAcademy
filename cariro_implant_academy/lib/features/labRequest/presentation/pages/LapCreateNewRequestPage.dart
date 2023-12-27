import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadWorPlacesUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/getDefaultStepsUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/searchLabPatientsByTypeUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestBloc.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_Events.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/blocs/labRequestsBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/presentation/widgets/labRequestItemWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/patientSearchBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/createOrViewPatientPage.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../Constants/Colors.dart';
import '../../../../Constants/Controllers.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../Widgets/CIA_TeethChart.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/FormTextWidget.dart';
import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../Widgets/SnackBar.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../core/injection_contianer.dart';
import '../../../../presentation/widgets/customeLoader.dart';
import '../../../user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../../domain/entities/labStepEntity.dart';

class LabCreateNewRequestPage extends StatefulWidget {
  LabCreateNewRequestPage({
    Key? key,
    this.isDoctor = false,
    this.onChange,
    this.patientId,
    this.fixDismiss = false,
  }) : super(key: key);
  static String routeName = "CreateRequest";
  static String routeNameClinic = "ClinicCreateRequest";
  static String routePath = "CreateRequest";
  bool isDoctor;
  Function? onChange;
  int? patientId;
  bool fixDismiss;

  @override
  State<LabCreateNewRequestPage> createState() => _LabCreateNewRequestPageState();
}

class _LabCreateNewRequestPageState extends State<LabCreateNewRequestPage> {
  late LabRequestsBloc bloc;
  late UsersBloc usersBloc;
  late CreateOrViewPatientBloc patientBloc;
  LabRequestEntity labRequest = LabRequestEntity(
    steps: [
      LabStepEntity(
        step: BasicNameIdObjectEntity(
          name: "Scan",
        ),
      ),
      LabStepEntity(
        step: BasicNameIdObjectEntity(
          name: "Design",
        ),
      ),
    ],
  );

  @override
  void initState() {
    bloc = BlocProvider.of<LabRequestsBloc>(context);
    usersBloc = BlocProvider.of<UsersBloc>(context);
    patientBloc = BlocProvider.of<CreateOrViewPatientBloc>(context);
    if (widget.isDoctor) {
      labRequest.customer = UserEntity(
        name: siteController.getUserName(),
        idInt: siteController.getUserId(),
        phoneNumber: siteController.getUserPhoneNumber(),
      );
      labRequest.customerId = siteController.getUserId();
    }
    if (widget.patientId != null) {
      patientBloc.add(GetPatientInfoEvent(id: widget.patientId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
            listener: (context, state) {
              if (state is CreatedPatientState) {
                bloc.emit(LabRequestsBloc_ChangedPatientState(
                    patient: BasicNameIdObjectEntity(
                  name: state.patient.name,
                  id: state.patient.id,
                )));
              }
            },
          ),
          BlocListener<LabRequestsBloc, LabRequestsBloc_States>(
            listener: (context, state) {
              if (state is LabRequestsBloc_CreatedCustomerSuccessfullyState) {
                dialogHelper.dismissAll(context);
                ShowSnackBar(context, isSuccess: true, title: "Success", message: "Customer Added!");
              } else if (state is LabRequestsBloc_ChangedPatientState) {
                if (!widget.fixDismiss) dialogHelper.dismissAll(context);
              }
              if (state is LabRequestsBloc_CreatingLabRequestState)
                CustomLoader.show(context);
              else
                CustomLoader.hide();
              if (state is LabRequestsBloc_CreatingLabRequestErrorState)
                ShowSnackBar(context, isSuccess: false, message: state.message);
              else if (state is LabRequestsBloc_CreatedLabRequestSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true, message: "Created Request Successfully");
                dialogHelper.dismissAll(context);
                if(!widget.isDoctor)
                  Navigator.of(context).pop(true);

              }
            },
          ),
          BlocListener<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
            listener: (context, state) {
              if (state is LoadedPatientInfoState) {
                labRequest.patient = BasicNameIdObjectEntity(name: state.patient!.name, id: state.patient!.id);
                labRequest.patientId = state.patient!.id;
                bloc.emit(LabRequestsBloc_ChangedPatientState(patient: BasicNameIdObjectEntity(name: state.patient!.name, id: state.patient!.id)));
              }
            },
          )
        ],
        child: Column(
          children: [
            TitleWidget(
              title: "Create New Request",
              showBackButton: true,
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: ListView(
                  children: [
                    FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                  buildWhen: (previous, current) =>
                                      current is LabRequestsBloc_CreatedCustomerSuccessfullyState || current is LabRequestsBloc_ChangedCustomerState,
                                  builder: (context, state) {
                                    if (state is LabRequestsBloc_CreatedCustomerSuccessfullyState) {
                                      labRequest.customer = state.newCustomer;
                                      labRequest.customerId = state.newCustomer!.idInt;
                                    } else if (state is LabRequestsBloc_ChangedCustomerState) {
                                      labRequest.customer = state.customer;
                                      labRequest.customerId = state.customer!.idInt;
                                    }
                                    return CIA_TextFormField(
                                      label: "Doctor",
                                      enabled: false,
                                      controller: TextEditingController(text: labRequest.customer!.name ?? ""),
                                      onTap: widget.isDoctor
                                          ? null
                                          : () {
                                              {
                                                EnumLabRequestSources selectedSource = EnumLabRequestSources.CIA;
                                                String search = "";
                                                _PatientDoctorsSearchDataSource dataSource = _PatientDoctorsSearchDataSource(type: _SearchDataType.Doctors);
                                                usersBloc.add(UsersBloc_SearchUsersByWorkPlaceEvent(
                                                    params: SearchUsersByWorkPlaceParams(
                                                  search: search,
                                                  source: selectedSource,
                                                )));
                                                CIA_ShowPopUp(
                                                  width: 900,
                                                  height: 600,
                                                  context: context,
                                                  onSave: () => setState(() {}),
                                                  child: StatefulBuilder(builder: (context, setState) {
                                                    return Column(
                                                      children: [
                                                        CIA_PrimaryButton(
                                                          label: "Add New Customer",
                                                          onTab: () {
                                                            UserEntity newCustomer = UserEntity();
                                                            bool newWorkPlace = false;
                                                            CIA_ShowPopUp(
                                                              context: context,
                                                              title: "Add new customer",
                                                              onSave: () {
                                                                newCustomer.workPlaceEnum = EnumLabRequestSources.OutSource;
                                                                bloc.add(LabRequestsBloc_CreateLabCustomerEvent(customer: newCustomer));
                                                                return false;
                                                              },
                                                              child: StatefulBuilder(builder: (context, setState) {
                                                                return Column(
                                                                  children: [
                                                                    CIA_TextFormField(
                                                                      label: "Name",
                                                                      controller: TextEditingController(text: newCustomer.name ?? ""),
                                                                      onChange: (v) => newCustomer.name = v,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    CIA_TextFormField(
                                                                      label: "Phone Number 1",
                                                                      isNumber: true,
                                                                      controller: TextEditingController(text: newCustomer.phoneNumber ?? ""),
                                                                      onChange: (v) => newCustomer.phoneNumber = v,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    CIA_TextFormField(
                                                                      label: "Phone Number 2",
                                                                      isNumber: true,
                                                                      controller: TextEditingController(text: newCustomer.phoneNumber2 ?? ""),
                                                                      onChange: (v) => newCustomer.phoneNumber2 = v,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: CIA_MultiSelectChipWidget(
                                                                              onChange: (item, isSelected) {
                                                                                newWorkPlace = isSelected;
                                                                                setState(() {});
                                                                              },
                                                                              labels: [CIA_MultiSelectChipWidgeModel(label: "New Work Place")]),
                                                                        ),
                                                                        Expanded(
                                                                          flex: 2,
                                                                          child: newWorkPlace
                                                                              ? CIA_TextFormField(
                                                                                  label: "New Work Place Name",
                                                                                  controller: TextEditingController(
                                                                                      text: newCustomer.workPlace == null
                                                                                          ? ""
                                                                                          : newCustomer.workPlace!.name ?? ""),
                                                                                  onChange: (v) {
                                                                                    newCustomer.workPlace = BasicNameIdObjectEntity(name: v);
                                                                                    newCustomer.workPlaceId = null;
                                                                                  },
                                                                                )
                                                                              : CIA_DropDownSearchBasicIdName(
                                                                                  asyncUseCase: sl<LoadWorkPlacesCase>(),
                                                                                  onSelect: (value) {
                                                                                    newCustomer.workPlace = value;
                                                                                    newCustomer.workPlaceId = value.id;
                                                                                  },
                                                                                ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                                                      builder: (context, state) {
                                                                        String error = "";
                                                                        if (state is LabRequestsBloc_CreatingCustomerErrorState) error = state.message;
                                                                        return Text(
                                                                          error,
                                                                          style: TextStyle(color: Colors.red),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              }),
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_MultiSelectChipWidget(
                                                          key: GlobalKey(),
                                                          singleSelect: true,
                                                          onChange: (item, isSelected) {
                                                            if (item == "CIA Doctors")
                                                              selectedSource = EnumLabRequestSources.CIA;
                                                            else if (item == "Clinic Doctors")
                                                              selectedSource = EnumLabRequestSources.Clinic;
                                                            else if (item == "Outsource Doctors") selectedSource = EnumLabRequestSources.OutSource;
                                                            usersBloc.add(UsersBloc_SearchUsersByWorkPlaceEvent(
                                                                params: SearchUsersByWorkPlaceParams(search: search, source: selectedSource)));
                                                          },
                                                          labels: [
                                                            CIA_MultiSelectChipWidgeModel(
                                                                label: "CIA Doctors", isSelected: selectedSource == EnumLabRequestSources.CIA),
                                                            CIA_MultiSelectChipWidgeModel(
                                                                label: "Clinic Doctors", isSelected: selectedSource == EnumLabRequestSources.Clinic),
                                                            CIA_MultiSelectChipWidgeModel(
                                                                label: "Outsource Doctors", isSelected: selectedSource == EnumLabRequestSources.OutSource),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CIA_TextFormField(
                                                          label: "Search",
                                                          controller: TextEditingController(text: search),
                                                          onChange: (v) {
                                                            search = v;
                                                            usersBloc.add(UsersBloc_SearchUsersByWorkPlaceEvent(
                                                                params: SearchUsersByWorkPlaceParams(source: selectedSource, search: search)));
                                                          },
                                                        ),
                                                        SizedBox(height: 10),
                                                        BlocBuilder<UsersBloc, UsersBloc_States>(
                                                          buildWhen: (previous, current) =>
                                                              current is UsersBloc_LoadedMultiUsersSuccessfullyState ||
                                                              current is UsersBloc_LoadingUserErrorState,
                                                          builder: (context, state) {
                                                            if (state is UsersBloc_LoadedMultiUsersSuccessfullyState)
                                                              dataSource.updateData(state.usersData
                                                                  .map((e) => _dummyClass(
                                                                        id: e.idInt,
                                                                        name: e.name,
                                                                        phoneNumber: e.phoneNumber,
                                                                      ))
                                                                  .toList());
                                                            else if (state is UsersBloc_LoadingUserState)
                                                              return LoadingWidget();
                                                            else if (state is UsersBloc_LoadingUserErrorState)
                                                              return BigErrorPageWidget(message: state.message);
                                                            return TableWidget(
                                                              dataSource: dataSource,
                                                              onCellClick: (index) async {
                                                                var p = dataSource.models.firstWhere((element) => element.id == index);
                                                                labRequest.customer!.name = p.name;
                                                                labRequest.customer!.idInt = p.id;
                                                                labRequest.customerId = p.id;
                                                                dialogHelper.dismissSingle(context);
                                                                bloc.emit(LabRequestsBloc_ChangedCustomerState(
                                                                    customer: UserEntity(
                                                                  name: p.name,
                                                                  idInt: p.id,
                                                                  workPlaceEnum: selectedSource,
                                                                  phoneNumber: p.phoneNumber,
                                                                )));
                                                                // globalSetState(() {});
                                                              },
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                );
                                              }
                                            },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                  buildWhen: (previous, current) => current is LabRequestsBloc_ChangedDeliveryDateState,
                                  builder: (context, state) {
                                    return CIA_TextFormField(
                                        onTap: () {
                                          CIA_PopupDialog_DateOnlyPicker(context, "Delivery Date", (value) {
                                            labRequest.deliveryDate = value;
                                            bloc.emit(LabRequestsBloc_ChangedDeliveryDateState(date: value));
                                          });
                                        },
                                        label: "Delivery Date",
                                        controller: TextEditingController(
                                            text: labRequest.deliveryDate == null
                                                ? ""
                                                : DateFormat("dd-MM-yyyy").format(
                                                    labRequest.deliveryDate!,
                                                  )));
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                  buildWhen: (previous, current) =>
                                      current is LabRequestsBloc_CreatedCustomerSuccessfullyState || current is LabRequestsBloc_ChangedCustomerState,
                                  builder: (context, state) {
                                    if (state is LabRequestsBloc_CreatedCustomerSuccessfullyState) {
                                      labRequest.customer = state.newCustomer;
                                      labRequest.customerId = state.newCustomer!.idInt;
                                    } else if (state is LabRequestsBloc_ChangedCustomerState) {
                                      labRequest.customer = state.customer;
                                      labRequest.customerId = state.customer!.idInt;
                                    }
                                    return CIA_TextFormField(
                                      label: "Phone",
                                      controller: TextEditingController(text: labRequest.customer!.phoneNumber ?? ""),
                                      onChange: (v) => labRequest.customer!.phoneNumber = v,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CIA_DropDownSearchBasicIdName(
                                  asyncUseCase: sl<GetDefaultStepsUseCase>(),
                                  label: "Next Step",
                                  selectedItem: labRequest.steps![1].step,
                                  onSelect: (value) {
                                    labRequest.steps![1].step = value;
                                    labRequest.steps![1].stepId = value.id;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                  builder: (context, state) {
                                    if (state is LabRequestsBloc_ChangedPatientState) {
                                      labRequest.patient = state.patient;
                                      labRequest.patientId = state.patient.id;
                                    }
                                    return CIA_TextFormField(
                                      label: "Patient",
                                      enabled: false,
                                      controller: TextEditingController(text: labRequest.patient!.name ?? ""),
                                      onTap: widget.isDoctor
                                          ? null
                                          : () {
                                              {
                                                EnumLabRequestSources selectedSource = EnumLabRequestSources.CIA;
                                                String? search;
                                                _PatientDoctorsSearchDataSource dataSource = _PatientDoctorsSearchDataSource(type: _SearchDataType.Patients);
                                                bloc.add(LabRequestsBloc_SearchLabPatientsByTypeEvent(
                                                    params: SearchLabPatientsByTypeParams(
                                                  search: search,
                                                  type: selectedSource,
                                                )));
                                                CIA_ShowPopUp(
                                                  width: 900,
                                                  height: 600,
                                                  context: context,
                                                  child: Column(
                                                    children: [
                                                      CIA_PrimaryButton(
                                                        label: "Create New Patient",
                                                        onTab: () {
                                                          PatientInfoEntity newPatient = PatientInfoEntity();
                                                          CIA_ShowPopUp(
                                                            width: 600,
                                                            height: 800,
                                                            hideButton: true,
                                                            context: context,
                                                            onSave: () {},
                                                            child: CreateOrViewPatientPage(
                                                              patientID: 0,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(height: 10),
                                                      CIA_MultiSelectChipWidget(
                                                        key: GlobalKey(),
                                                        singleSelect: true,
                                                        onChange: (item, isSelected) {
                                                          if (item == "CIA Patients")
                                                            selectedSource = EnumLabRequestSources.CIA;
                                                          else if (item == "Clinic Patients")
                                                            selectedSource = EnumLabRequestSources.Clinic;
                                                          else if (item == "Outsource Patients") selectedSource = EnumLabRequestSources.OutSource;
                                                          bloc.add(LabRequestsBloc_SearchLabPatientsByTypeEvent(
                                                              params: SearchLabPatientsByTypeParams(
                                                            search: search,
                                                            type: selectedSource,
                                                          )));
                                                        },
                                                        labels: [
                                                          CIA_MultiSelectChipWidgeModel(
                                                              label: "CIA Patients", isSelected: selectedSource == EnumLabRequestSources.CIA),
                                                          CIA_MultiSelectChipWidgeModel(
                                                              label: "Clinic Patients", isSelected: selectedSource == EnumLabRequestSources.Clinic),
                                                          CIA_MultiSelectChipWidgeModel(
                                                              label: "Outsource Patients", isSelected: selectedSource == EnumLabRequestSources.OutSource),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Search",
                                                        controller: TextEditingController(text: search),
                                                        onChange: (v) => bloc.add(LabRequestsBloc_SearchLabPatientsByTypeEvent(
                                                            params: SearchLabPatientsByTypeParams(
                                                          search: v,
                                                          type: selectedSource,
                                                        ))),
                                                      ),
                                                      SizedBox(height: 10),
                                                      BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                                        buildWhen: (previous, current) =>
                                                            current is LabRequestsBloc_LoadedPatientsState ||
                                                            current is LabRequestsBloc_SearchingPatientsErrorState,
                                                        builder: (context, state) {
                                                          if (state is LabRequestsBloc_LoadedPatientsState)
                                                            dataSource.updateData(state.patients
                                                                .map((e) => _dummyClass(
                                                                      id: e.id,
                                                                      name: e.name,
                                                                      phoneNumber: e.phone,
                                                                    ))
                                                                .toList());
                                                          else if (state is LabRequestsBloc_SearchingPatientsErrorState)
                                                            return BigErrorPageWidget(message: state.message);
                                                          return TableWidget(
                                                            dataSource: dataSource,
                                                            onCellClick: (index) {
                                                              var p = dataSource.models.firstWhere((element) => element.id == index);
                                                              labRequest.patient!.name = p.name;
                                                              labRequest.patient!.id = p.id;
                                                              labRequest.patientId = p.id;
                                                              bloc.emit(LabRequestsBloc_ChangedPatientState(
                                                                  patient: BasicNameIdObjectEntity(
                                                                name: p.name,
                                                                id: p.id,
                                                              )));
                                                              //context.goNamed(LabTodaysRequestsSearch.routeName);
                                                            },
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CIA_TextFormField(
                                  label: "Notes",
                                  controller: TextEditingController(text: labRequest.notes ?? ""),
                                  onChange: (v) => labRequest.notes = v,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CIA_MultiSelectChipWidget(
                                  key: GlobalKey(),
                                  singleSelect: true,
                                  onChange: (item, isSelected) {
                                    if (isSelected) {
                                      labRequest.steps![0] = LabStepEntity(step: BasicNameIdObjectEntity(name: item));

                                      if (item == "Scan") {
                                        labRequest.initStatus = EnumLabRequestInitStatus.Scan;
                                        labRequest.steps![1] = LabStepEntity(step: BasicNameIdObjectEntity(name: "Waiting lab approval"));
                                      } else if (item == "Physical") {
                                        labRequest.initStatus = EnumLabRequestInitStatus.Physical;
                                        labRequest.steps![1] = LabStepEntity(step: BasicNameIdObjectEntity(name: "Cast"));
                                      } else if (item == "Cast") {
                                        labRequest.initStatus = EnumLabRequestInitStatus.Cast;
                                        labRequest.steps![1] = LabStepEntity(step: BasicNameIdObjectEntity(name: "Design"));
                                      } else if (item == "Remake") {
                                        labRequest.initStatus = EnumLabRequestInitStatus.Remake;
                                        labRequest.steps![1] = LabStepEntity(step: BasicNameIdObjectEntity(name: ""));
                                      }
                                      setState(() {});
                                    }
                                  },
                                  labels: [
                                    CIA_MultiSelectChipWidgeModel(label: "Scan", isSelected: labRequest.initStatus == EnumLabRequestInitStatus.Scan),
                                    CIA_MultiSelectChipWidgeModel(label: "Physical", isSelected: labRequest.initStatus == EnumLabRequestInitStatus.Physical),
                                    CIA_MultiSelectChipWidgeModel(label: "Cast", isSelected: labRequest.initStatus == EnumLabRequestInitStatus.Cast),
                                    CIA_MultiSelectChipWidgeModel(label: "Remake", isSelected: labRequest.initStatus == EnumLabRequestInitStatus.Remake),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: BlocBuilder<LabRequestsBloc, LabRequestsBloc_States>(
                                  buildWhen: (previous, current) => current is LabRequestsBloc_ChangedCustomerState,
                                  builder: (context, state) {
                                    if (state is LabRequestsBloc_ChangedCustomerState) {
                                      labRequest.customer = state.customer;
                                    }
                                    return FormTextKeyWidget(
                                      text: () {
                                        if (labRequest.customer != null && labRequest.customer!.workPlaceEnum != null)
                                          return EnumLabRequestSources.values[labRequest.customer!.workPlaceEnum!.index!].toString().split(".").last +
                                              " Customer";
                                        else
                                          return "";
                                      }(),
                                      secondaryInfo: true,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormTextKeyWidget(text: "Details"),
                          SizedBox(
                            height: 10,
                          ),
                          CIA_TeethChart(
                            onChange: (selectedTeethList) {
                              labRequest.teeth = selectedTeethList;
                            },
                            selectedTeeth: labRequest.teeth ?? [],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.waxUp,
                                      name: "Wax Up",
                                      onChange: (data) => labRequest.waxUp = data,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.printedPMMA,
                                      name: "Printed PMMA",
                                      onChange: (data) => labRequest.printedPMMA = data,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.zirconUnit,
                                      name: "Zircon Unit",
                                      onChange: (data) => labRequest.zirconUnit = data,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.tiAbutment,
                                      name: "Ti Abutment",
                                      onChange: (data) => labRequest.tiAbutment = data,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.pfm,
                                      name: "PFM",
                                      onChange: (data) => labRequest.pfm = data,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.tiBar,
                                      name: "Ti Bar",
                                      onChange: (data) => labRequest.tiBar = data,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.compositeInlay,
                                      name: "Composite Inlay",
                                      onChange: (data) => labRequest.compositeInlay = data,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.threeDPrinting,
                                      name: "3D Printing",
                                      onChange: (data) => labRequest.threeDPrinting = data,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.emaxVeneer,
                                      name: "Emax Veneer",
                                      onChange: (data) => labRequest.emaxVeneer = data,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: LabRequestItemWidget(
                                      item: labRequest.milledPMMA,
                                      name: "Milled PMMA",
                                      onChange: (data) => labRequest.milledPMMA = data,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),


                          SizedBox(height: 10),
                          Row(
                            children: [
                              FormTextKeyWidget(
                                text: "Date of Entry",
                                secondaryInfo: true,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FormTextValueWidget(
                                text: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()).toString(),
                                secondaryInfo: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              FormTextKeyWidget(
                                text: "Entry by",
                                secondaryInfo: true,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FormTextValueWidget(
                                text: siteController.getUserName() ?? "",
                                secondaryInfo: true,
                              ),
                            ],
                          ),
                          Center(
                            child: CIA_PrimaryButton(
                              label: "Finish",
                              onTab: () {
                                bloc.add(LabRequestsBloc_CreateLabRequestEvent(request: labRequest));
                                /*var step = await LAB_RequestsAPI.GetDefaultStepByName(labRequest.steps![0].step!.name!);
                                if (step.statusCode == 200) labRequest.steps![0] = LabStepEntity(stepId: (step.result as BasicNameIdObjectEntity).id);
                                if (labRequest.steps![1].stepId == null) {
                                  step = await LAB_RequestsAPI.GetDefaultStepByName(labRequest.steps![1].step!.name!);
                                  if (step.statusCode == 200) labRequest.steps![1] = LabStepEntity(stepId: (step.result as BasicNameIdObjectEntity).id);
                                }
                                var res = await LAB_RequestsAPI.AddRequest(labRequest);
                                if (res.statusCode == 200) {
                                  ShowSnackBar(context, isSuccess: true, title: "Success", message: "Request Added!");
                                  //  if (!widget.isDoctor)
                                  dialogHelper.dismissSingle(context);
                                  dialogHelper.dismissSingle(context);

                                  // internalPagesController.goBack();
                                } else {
                                  ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                                }*/
                              },
                              isLong: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

enum _SearchDataType { Patients, Doctors, Technicians }

class _dummyClass {
  int? id;
  String? name;
  String? phoneNumber;

  _dummyClass({this.id, this.name, this.phoneNumber});

  _dummyClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    phoneNumber = json['phone'] ?? json['phoneNumber'];
  }
}

class _PatientDoctorsSearchDataSource extends DataGridSource {
  List<_dummyClass> models = <_dummyClass>[];
  var columns = ["ID", "Name", "Phone"];

  _SearchDataType type;

  /// Creates the patient data source class with required details.
  _PatientDoctorsSearchDataSource({required this.type}) {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Phone', value: e.phoneNumber ?? ""),
            ]))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  updateData(List<_dummyClass> newData) async {
    models = newData;
    init();
    notifyListeners();
    return true;
  }
}
