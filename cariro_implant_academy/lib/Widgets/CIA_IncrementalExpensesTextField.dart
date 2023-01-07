import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/StockModel.dart';

class CIA_IncrementalExpensesTextField extends StatefulWidget {
  CIA_IncrementalExpensesTextField({Key? key, required this.label})
      : super(key: key);

  String label;
  @override
  State<CIA_IncrementalExpensesTextField> createState() =>
      _CIA_IncrementalExpensesTextFieldState();
}

class _CIA_IncrementalExpensesTextFieldState
    extends State<CIA_IncrementalExpensesTextField> {
  List<StockModel> items = [];
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
    for (StockModel item in items) {
      returnValue.add(SizedBox(height: 10));
      returnValue.add(Row(
        key: GlobalKey(),
        children: [
          Expanded(child: Text(index.toString())),
          Expanded(
              flex: 2,
              child: new CIA_TextFormField(
                onChange: (value) => item.Name = value,
                label: "Item",
                controller: new TextEditingController(text: item.Name),
              )),
          SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: new CIA_TextFormField(
                onChange: (value) => item.Price = value,
                label: "Price",
                controller: new TextEditingController(text: item.Price),
              )),
          Expanded(
              child: items.last == item
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          items.add(StockModel(Name: "", Price: ""));
                        });
                      },
                      icon: Icon(Icons.add))
                  : SizedBox()),
          Expanded(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      items.remove(item);
                    });
                  },
                  icon: Icon(Icons.delete))),
        ],
      ));
      index++;
    }

    returnValue.add(SizedBox(height: 10));
    returnValue.add(Row(
      children: [
        Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: Center(
              child: FormTextValueWidget(
                text: "Total Price",
              ),
            )),
        Expanded(
            flex: 2,
            child: Center(
              child: FormTextKeyWidget(
                text: "980 EGP",
              ),
            )),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: SizedBox(),
        )
      ],
    ));
    return returnValue;
  }

  @override
  void initState() {
    items.add(StockModel(Name: "", Price: ""));
  }
}
