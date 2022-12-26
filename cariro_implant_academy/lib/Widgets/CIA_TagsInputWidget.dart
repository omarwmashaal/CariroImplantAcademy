import 'package:chips_input/chips_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

List<String> Teeth = [
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49"
];

class CIA_TagsInputWidget extends StatefulWidget {
  CIA_TagsInputWidget({Key? key, required this.label}) : super(key: key);
  String label;

  @override
  State<CIA_TagsInputWidget> createState() => _CIA_TagsInputWidgetState();
}

class _CIA_TagsInputWidgetState extends State<CIA_TagsInputWidget> {
  FocusNode focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  bool _error = false;

  @override
  void initState() {
    focus.addListener(() {
      if ((!focus.hasFocus)) {
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
      controller: _controller,
      focusNode: focus,
      autocorrect: true,
      showCursor: true,
      cursorColor: Color_AccentGreen,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: _error ? Colors.red : Color_TextFieldBorder, width: 0.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color_AccentGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelStyle: TextStyle(
            color: focus.hasFocus ? Color_AccentGreen : Color(0xff000000),
            fontWeight: FontWeight.bold),
        filled: true,
        labelText: widget.label,
        fillColor: Color_Background,
        isDense: true,
      ),
      findSuggestions: (String query) {
        if (query.isNotEmpty) {
          var lowercaseQuery = query.toLowerCase();
          final results = Teeth.where((searchValue) {
            return searchValue.toLowerCase().contains(query.toLowerCase());
          }).toList(growable: false)
            ..sort((a, b) => a
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
          return results;
        }
        return Teeth;
      },
      onChanged: (data) {
        print(data);
      },
      onEditingComplete: () {
        print(_controller.text);
      },
      chipBuilder: (context, state, String teeth) {
        return InputChip(
          key: ObjectKey(teeth),
          label: Text(teeth),
          onDeleted: () => state.deleteChip(teeth),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      suggestionBuilder: (context, String teeth) {
        return ListTile(
          key: ObjectKey(teeth),
          title: Text(teeth),
        );
      },
      //...
    );
  }
}
