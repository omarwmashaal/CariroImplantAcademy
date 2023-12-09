import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Widgets/CIA_TextFormField.dart';

class TimePickerTextField extends StatefulWidget {
  TimePickerTextField({
    Key? key,
    required this.initialTime,
    required this.onChanged,
    this.label,
  }) : super(key: key);
  DateTime initialTime;
  String? label;
  Function(DateTime newTime) onChanged;

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return CIA_TextFormField(
        onTap: () async {
          var time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(widget.initialTime!) );
          if (time != null) {
            widget.onChanged(
                DateTime(
                  widget.initialTime.year,
                  widget.initialTime!.month,
                  widget.initialTime!.day,
                  time!.hour,
                  time!.minute,
                )
            );
          }
          setState(() {});
        },
        enabled: false,
        label: widget.label??"Time",
        controller: TextEditingController(text: DateFormat("hh:mm a").format(widget.initialTime)));
  }
}
