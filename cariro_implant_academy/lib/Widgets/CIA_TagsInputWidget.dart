import 'package:chips_input/chips_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Colors.dart';
import '../Controllers/PatientMedicalController.dart';
import 'FormTextWidget.dart';

class CIA_TagsInputWidget extends StatefulWidget {
  CIA_TagsInputWidget({
    Key? key,
    required this.label,
    this.initialValue,
    this.strikeValues,
    this.onDelete,
    this.disableBorder = false,
    this.isSmall = false,
    this.onChange = null,
    this.dynamicVisibility = false,
  }) : super(key: key);
  String label;
  Function(List<String>)? onChange;
  Function(String)? onDelete;
  List<String>? initialValue;
  List<String>? strikeValues;
  bool dynamicVisibility;
  bool disableBorder;
  bool isSmall;

  @override
  State<CIA_TagsInputWidget> createState() => _CIA_TagsInputWidgetState();
}

class _CIA_TagsInputWidgetState extends State<CIA_TagsInputWidget> {
  FocusNode focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<String> _data = <String>[];

  @override
  void initState() {
    widget.initialValue = widget.initialValue ?? [];
    if (widget.strikeValues != null) {
      for (int i = 0; i < widget.strikeValues!.length; i++) {
        widget.strikeValues![i] = "strike" + widget.strikeValues![i];
      }

      if (widget.initialValue != null) widget.initialValue?.addAll(widget.strikeValues!);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool show = widget.dynamicVisibility ? widget.initialValue!.isNotEmpty : true;
    return show
        ? Row(
          
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextKeyWidget(text: widget.label,smallFont: widget.isSmall),
                    Container(
                      decoration: widget.disableBorder?null: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(color: Color_TextFieldBorder, width: 0.0),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Wrap(
                        children: widget.initialValue!
                            .map((e) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Chip(
                                    labelPadding: const EdgeInsets.only(left: 2.0),
                                    label: Text(
                                      e.replaceAll("strike", ""),
                                      style: TextStyle(
                                        fontSize: widget.isSmall?10:null,
                                          decoration: e.contains("strike") ? TextDecoration.lineThrough : null,
                                          color: e.contains("strike") ? Colors.red : Colors.black),
                                    ),
                                    deleteIcon: Icon(
                                      Icons.close,
                                      size: 10,
                                    ),
                                    onDeleted: () {
                                      if (widget.initialValue != null) {
                                        widget.initialValue!.remove(e);
                                        setState(() {

                                        });
                                      }
                                      if (widget.onDelete != null) widget.onDelete!(e);
                                    },
                                  ),
                            ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        )
        : SizedBox(
            height: 1,
          );
  }

  buildChips() {}
}
