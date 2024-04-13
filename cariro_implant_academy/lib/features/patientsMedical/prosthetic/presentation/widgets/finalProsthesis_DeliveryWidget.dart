import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../../../labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';
import '../../domain/entities/prostheticFinalEntity.dart';
import '../../domain/enums/enum.dart';

class FinalProsthesis_DeliveryWidget extends StatefulWidget {
  FinalProsthesis_DeliveryWidget({
    Key? key,
    required this.data,
    required this.onDelete,
    required this.index,
    this.fullArch = false,
  }) : super(key: key);
  bool fullArch;
  FinalProthesisDeliveryEntity data;
  Function() onDelete;
  int index;

  @override
  State<FinalProsthesis_DeliveryWidget> createState() => _FinalProsthesis_DeliveryWidgetState();
}

class _FinalProsthesis_DeliveryWidgetState extends State<FinalProsthesis_DeliveryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              FormTextKeyWidget(text: "${widget.index}. Delivery"),
              FormTextValueWidget(
                text: " || Teeth: ",
              ),
              FormTextValueWidget(
                text: widget.fullArch ? "Full Arch" : widget.data.finalProthesisTeeth?.toString(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: CIA_DropDownSearch(
                        label: "Status",
                        selectedItem: () {
                          if (widget.data!.finalProthesisDeliveryStatus != null) {
                            return DropDownDTO(name: widget.data!.finalProthesisDeliveryStatus!.name.replaceAll("_", " "));
                          }
                          return null;
                        }(),
                        onSelect: (value) {
                          widget.data!.finalProthesisDeliveryStatus = EnumFinalProthesisDeliveryStatus.values[value.id!];
                        },
                        items: [
                          DropDownDTO(name: "Done", id: 0),
                          DropDownDTO(name: "ReDesign", id: 1),
                          DropDownDTO(name: "ReImpression", id: 2),
                          DropDownDTO(name: "ReTryIn", id: 3),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CIA_DropDownSearch(
                        label: "Next Visit",
                        selectedItem: () {
                          if (widget.data.finalProthesisDeliveryNextVisit != null) {
                            return DropDownDTO(name: widget.data!.finalProthesisDeliveryNextVisit!.name.replaceAll("_", " "));
                          }
                          return null;
                        }(),
                        onSelect: (value) {
                          widget.data!.finalProthesisDeliveryNextVisit = EnumFinalProthesisDeliveryNextVisit.values[value.id!];
                        },
                        items: [
                          DropDownDTO(name: "Done", id: 0),
                          DropDownDTO(name: "ReDesign", id: 1),
                          DropDownDTO(name: "ReImpression", id: 2),
                          DropDownDTO(name: "ReTryIn", id: 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    FormTextKeyWidget(text: "Date"),
                    SizedBox(width: 10),
                    Expanded(
                        child: CIA_GestureWidget(
                      onTap: () {
                        CIA_PopupDialog_DateOnlyPicker(context, "Change Date and Time", initialDate: widget.data.date, (v) {
                          setState(() {
                            widget.data.date = v;
                          });
                        });
                      },
                      child: FormTextValueWidget(
                        text: widget.data.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(widget.data.date!),
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child:CIA_GestureWidget(
                        onTap: () => CIA_ShowPopUp(
                          context: context,
                        height: 100,
                        onSave: () => setState(() => null),
                          child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                            asyncUseCase: sl<LoadUsersUseCase>(),
                            searchParams: LoadUsersEnum.instructorsAndAssistants,
                            onSelect: (value) {
                              widget.data.operatorId = value.id;
                            widget.data.operator = value;
                            },
                            //selectedItem: DropDownDTO(),
                            selectedItem:   widget.data.operator ?? BasicNameIdObjectEntity(name: "", id: 0),
                            label: "Operator",
                          ),
                        ),
                          child: FormTextValueWidget(
                                                text: widget.data.operator?.name,
                                              ),
                        )),
                    SizedBox(width: 10),
                    IconButton(onPressed: () => widget.onDelete(), icon: Icon(Icons.delete)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
