import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/complainBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/createOrViewPatientPage.dart';
import 'package:cariro_implant_academy/features/patient/presentation/pages/patientProfileComplainsPage.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';



import '../../../../Constants/Controllers.dart';
import '../../../../Helpers/Router.dart';
import '../../../../Widgets/CIA_TextField.dart';
import '../../../../Widgets/Horizontal_RadioButtons.dart';
import '../../../../Widgets/Title.dart';
import '../../../../core/constants/enums/enums.dart';

class ComplainsSearchPage extends StatefulWidget {
  const ComplainsSearchPage({Key? key}) : super(key: key);
  static String routePath = "PatientsComplains";

  static String getRouteName({Website? site}) {
    Website website = site ?? siteController.getSite();
    switch (website) {
      case Website.Clinic:
        return "ClinicPatientsComplains";
      default:
        return "PatientsComplains";
    }
  }

  @override
  State<ComplainsSearchPage> createState() => _PatientsComplainsPageState();
}

class _PatientsComplainsPageState extends State<ComplainsSearchPage> {
  ComplainsDataGridSource datasource = ComplainsDataGridSource();
  EnumComplainStatus? status;
  String? complainSearch;
  late ComplainsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ComplainsBloc>(context);
    bloc.add(ComplainsBloc_GetComplainsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplainsBloc, ComplainsBloc_States>(
      listener: (context, state) {
        if (state is ComplainsBloc_LoadingDataSuccessState) datasource.updateData(newData: state.complains);
        if (state is ComplainsBloc_LoadingDataState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
      },
      child: Column(
        children: [
          TitleWidget(
            title: "Complains",
            showBackButton: false,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: CIA_TextField(
                            label: "Search",
                            icon: Icons.search,
                            onChange: (value) {
                              complainSearch = value;
                              bloc.add(ComplainsBloc_GetComplainsEvent(search: value, status: status));
                            },
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: HorizontalRadioButtons(
                                  groupValue: "All",
                                  names: ["All", "Untouched", "In Queue", "Resolved"],
                                  onChange: (value) {
                                    if (value == "untouched")
                                      status = EnumComplainStatus.Untouched;
                                    else if (value == "in queue")
                                      status = EnumComplainStatus.InQueue;
                                    else if (value == "resolved")
                                      status = EnumComplainStatus.Resolved;
                                    else
                                      status = null;

                                    bloc.add(ComplainsBloc_GetComplainsEvent(search: complainSearch, status: status));
                                  },
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
                  flex: 5,
                  child: BlocBuilder<ComplainsBloc, ComplainsBloc_States>(
                    buildWhen: (previous, current) => current is ComplainsBloc_LoadingDataErrorState || current is ComplainsBloc_LoadingDataSuccessState,
                    builder: (context, state) {
                      if (state is ComplainsBloc_LoadingDataErrorState) return BigErrorPageWidget(message: state.message);
                      return TableWidget(
                        dataSource: datasource,
                        onCellClick: (value) {
                          context.goNamed(PatientProfileComplainsPage.getRouteName(),
                              pathParameters: {"id": datasource.models.firstWhere((element) => element.secondaryId == value).patientID.toString()});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
