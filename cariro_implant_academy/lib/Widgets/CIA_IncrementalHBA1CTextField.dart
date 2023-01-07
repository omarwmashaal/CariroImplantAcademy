import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/HBA1C_Model.dart';

class CIA_IncrementalHBA1CTextField extends StatefulWidget {
  CIA_IncrementalHBA1CTextField({Key? key}) : super(key: key);

  @override
  State<CIA_IncrementalHBA1CTextField> createState() =>
      _CIA_IncrementalHBA1CTextFieldState();
}

class _CIA_IncrementalHBA1CTextFieldState
    extends State<CIA_IncrementalHBA1CTextField> {
  List<HBA1C_Model> items = [];
  @override
  Widget build(BuildContext context) {
    List<Widget> children = _buildColumn();
    return Column(
      children: children,
    );
  }

  List<Widget> _buildColumn() {
    List<Widget> returnValue = [];
    int index = 1;
    for (HBA1C_Model item in items) {
      returnValue.add(SizedBox(height: 10));
      returnValue.add(Row(
        key: GlobalKey(),
        children: [
          Expanded(child: Text(index.toString())),
          Expanded(
              flex: 2,
              child: new CIA_TextFormField(
                onChange: (value) => item.reading = value,
                label: "Reading",
                controller: new TextEditingController(text: item.reading),
              )),
          SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: new CIA_TextFormField(
                onChange: (value) => item.date = value,
                label: "Date",
                controller: new TextEditingController(text: item.date),
              )),
          Expanded(
              child: items.last == item
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          items.add(HBA1C_Model(date: "", reading: ""));
                        });
                      },
                      icon: Icon(Icons.add))
                  : SizedBox()),
          Expanded(
              child: items.length == 1
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          items.remove(item);
                        });
                      },
                      icon: Icon(Icons.delete))),
          Expanded(child: SizedBox())
        ],
      ));
      index++;
    }

    return returnValue;
  }

  @override
  void initState() {
    items.add(HBA1C_Model(reading: "", date: ""));
  }
}
