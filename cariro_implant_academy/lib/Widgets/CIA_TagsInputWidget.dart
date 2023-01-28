import 'package:chips_input/chips_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/Colors.dart';
import '../Controllers/PatientMedicalController.dart';

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
  bool _error = false;
  List<String> _data = <String>[];

  @override
  void initState() {
    if (widget.strikeValues != null) {
      for (int i = 0; i < widget.strikeValues!.length; i++) {
        widget.strikeValues![i] = "strike" + widget.strikeValues![i];
      }

      if (widget.initialValue != null)
        widget.initialValue?.addAll(widget.strikeValues!);
    }

    focus.addListener(() {
      if ((!focus.hasFocus)) {
        if (widget.onChange != null) {
          for (String ss in _data) {
            try {
              widget.patientController.removeTooth(ss);
            } catch (e) {}
          }
          widget.onChange!(_data);
        }

        if (_controller.value.text.contains("0") ||
            _controller.value.text.contains("1") ||
            _controller.value.text.contains("2") ||
            _controller.value.text.contains("3") ||
            _controller.value.text.contains("4") ||
            _controller.value.text.contains("5") ||
            _controller.value.text.contains("6") ||
            _controller.value.text.contains("7") ||
            _controller.value.text.contains("8") ||
            _controller.value.text.contains("9")) {
          setState(() {
            _error = true;
          });
        } else {
          setState(() {
            _error = false;
          });
        }
      } else {
        setState(() {
          _error = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChipsInput(
      readOnly: true,
      initialValue: widget.initialValue as List<String>,
      controller: _controller,
      focusNode: focus,
      autocorrect: true,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      showCursor: true,

      cursorColor: Color_Accent,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: _error ? Colors.red : Color_TextFieldBorder, width: 0.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color_Accent),
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelStyle: TextStyle(
            color: focus.hasFocus ? Color_Accent : Color(0xff000000),
            fontWeight: FontWeight.bold),
        filled: true,
        labelText: widget.label,
        fillColor: Color_Background,
        isDense: true,
      ),
      findSuggestions: (String query) {
        if (query.isNotEmpty) {
          var lowercaseQuery = query.toLowerCase();
          final results = widget.patientController
              .getSuggestionTeeth()
              .where((searchValue) {
            return searchValue.toLowerCase().contains(query.toLowerCase());
          }).toList(growable: false)
            ..sort((a, b) => a
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
          return results;
        }
        return widget.patientController.getSuggestionTeeth();
      },
      onChanged: (data) {
        _data = data as List<String>;
      },
      onEditingComplete: () {
        print(_controller.text);
      },
      chipBuilder: (context, state, String teeth) {
        return InputChip(
          key: ObjectKey(teeth),
          label: Text(
            teeth.replaceAll("strike", ""),
            style: TextStyle(
                decoration: teeth.contains("strike")
                    ? TextDecoration.lineThrough
                    : null,
                color: teeth.contains("strike") ? Colors.red : Colors.black),
          ),
          onDeleted: () {
            focus.requestFocus();
            widget.patientController.addTooth(teeth);
            state.deleteChip(teeth);
            if (widget.onDelete != null) widget.onDelete!(teeth);
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      suggestionBuilder: (context, String teeth) {
        return Container();
        if (!widget.patientController.getSuggestionTeeth().contains(teeth))
          return Container();
        return ListTile(
          key: ObjectKey(teeth),
          title: Text(teeth),
        );
      },
      //...
    );
  }
}
