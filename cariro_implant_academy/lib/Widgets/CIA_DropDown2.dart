import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Models/NotificationModel.dart';

class CIA_NotificationsWidget extends StatefulWidget {
  CIA_NotificationsWidget({
    Key? key,
    this.hint,
    this.customButton,
    this.childrenString,
    this.notifications,
  }) : super(key: key);

  String? hint;
  Widget? customButton;
  List<String>? childrenString;
  List<NotificationModel>? notifications;

  @override
  State<CIA_NotificationsWidget> createState() => _CIA_NotificationsWidgetState();
}

class _CIA_NotificationsWidgetState extends State<CIA_NotificationsWidget> {
  String? selectedValue;
  NotificationModel? selectedValueNot;
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<NotificationModel>(
        isExpanded: true,
        customButton: widget.customButton,
        hint: widget.hint != null
            ? Row(
                children: [
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      widget.hint as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : null,
        items:(widget.notifications as List<NotificationModel>)
                .map((item) => DropdownMenuItem<NotificationModel>(
                      value: item,
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
                                  item.title as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ((item.read ??false))? Colors.black : Colors.red,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(child: SizedBox()),

                                Text(
                                  item.date as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ((item.read ??false))? Colors.black : Colors.red,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Text(
                              item.content as String,
                              style:  TextStyle(
                                fontSize: 14,
                                color: ((item.read ??false))? Colors.black : Colors.red,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ))
                .toList(),
        onChanged: (value) async {
          if(value!=null && value.onClickAction!=null && value.infoId!=null)
            {
              context.goNamed(value.onClickAction!(),pathParameters: {'id':value.infoId!.toString()});
            }

        },
        icon: widget.hint != null
            ? const Icon(
                Icons.arrow_forward_ios_outlined,
              )
            : null,
        iconSize: 14,
        // iconEnabledColor: Colors.yellow,
        //iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: 0,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Colors.transparent,
        ),
        buttonElevation: 2,
        itemHeight: 70,
        onMenuStateChange: (isOpen)  async{
          siteController.newNotification.value = false;
          await NotificationsAPI.MarkAllAsRead();
          if(!isOpen)
            await NotificationsAPI.GetNotifications();
        },
        itemPadding: const EdgeInsets.only(left: 5, right: 5,bottom: 5),
        dropdownMaxHeight: 300,
        dropdownWidth: 400,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color_Background,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),

      ),
    );
  }
}
