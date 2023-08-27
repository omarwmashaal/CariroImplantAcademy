import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc_States.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc.dart';
import 'package:cariro_implant_academy/presentation/patientsMedical/bloc/medicalPagesStatesChangesBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Constants/Colors.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../core/presentation/widgets/LoadingWidget.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_Events.dart';
import '../../../../../presentation/widgets/bigErrorPageWidget.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc.dart';
import '../../../../../presentation/patientsMedical/bloc/medicalInfoShellBloc_States.dart';

class DentalHistoryPage extends StatefulWidget {
  DentalHistoryPage({Key? key, required this.patientId}) : super(key: key);
  static String routeName = "DentalHistory";
  static String routePath = "Patients/:id/DentalHistory";
  int patientId;

  @override
  State<DentalHistoryPage> createState() => _PatientDentalHistoryState();
}

class _PatientDentalHistoryState extends State<DentalHistoryPage> {
  //Color clench = Color_TextFieldBorder;
  //String tobacco = "0";
  // late Future<API_Response> load;

  late DentalHistoryBloc bloc;
  late MedicalInfoShellBloc medicalShellBloc;
  late MedicalPagesStatesChangesBloc medicalVariablesBloc;
  late DentalHistoryEntity dentalHistoryData;
  bool edit = false;

  @override
  void initState() {
    bloc = BlocProvider.of<DentalHistoryBloc>(context);
    medicalShellBloc = context.read<MedicalInfoShellBloc>();
    medicalVariablesBloc = context.read<MedicalPagesStatesChangesBloc>();
    //load = MedicalAPI.GetPatientDentalHistory(widget.patientId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    medicalShellBloc.add(MedicalInfoShell_ChangeTitleEvent(title: "Dental History"));
    bloc.add(DentalHistoryBloc_GetDentalHistoryEvent(patientId: widget.patientId));
    return BlocConsumer<DentalHistoryBloc, DentalHistoryBloc_States>(
      listener: (context, state) {},
      buildWhen: (previous, current) =>
          current is DentalHistoryBloc_LoadingDataState || current is DentalHistoryBloc_DataLoadedSuccessfullyState || current is DentalHistoryBloc_ErrorState,
      builder: (context, state) {
        if (state is DentalHistoryBloc_LoadingDataState)
          return LoadingWidget();
        else if (state is DentalHistoryBloc_DataLoadedSuccessfullyState) {
          dentalHistoryData = state.dentalHistoryEntity;
          bloc.isInitialized = true;
          return ListView(
            shrinkWrap: false,
            children: [
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: BlocBuilder<MedicalInfoShellBloc, MedicalInfoShellBloc_State>(
                  bloc: medicalShellBloc,
                  buildWhen: (previous, current) => current is MedicalInfoBlocChangeViewEditState,
                  builder: (context, stateShell) {
                    return AbsorbPointer(
                      absorbing: () {
                        if (stateShell is MedicalInfoBlocChangeViewEditState) {
                          edit = stateShell.edit;
                          return !edit;
                        } else {
                          edit = false;
                          return true;
                        }
                      }(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(child: FormTextKeyWidget(text: "Are your teeth sensitive to ?")),
                              Expanded(
                                  flex: 2,
                                  child: CIA_MultiSelectChipWidget(
                                      onChange: (value, isSelected) {
                                        if (value.toString() == "Hot or cold")
                                          dentalHistoryData.senstiveHotCold = isSelected;
                                        else if (value.toString() == "sweets")
                                          dentalHistoryData.senstiveSweets = isSelected;
                                        else if (value.toString() == "Biting or chewing") dentalHistoryData.bittingCheweing = isSelected;
                                      },
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "Hot or cold", isSelected: dentalHistoryData.senstiveHotCold ?? false),
                                        CIA_MultiSelectChipWidgeModel(label: "sweets", isSelected: dentalHistoryData.senstiveSweets ?? false),
                                        CIA_MultiSelectChipWidgeModel(label: "Biting or chewing", isSelected: dentalHistoryData.bittingCheweing ?? false),
                                      ]))
                            ],
                          ),
                          SizedBox(height: 10,),
                          CIA_TextFormField(
                              borderColor: Color_TextFieldBorder,
                              borderColorOnChange: Colors.orange,
                              changeColorIfFilled: true,
                              onChange: (value) {
                                dentalHistoryData.clench = value;
                              },
                              label: "Do you clench or grind your teeth while awake or sleep?",
                              controller: TextEditingController(text: dentalHistoryData.clench)),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                  child: FormTextKeyWidget(
                                text: "Smoke Tobacco?",
                              )),
                              Expanded(
                                  child: CIA_TextFormField(
                                      onChange: (value) {
                                        dentalHistoryData.smoke = int.parse(value);
                                        medicalVariablesBloc.changeSmokingStatus(numberOfCigarettes: dentalHistoryData.smoke ?? 0);
                                      },
                                      errorFunction: (value) {
                                        return int.parse(value) >= 20;
                                      },
                                      label: "Cigarette per day",
                                      isNumber: true,
                                      controller: TextEditingController(text: dentalHistoryData.smoke == null ? null : dentalHistoryData.smoke.toString()))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: BlocBuilder<MedicalPagesStatesChangesBloc, MedicalPagesStatesChangesBloc_States>(
                                buildWhen: (previous, current) => current is ChangeSmokingStatusState,
                                bloc: medicalVariablesBloc,
                                builder: (context, state) {
                                  SmokingStatus status = dentalHistoryData.smokingStatus ?? SmokingStatus.NoneSmoker;
                                  if (state is ChangeSmokingStatusState) status = state.smokingStatus;
                                  return FormTextValueWidget(text: status.name);
                                },
                              )),
                              Expanded(flex: 3, child: SizedBox())
                            ],
                          ),
                          SizedBox(height: 10,),
                          CIA_TextFormField(
                              onChange: (value) => dentalHistoryData.seriousInjury = value,
                              label: "A serious injury to the mouth?",
                              controller: TextEditingController(text: dentalHistoryData.seriousInjury)),
                          SizedBox(height: 10,),
                          CIA_TextFormField(
                              onChange: (value) => dentalHistoryData.satisfied = value,
                              label: "Are you satisfied with your teeth's appearance?",
                              controller: TextEditingController(text: dentalHistoryData.satisfied)),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(child: FormTextKeyWidget(text: "Patient Cooperation Score")),
                              Expanded(
                                  child: CIA_TextFormField(
                                      isNumber: true,
                                      errorFunction: (v) => int.parse(v) <= 5,
                                      validator: (value) {
                                        if (int.parse(value) > 10) return "10";
                                        return value;
                                      },
                                      onChange: (value) => dentalHistoryData.cooperationScore = int.parse(value),
                                      label: "",
                                      controller: TextEditingController(
                                          text: dentalHistoryData.cooperationScore != null ? dentalHistoryData.cooperationScore.toString() : null))),
                              Expanded(child: FormTextKeyWidget(text: "/10")),
                              Expanded(child: SizedBox())
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(child: FormTextKeyWidget(text: "Patient willing for implant score")),
                              Expanded(
                                  child: CIA_TextFormField(
                                      validator: (value) {
                                        if (int.parse(value) > 10) return "10";
                                        return value;
                                      },
                                      errorFunction: (v) => int.parse(v) <= 5,
                                      onChange: (value) => dentalHistoryData.willingForImplantScore = int.parse(value),
                                      label: "",
                                      isNumber: true,
                                      controller: TextEditingController(
                                          text:
                                              dentalHistoryData.willingForImplantScore != null ? dentalHistoryData.willingForImplantScore.toString() : null))),
                              Expanded(child: FormTextKeyWidget(text: "/10")),
                              Expanded(child: SizedBox())
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is DentalHistoryBloc_ErrorState)
          return BigErrorPageWidget(message: state.message);
        else
          return BigErrorPageWidget(message: "Couldn't retrieve data");
      },
    );
  }

  @override
  void dispose() {
    if (edit && bloc.isInitialized) {
      bloc.add(DentalHistoryBloc_SaveDentalHistoryEvent(dentalHistoryEntity: dentalHistoryData!));
    }
    super.dispose();
  }
}
