import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/NotificationModel.dart';

class CIA_DropDown2 extends StatefulWidget {
  CIA_DropDown2({
    Key? key,
    this.hint,
    this.iconButton,
    this.childrenString,
    this.notifications,
  }) : super(key: key);

  String? hint;
  Icon? iconButton;
  List<String>? childrenString;
  List<NotificationModel>? notifications;

  @override
  State<CIA_DropDown2> createState() => _CIA_DropDown2State();
}

class _CIA_DropDown2State extends State<CIA_DropDown2> {
  String? selectedValue;
  NotificationModel? selectedValueNot;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        customButton: widget.iconButton,
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
        items: widget.childrenString != null
            ? (widget.childrenString as List<String>)
                .map((item) => DropdownMenuItem<String>(
                      value: item as String,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList()
            : (widget.notifications as List<NotificationModel>)
                .map((item) => DropdownMenuItem<NotificationModel>(
                      value: item,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.content as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                        ],
                      ),
                    ))
                .toList(),
        value: widget.childrenString != null ? selectedValue : selectedValueNot,
        onChanged: (value) {
          setState(() {
            if (widget.childrenString != null)
              selectedValue = value as String;
            else
              selectedValueNot = value as NotificationModel;
          });
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
        itemHeight: 60,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
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
