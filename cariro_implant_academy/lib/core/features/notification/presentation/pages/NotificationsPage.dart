import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_States.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Widgets/Title.dart';
import '../../domain/entities/notificationEntity.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  static String routeName = "Notifications";
   static String routeNameClinic = "ClinicNotifications";
  static String routePath = "Notifications";

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  EnumNotificationType? notificationType;

  List<NotificationEntity> notifications = [];
  late AppBarBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AppBarBloc>(context);
    bloc.add(AppBarGetNotificationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBarBloc, AppBarBlocState>(
      listener: (context, state) {
        if (state is AppBarDeletingNotificationsErrorState)
          ShowSnackBar(context, isSuccess: false, message: state.message);
        else if (state is AppBarDeletedNotificationsSuccessfullyState) bloc.add(AppBarGetNotificationsEvent());
        if (state is AppBarDeletingNotificationsState)
          CustomLoader.show(context);
        else
          CustomLoader.hide();
      },
      builder: (context, state) {
        if (state is AppBarLoadingNotificationsState)
          return LoadingWidget();
        else if (state is AppBarLoadingNotificationsErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is AppBarNotificationsLoadedState) notifications = state.notifications;
        notifications = notificationType == null ? notifications : notifications.where((element) => element.type == notificationType).toList();
        return Column(
          children: [
            TitleWidget(title: "Notifications"),
            SizedBox(height: 10),
            CIA_MultiSelectChipWidget(
              key: GlobalKey(),
              singleSelect: true,
              labels: () {
                var r = [CIA_MultiSelectChipWidgeModel(label: "All", isSelected: notificationType == null)];
                r.addAll(EnumNotificationType.values.map((e) => CIA_MultiSelectChipWidgeModel(label: e.name, isSelected: notificationType == e)).toList());
                return r;
              }(),
              onChange: (item, isSelected) {
                if (isSelected) {
                  if (item == "All")
                    notificationType = null;
                  else {
                    notificationType = EnumNotificationType.values.firstWhere((element) => element.name == item);
                  }
                  bloc.add(AppBarGetNotificationsEvent());
                }
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: notifications
                    .map((item) => GestureDetector(
                          onTap: () {
                            if (item.onClickAction != null && item.infoId != null) item.onClickAction!(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item.id.toString() + "- ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ((item.read ?? false)) ? Colors.black : Colors.red,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.title as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ((item.read ?? false)) ? Colors.black : Colors.red,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      item.date as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ((item.read ?? false)) ? Colors.black : Colors.red,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    IconButton(
                                        onPressed: () => bloc.add(AppBarDeleteNotificationEvent(id: item.id!)), icon: Icon(Icons.remove, color: Colors.red))
                                  ],
                                ),
                                Text(
                                  item.content as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ((item.read ?? false)) ? Colors.black : Colors.red,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
