import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/bloc/dropdownSearchBloc.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/Colors.dart';
import '../Models/DTOs/DropDownDTO.dart';
import '../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../core/injection_contianer.dart';
import '../core/useCases/useCases.dart';

class CIA_DropDown extends StatefulWidget {
  CIA_DropDown({Key? key, this.onSelect, required this.label, this.selectedValue, required this.values}) : super(key: key);

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
      controller: DropdownEditingController(value: widget.selectedValue == null ? "" : widget.selectedValue),
      onChanged: (dynamic value) {
        if (widget.onSelect != null) {
          widget.onSelect!(value);
          widget.selectedValue = value;
          setState(() {});
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
        floatingLabelStyle: TextStyle(color: focus.hasFocus ? Color_Accent : Color(0xff000000), fontWeight: FontWeight.bold),
        filled: true,
        labelText: widget.label,
        fillColor: Color_Background,
        isDense: true,
      ),
      dropdownHeight: 120,
    );
  }
}

class CIA_DropDownSearch extends StatelessWidget {
  CIA_DropDownSearch(
      {Key? key,
      this.items,
      this.asyncItems,
      this.label,
      this.disableSearch = false,
      this.selectedItem,
      this.enabled = true,
      this.emptyString = "No results found",
      this.onSelect})
      : super(key: key);
  List<DropDownDTO>? items;
  Future<API_Response> Function()? asyncItems;
  String? label;
  DropDownDTO? selectedItem;
  bool enabled;
  String emptyString;
  bool disableSearch;
  Function(DropDownDTO value)? onSelect;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DropDownDTO>(
      enabled: enabled,
      popupProps: PopupProps.menu(
        showSearchBox: !disableSearch,
        emptyBuilder: (context, searchEntry) {
          return Text(emptyString);
        },
      ),
      selectedItem: selectedItem,
      asyncItems: (c) async {
        if (asyncItems == null) return [];
        var res = await asyncItems!();
        if (res.statusCode == 200) return res.result as List<DropDownDTO>;
        return [];
      },
      filterFn: (item, filter) => item.name!.toLowerCase().contains(filter.toLowerCase()),
      itemAsString: (DropDownDTO u) => u.name!,
      items: items ?? [],
      onChanged: (DropDownDTO) {
        if (onSelect != null) onSelect!(DropDownDTO!);
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.start,
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_Accent),
              borderRadius: BorderRadius.circular(8),
            ),
            floatingLabelStyle: TextStyle(color: Color_Accent, fontWeight: FontWeight.bold),
            filled: true,
            labelText: label ?? "",
            fillColor: Color_Background,
            isDense: true,
          )),
    );
  }
}

class CIA_DropDownSearchClean extends StatelessWidget {
  CIA_DropDownSearchClean(
      {Key? key,
      this.items,
      this.asyncItems,
      this.label,
      this.disableSearch = false,
      this.selectedItem,
      this.enabled = true,
      this.emptyString = "No results found",
      this.onSelect})
      : super(key: key);
  List<DropDownDTO>? items;
  Future<List<DropDownDTO>> Function()? asyncItems;
  String? label;
  DropDownDTO? selectedItem;
  bool enabled;
  String emptyString;
  bool disableSearch;
  Function(DropDownDTO value)? onSelect;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DropDownDTO>(
      enabled: enabled,
      popupProps: PopupProps.menu(
        showSearchBox: !disableSearch,
        emptyBuilder: (context, searchEntry) {
          return Text(emptyString);
        },
      ),
      selectedItem: selectedItem,
      asyncItems: (c) async {
        if (asyncItems == null) return [];
        return await asyncItems!();

      },
      filterFn: (item, filter) => item.name!.toLowerCase().contains(filter.toLowerCase()),
      itemAsString: (DropDownDTO u) => u.name!,
      items: items ?? [],
      onChanged: (DropDownDTO) {
        if (onSelect != null) onSelect!(DropDownDTO!);
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.start,
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color_Accent),
              borderRadius: BorderRadius.circular(8),
            ),
            floatingLabelStyle: TextStyle(color: Color_Accent, fontWeight: FontWeight.bold),
            filled: true,
            labelText: label ?? "",
            fillColor: Color_Background,
            isDense: true,
          )),
    );
  }
}

class CIA_DropDownSearchBasicIdName<T> extends StatelessWidget {
  CIA_DropDownSearchBasicIdName(
      {Key? key,
      this.items,
      this.asyncUseCase,
      this.label,
      this.disableSearch = false,
      this.selectedItem,
      this.enabled = true,
      this.emptyString = "No results found",
        this.searchParams,
      this.onSelect})
      : super(key: key);
  List<BasicNameIdObjectEntity>? items;
  LoadingUseCases? asyncUseCase;
  T? searchParams;

  String? label;
  BasicNameIdObjectEntity? selectedItem;
  bool enabled;
  String emptyString;
  bool disableSearch;
  Function(BasicNameIdObjectEntity value)? onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DropDownSearchBloc>(),
      child: Builder(builder: (context) {
        DropDownSearchBloc bloc = context.read<DropDownSearchBloc>();
        return DropdownSearch<BasicNameIdObjectEntity>(
          enabled: enabled,
          popupProps: PopupProps.menu(
            showSearchBox: !disableSearch,
            emptyBuilder: (context, searchEntry) {
              return Text(emptyString);
            },
          ),
          selectedItem: selectedItem,
          asyncItems: (c) async {
            if (asyncUseCase == null) return [];
            var res = await bloc.searchString(
              searchParams??NoParams(),
              asyncUseCase!,
            );
            return res;
          },
          filterFn: (item, filter) => item.name!.toLowerCase().contains(filter.toLowerCase()),
          itemAsString: (BasicNameIdObjectEntity u) => u.name!,
          items: items ?? [],
          onChanged: (v) {
            if (onSelect != null) onSelect!(v!);
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
              textAlign: TextAlign.start,
              dropdownSearchDecoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color_TextFieldBorder, width: 0.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color_Accent),
                  borderRadius: BorderRadius.circular(8),
                ),
                floatingLabelStyle: TextStyle(color: Color_Accent, fontWeight: FontWeight.bold),
                filled: true,
                labelText: label ?? "",
                fillColor: Color_Background,
                isDense: true,
              )),
        );
      }),
    );
  }
}

