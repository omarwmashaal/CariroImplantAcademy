import 'package:chips_input/chips_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Colors.dart';
import '../Controllers/PatientMedicalController.dart';
import 'FormTextWidget.dart';

class CIA_TagsInputWidget extends StatefulWidget {
  CIA_TagsInputWidget(
      {Key? key,
      required this.label,
      this.initialValue,
      this.strikeValues,
      this.onDelete,
      this.onChange = null,
      required this.patientController})
      : super(key: key);
  String label;
  Function(List<String>)? onChange;
  Function(String)? onDelete;
  List<String>? initialValue;
  List<String>? strikeValues;
  PatientMedicalController patientController;

  @override
  State<CIA_TagsInputWidget> createState() => _CIA_TagsInputWidgetState();
}

class _CIA_TagsInputWidgetState extends State<CIA_TagsInputWidget> {
  FocusNode focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<String> _data = <String>[];

  @override
  void initState() {
    widget.initialValue=widget.initialValue??[];
    if (widget.strikeValues != null) {
      for (int i = 0; i < widget.strikeValues!.length; i++) {
        widget.strikeValues![i] = "strike" + widget.strikeValues![i];
      }

      if (widget.initialValue != null)
        widget.initialValue?.addAll(widget.strikeValues!);
    }


  }

  @override
  Widget build(BuildContext context) {

     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         FormTextKeyWidget(text: widget.label),
         Container(
           padding: EdgeInsets.all(8),
           decoration: BoxDecoration(
               border: Border.fromBorderSide(
                 BorderSide(
                     color: Color_TextFieldBorder, width: 0.0),
               ),
               borderRadius: BorderRadius.all(Radius.circular(8))
           ),
           child: Row(
             children: widget.initialValue!.map((e) =>
                 Chip(
               labelPadding: const EdgeInsets.only(left: 8.0),
               label: Text(
                 e.replaceAll("strike", ""),
                 style: TextStyle(
                     decoration: e.contains("strike")
                         ? TextDecoration.lineThrough
                         : null,
                     color: e.contains("strike") ? Colors.red : Colors.black),
               ),
               deleteIcon: Icon(
                 Icons.close,
                 size: 10,
               ),
               onDeleted: () {
                 if (widget.onDelete != null) widget.onDelete!(e);
               },
             )).toList(),
           ),
         ),
       ],
     );
  }
  buildChips()
  {

  }
}
