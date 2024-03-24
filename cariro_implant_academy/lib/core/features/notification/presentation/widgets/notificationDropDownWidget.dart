import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notificationEntity.dart';

class NotificationDropDownWidget extends StatefulWidget {
  NotificationDropDownWidget({
    Key? key,
    this.hint,
    this.customButton,
    this.childrenString,
    this.notifications,
    required this.markAsRead,
  }) : super(key: key);

  String? hint;
  Widget? customButton;
  List<String>? childrenString;
  List<NotificationEntity>? notifications;

  Function(int? id) markAsRead;

  @override
  State<NotificationDropDownWidget> createState() => _NotificationDropDownWidgetState();
}

class _NotificationDropDownWidgetState extends State<NotificationDropDownWidget> {
  String? selectedValue;
  NotificationEntity? selectedValueNot;
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<NotificationEntity>(
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
        items: (widget.notifications as List<NotificationEntity>)
            .map((item) => DropdownMenuItem<NotificationEntity>(
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
                                color: ((item.read ?? false)) ? Colors.black : Colors.red,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              item.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(item.date!),
                              style: TextStyle(
                                fontSize: 14,
                                color: ((item.read ?? false)) ? Colors.black : Colors.red,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
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
        onChanged: (value) async {
          if (value != null && value.onClickAction != null && value.infoId != null) {
            value.onClickAction!(context);
            widget.markAsRead(value.id);
          }
        },
        onMenuStateChange: (isOpen) async {
          //siteController.newNotification.value = false;
        },
        
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color_Background,
          ),
          maxHeight: 400,
          width: 800,
          offset: const Offset(-180, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(height: 70),
        /*  icon: widget.hint != null
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

        itemPadding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        dropdownMaxHeight: 300,
        dropdownWidth: 400,
        dropdownPadding: null,


        scrollbarAlwaysShow: true,,*/
      ),
    );
  }
}
