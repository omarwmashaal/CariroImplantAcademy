import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../presentation/widgets/bigErrorPageWidget.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../presentation/widgets/LoadingWidget.dart';
import '../bloc/settingsBloc.dart';
import '../bloc/settingsBloc_Events.dart';
import '../bloc/settingsBloc_States.dart';

enum SettingsType{
  expansionCard,
  textField
}
class SettingsWidget extends StatefulWidget {
  SettingsWidget({
    Key? key,
    required this.loadedSuccessfullyState,
    required this.loadingErrorState,
    required this.loadingState,
    required this.loadEvent,
    required this.title,
    required this.settingsType,
  }) : super(key: key);
  SettingsBloc_States loadingState;
  SettingsBlocLoadedSuccessfullyState loadedSuccessfullyState;
  SettingsBlocErrorState loadingErrorState;
  SettingsBloc_Events loadEvent;
  String title;
  SettingsType settingsType;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late SettingsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsBloc_States>(
      builder: (context, state) {
        List<BasicNameIdObjectEntity> data = [];
        if(state is SettingsBlocLoadedSuccessfullyState)
          data = state.data;
        return ExpansionTileCard(
          onExpansionChanged: (value) {
            if (value) {
              bloc.add(widget.loadEvent);
            }
          },
          title: Text(widget.title),
          children: state is SettingsBlocLoadedSuccessfullyState
              ? [
                  LoadingWidget(),
                ]
              : state is SettingsBlocErrorState
                  ? [
                      BigErrorPageWidget(message: state.message),
                    ]
                  : data
                      .map((e) => ExpansionTileCard(
                          onExpansionChanged: (value) {
                            if (value) bloc.add(SettingsBloc_LoadImplantLinesEvent(companyId: e.id!));
                          },
                          title: Text(
                            e.name ?? "",
                          )))
                      .toList(),
        );
      },
    );
  }
}
