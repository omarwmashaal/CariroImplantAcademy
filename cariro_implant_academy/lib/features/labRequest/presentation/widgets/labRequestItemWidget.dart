import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/CIA_TextFormField.dart';

class LabRequestItemWidget extends StatefulWidget {
  LabRequestItemWidget({
    Key? key,
    required this.item,
    required this.onChange,
    required this.onDelete,
    this.free = false,
    this.viewOnly = false,
    this.showConsume = false,
  }) : super(key: key);
  LabStepItemEntity item;
  bool viewOnly;
  bool showConsume;
  bool free;
  Function(LabStepItemEntity data) onChange;
  Function() onDelete;

  @override
  State<LabRequestItemWidget> createState() => _LabRequestItemWidgetState();
}

class _LabRequestItemWidgetState extends State<LabRequestItemWidget> {
  @override
  Widget build(BuildContext context) {
     if (widget.item != null) widget.item!.labPrice = widget.free ? 0 : widget.item!.labPrice ?? widget.item?.labOption?.price ?? 0;

    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTextKeyWidget(text: widget.item.labOption?.name ?? ""),
            SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                    onPressed: () => widget.onDelete(),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                SizedBox(width: 10),
                Expanded(
                  child: CIA_TextFormField(
                    label: "Description",
                    controller: TextEditingController(text: widget.item.description),
                    onChange: (v) {
                      widget.item!.description = v;
                      widget.onChange(widget.item!);
                    },
                  ),
                ),
                SizedBox(width: 10),
                FormTextValueWidget(
                  text: "Tooth: ${widget.item.tooth == 0 ? "All" : widget.item.tooth}",
                ),
                // Expanded(
                //   child: CIA_TextFormField(
                //     label: "Number",
                //     controller: TextEditingController(text: widget.item?.number?.toString()),
                //     isNumber: true,
                //     onChange: (v) {
                //       if (widget.item == null) widget.item = OmarEntity();
                //       widget.item!.number = int.tryParse(v);
                //       widget.item!.totalPrice = widget.item!.price! * widget.item!.number!;
                //       widget.onChange(widget.item!);
                //       setState(() {});
                //     },
                //   ),
                // ),
                SizedBox(width: 10),
                Visibility(
                  visible: widget.viewOnly,
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              FormTextKeyWidget(text: "Price: "),
                              FormTextValueWidget(text: widget.item?.labPrice?.toString()),
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
    );
  }
}
