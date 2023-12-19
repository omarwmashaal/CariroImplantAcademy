import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestItemEntity.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Widgets/CIA_TextFormField.dart';

class LabRequestItemWidget extends StatelessWidget {
  LabRequestItemWidget({
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
  Widget build(BuildContext context) {
    viewOnly = false;
    return SizedBox(
      width: 300,
      child: Visibility(
        visible: !(viewOnly && (item?.isNull() ?? true)),
        child: Padding(
          padding: const EdgeInsets.only(bottom:20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTextKeyWidget(text: name),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: viewOnly
                        ? FormTextValueWidget(text: item?.description)
                        : CIA_TextFormField(
                            label: "Description",
                            controller: TextEditingController(text: item?.description),
                            onChange: (v) {
                              if (item == null) item = LabRequestItemEntity();
                              item!.description = v;
                              onChange(item!);
                            },
                          ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: viewOnly
                        ? FormTextValueWidget(text: item?.number?.toString())
                        : CIA_TextFormField(
                            label: "Number",
                            controller: TextEditingController(text: item?.number?.toString()),
                            isNumber: true,
                            onChange: (v) {
                              if (item == null) item = LabRequestItemEntity();
                              item!.number = int.tryParse(v);
                              onChange(item!);
                            },
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
