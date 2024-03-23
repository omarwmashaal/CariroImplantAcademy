import 'package:cariro_implant_academy/Models/MedicalModels/MedicalExaminationModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../features/patientsMedical/medicalExamination/domain/entities/hba1cEntity.dart';

class CIA_IncrementalHBA1CTextField extends StatefulWidget {
  CIA_IncrementalHBA1CTextField({Key? key, required this.model, this.onChange}) : super(key: key);

  List<HbA1cEntity> model;
  Function(List<HbA1cEntity>)? onChange;

  @override
  State<CIA_IncrementalHBA1CTextField> createState() => _CIA_IncrementalHBA1CTextFieldState();
}

class _CIA_IncrementalHBA1CTextFieldState extends State<CIA_IncrementalHBA1CTextField> {
  List<HbA1cEntity> items = [];

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
    for (HbA1cEntity item in items) {
      returnValue.add(const SizedBox(height: 10));
      returnValue.add(Row(
        key: GlobalKey(),
        children: [
          Expanded(child: Text(index.toString())),
          Expanded(
              flex: 2,
              child: CIA_TextFormField(
                errorFunction: (value) {
                  return double.parse(value) >= 6;
                  
                },
                isNumber: true,
                onChange: (value) {
                  item.reading = double.parse(value);
                  if (widget.onChange != null) {
                    widget.onChange!(items);
                  }
                },
                label: "Reading",
                controller: TextEditingController(text: item.reading.toString() ?? "0"),
              )),
          const SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: CIA_DateTimeTextFormField(
                onChange: (value) {
                  item.date = value;
                  if (widget.onChange != null) {
                    widget.onChange!(items);
                  }
                },
                label: "Date",
                controller: TextEditingController(text: item.date == null ? "" : DateFormat("dd-MM-yyyy").format(item.date!)),
              )),
          Expanded(
              child: items.last == item
                  ? IconButton(
                      onPressed: () {
                        if (widget.onChange != null) {
                          widget.onChange!(items);
                        }
                        setState(() {
                          items.add(HbA1cEntity(reading: 0));
                        });
                      },
                      icon: Icon(Icons.add))
                  : const SizedBox()),
          Expanded(
              child: items.length == 1
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        if (widget.onChange != null) {
                          widget.onChange!(items);
                        }
                        setState(() {
                          items.remove(item);
                        });
                      },
                      icon: Icon(Icons.delete))),
          const Expanded(child: SizedBox())
        ],
      ));
      index++;
    }

    return returnValue;
  }

  @override
  void initState() {
    items = widget.model;
    if (items == null || items.length == 0) items.add(HbA1cEntity(reading: 0, date: null));
  }
}
