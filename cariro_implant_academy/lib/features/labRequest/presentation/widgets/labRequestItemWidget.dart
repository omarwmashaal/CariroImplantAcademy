import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/OmarEntity.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Widgets/CIA_TextFormField.dart';

class LabRequestItemWidget extends StatefulWidget {
  LabRequestItemWidget({
    Key? key,
    required this.item,
    required this.name,
    required this.onChange,
    this.free = false,
    this.viewOnly = false,
    this.showConsume = false,
  }) : super(key: key);
  OmarEntity? item;
  String name;
  bool viewOnly;
  bool showConsume;
  bool free;
  Function(OmarEntity data) onChange;

  @override
  State<LabRequestItemWidget> createState() => _LabRequestItemWidgetState();
}

class _LabRequestItemWidgetState extends State<LabRequestItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.item != null) widget.item!.totalPrice = widget.free ? 0 : widget.item!.number! * widget.item!.price!;
    return SizedBox(
      width: 300,
      child: Visibility(
        visible: !(widget.viewOnly && (widget.item?.isNull() ?? true)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
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
                        if (widget.item == null) widget.item = OmarEntity();
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
                        if (widget.item == null) widget.item = OmarEntity();
                        widget.item!.number = int.tryParse(v);
                        widget.item!.totalPrice = widget.item!.price! * widget.item!.number!;
                        widget.onChange(widget.item!);
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Visibility(
                    visible: widget.viewOnly,
                    child: Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                FormTextKeyWidget(text: "Unit Price: "),
                                FormTextValueWidget(text: widget.item?.price?.toString()),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              children: [
                                FormTextKeyWidget(text: "Total Price: "),
                                FormTextValueWidget(text: widget.item?.totalPrice?.toString()),
                                FormTextValueWidget(text: widget.free ? " Free request" : ""),
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
