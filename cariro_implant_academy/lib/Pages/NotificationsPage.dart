import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/API/UserAPI.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/Enum.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Models/NotificationModel.dart';
import '../Widgets/Title.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  static String routeName = "Notifications";
  static String routePath = "Notifications";

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  EnumNotificationType? notificationType;

  late List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return CIA_FutureBuilder(
      loadFunction: NotificationsAPI.GetNotifications(),
      onSuccess: (date) {
        notifications = siteController.notifications.value;
        NotificationsAPI.MarkAllAsRead();
        if (notificationType != null) {
          notifications.removeWhere((element) => element.type != notificationType!);
        }
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
                  if(item=="All") notificationType = null;
                  else{
                    notificationType = EnumNotificationType.values.firstWhere((element) => element.name==item);
                  }
                  setState(() {

                  });
                }
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: (notifications as List<NotificationModel>)
                    .map((item) => GestureDetector(
                  onTap: () {
                    if (item.onClickAction != null) context.goNamed(item.onClickAction!(), pathParameters: {'id': (item.infoId ?? "").toString()});
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
                              item.id.toString()+"- ",
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
                            IconButton(onPressed: ()async{
                              var res = await NotificationsAPI.DeleteNotification(item.id!);
                              ShowSnackBar(context, isSuccess: res.statusCode==200);
                              setState(() {

                              });
                            }, icon: Icon(Icons.remove,color:Colors.red))
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
