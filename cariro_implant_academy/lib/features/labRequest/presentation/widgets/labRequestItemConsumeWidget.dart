import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestItemEntity.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Widgets/CIA_TextFormField.dart';

class LabRequestItemConsumeWidget extends StatefulWidget {
  LabRequestItemConsumeWidget({
    Key? key,
    required this.item,
    required this.name,
    required this.onChange,
    this.viewOnly = false,
    this.showConsume = false,
  }) : super(key: key);
  LabRequestItemEntity? item;
  String name;
  bool viewOnly;
  bool showConsume;
  Function(LabRequestItemEntity data) onChange;

  @override
  State<LabRequestItemConsumeWidget> createState() => _LabRequestItemConsumeWidgetState();
}

class _LabRequestItemConsumeWidgetState extends State<LabRequestItemConsumeWidget> {
  @override
  Widget build(BuildContext context) {
    widget.item!.totalPrice = widget.item!.number!*widget.item!.price!;
    return SizedBox(
      width: 300,
      child: Visibility(
        visible: !(widget.viewOnly && (widget.item?.isNull() ?? true)),
        child: Padding(
          padding: const EdgeInsets.only(bottom:20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTextKeyWidget(text: widget.name),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: CIA_TextFormField(
                            label: "Description",
                            controller: TextEditingController(text: widget.item?.description),
                            onChange: (v) {
                              if (widget.item == null) widget.item = LabRequestItemEntity();
                              widget.item!.description = v;
                              widget.onChange(widget.item!);
                            },
                          ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CIA_TextFormField(
                            label: "Number",
                            controller: TextEditingController(text: widget.item?.number?.toString()),
                            isNumber: true,
                            onChange: (v) {
                              if (widget.item == null) widget.item = LabRequestItemEntity();
                              widget.item!.number = int.tryParse(v);
                              widget.item!.totalPrice = widget.item!.price! * widget.item!.number!;
                              widget.onChange(widget.item!);
                              setState(() {

                              });
                            },
                          ),
                  ),
                  SizedBox(width: 10),
                  Visibility(
                    visible: widget.viewOnly,
                    child: Expanded(
                      child:

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                FormTextKeyWidget(text: "Unit Price: "),
                                FormTextValueWidget(text: widget.item?.price?.toString()),
                              ],
                            ),
                          ),
                          SizedBox(width:10),
                          Expanded(
                            child: Row(
                              children: [
                                FormTextKeyWidget(text: "Total Price: "),
                                FormTextValueWidget(text: widget.item?.totalPrice?.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
