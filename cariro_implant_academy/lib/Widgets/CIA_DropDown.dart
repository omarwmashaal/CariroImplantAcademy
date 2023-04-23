import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';
import '../Models/DTOs/DropDownDTO.dart';

class CIA_DropDown extends StatefulWidget {
  CIA_DropDown(
      {Key? key,
      this.onSelect,
      required this.label,
      this.selectedValue,
      required this.values})
      : super(key: key);

  String label;
  List<String> values;
  Function? onSelect;
  String? selectedValue;

  @override
  State<CIA_DropDown> createState() => _CIA_DropDownState();
}

class _CIA_DropDownState extends State<CIA_DropDown> {
  FocusNode focus = FocusNode();

  @override
  void initState() {
    focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextDropdownFormField(
      controller: DropdownEditingController(
          value: widget.selectedValue == null ? "" : widget.selectedValue),
      onChanged: (dynamic value) {
        if (widget.onSelect != null) {
          widget.onSelect!(value);
        }
      },
      options: widget.values,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down),
        suffixIconColor: focus.hasFocus ? Color_Accent : Color_TextFieldBorder,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
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
      dropdownHeight: 120,
    );
  }
}

class CIA_DropDownSearch extends StatefulWidget {
  CIA_DropDownSearch({Key? key, this.items, this.asyncItems,this.label, this.selectedItem, this.enabled=true, this.emptyString="No results found", this.onSelect}) : super(key: key);
  List<DropDownDTO>? items;
  Future<API_Response> Function()? asyncItems;
  String? label;
  DropDownDTO? selectedItem;
  bool enabled;
  String emptyString;
  Function(DropDownDTO)? onSelect;

  @override
  State<CIA_DropDownSearch> createState() => _CIA_DropDownSearchState();
}

class _CIA_DropDownSearchState extends State<CIA_DropDownSearch> {
  @override
  Widget build(BuildContext context) {

    return DropdownSearch<DropDownDTO>(
      enabled: widget.enabled,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        emptyBuilder: (context, searchEntry) {
          return Text(widget.emptyString);
        },

      ),
      selectedItem: widget.selectedItem,
      asyncItems: (c)async{
        print(c);
        if(widget.asyncItems==null) return [];
        var res  = await widget.asyncItems!();
        if(res.statusCode == 200)
          return res.result as List<DropDownDTO>;
        return [];
      },
      filterFn: (item, filter) =>item.name!.contains(filter),
      itemAsString: (DropDownDTO u) => u.name!,
      items: widget.items ?? [],
      onChanged: (DropDownDTO) {
        if(widget.onSelect!=null) widget.onSelect!(DropDownDTO!);
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlign: TextAlign.start,
        dropdownSearchDecoration:  InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:  Color_TextFieldBorder,
                width: 0.0),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color_Accent),
            borderRadius: BorderRadius.circular(8),
          ),
          floatingLabelStyle: TextStyle(
              color:  Color_Accent ,
              fontWeight: FontWeight.bold),
          filled: true,
          labelText: widget.label??"",
          fillColor: Color_Background,
          isDense: true,
        )
      ),

    );
  }
}
