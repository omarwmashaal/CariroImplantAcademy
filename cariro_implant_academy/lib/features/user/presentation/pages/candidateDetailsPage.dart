import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/canidateDetailsEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/getCandidateDetailsUseCase.dart';
import 'package:cariro_implant_academy/features/user/presentation/bloc/usersBloc_Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../core/presentation/widgets/LoadingWidget.dart';
import '../../../../presentation/widgets/bigErrorPageWidget.dart';
import '../../../patientsMedical/treatmentFeature/presentation/pages/surgicalTreatmentPage.dart';
import '../bloc/usersBloc.dart';
import '../bloc/usersBloc_States.dart';

class ViewCandidateData extends StatefulWidget {
  ViewCandidateData({Key? key, required this.userId}) : super(key: key);
  int userId;
  static String routeName = "CandidateDetails";
  static String routeNameClinic = "ClinicCandidateDetails";
  static String routePath = "Candidate/:id/CandidateDetails";

  @override
  State<ViewCandidateData> createState() => _ViewCandidateDataState();
}

class _ViewCandidateDataState extends State<ViewCandidateData> {
  bool edit = false;
  late CandidateDetailsEntity user;
  FocusNode next = FocusNode();
  DateTime? from;
  DateTime? to;
  late UsersBloc bloc;
  CandidateDetailsDataSource dataSource = CandidateDetailsDataSource();
  int total = 0;

  @override
  void initState() {
    bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(UsersBloc_GetCandidateDetailsEvent(
        params: GetCandidateDetailsParams(
      id: widget.userId,
    )));
    super.initState();
  }

  reload() {
    bloc.add(UsersBloc_GetCandidateDetailsEvent(
        params: GetCandidateDetailsParams(
      id: widget.userId,
      from: from,
      to: to,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersBloc_States>(
      buildWhen: (previous, current) =>
          current is UsersBloc_LoadingCandidateDetailsState ||
          current is UsersBloc_LoadingCandidateDetailsErrorState ||
          current is UsersBloc_LoadedCandidateDetailsSuccessfullyState,
      builder: (context, state) {
        if (state is UsersBloc_LoadingCandidateDetailsState)
          return LoadingWidget();
        else if (state is UsersBloc_LoadingCandidateDetailsErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is UsersBloc_LoadedCandidateDetailsSuccessfullyState) {
          var candidateDetails = state.data;
          dataSource.loadData(candidateDetails);
          total = 0;
          candidateDetails.forEach((element) {
            total += element.implantCount ?? 0;
          });
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SizedBox()),
                  Expanded(
                      child: CIA_TextFormField(
                    label: "From",
                    enabled: false,
                    onTap: (){
                      CIA_PopupDialog_DateOnlyPicker(context, "Pick Date", (value) {
                        from = value;
                        reload();
                      });
                    },
                    controller: TextEditingController(text: from==null?"":DateFormat("dd-MM-yyyy").format(from!)),

                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: CIA_DateTimeTextFormField(
                        label: "To",
                        enabled: false,
                        onTap: (){
                          CIA_PopupDialog_DateOnlyPicker(context, "Pick Date", (value) {
                            to = value;
                            reload();
                          });
                        },
                        controller: TextEditingController(text: to==null?"":DateFormat("dd-MM-yyyy").format(to!)),

                      )),
                  Expanded(child: SizedBox()),
                ],
              ),
              Expanded(
                child: TableWidget(
                  dataSource: dataSource,
                  allowSorting: true,
                  onCellClick: (index) {
                    context.goNamed(SurgicalTreatmentPage.getRouteName(), pathParameters: {'id': dataSource.models.firstWhere((element) => element.patientId==index).patient!.id!.toString()});
                  },
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Total Implants: $total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
