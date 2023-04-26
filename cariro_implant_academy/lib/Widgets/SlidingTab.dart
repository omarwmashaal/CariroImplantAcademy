import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:flutter/material.dart';
import 'package:slide_switcher/slide_switcher.dart';

class SlidingTab extends StatefulWidget {
  SlidingTab(
      {Key? key,
      required this.titles,
      this.onChange,
      required this.weight,
      this.height,
      this.fontSize,
      this.adapt,
      this.selectedColor,
      required this.controller})
      : super(key: key);

  bool? adapt = false;

  List<String> titles;
  Function? onChange;
  double weight;
  double? height;
  double? fontSize;
  Color? selectedColor;
  TabsController controller;
  late List<Widget> ItemsWidget;

  @override
  State<SlidingTab> createState() => _SlidingTabState();
}

class _SlidingTabState extends State<SlidingTab> {
  int switcherIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SlideSwitcher(
      children: BuildItems(),
      onSelect: (int index) {
        setState(() => switcherIndex = index);
        if (widget.onChange != null) widget.onChange!(index);
        else widget.controller.index.value = index;
      },
      containerColor: Colors.transparent,
      containerBorder: Border.all(color: Color_TextFieldBorder),
      slidersColors: [
        (widget.selectedColor == null
            ? Color_Accent
            : widget.selectedColor as Color)
      ],
      containerHeight: widget.height == null ? 50 : widget.height as double,
      containerWight: widget.weight,
      containerBorderRadius: 8,
    );
  }

  @override
  void initState() {
    widget.controller.index.value = 0;
  }

  List<Widget> BuildItems() {
    List<Widget> returnValue = <Widget>[];
    int index = 0;
    for (String title in widget.titles) {
      returnValue.add(Container(
        //padding: switcherIndex==index? null:null,//EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        /*decoration: switcherIndex==index? null:null,BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color_TextFieldBorder,
              )
          )*/
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontSize: widget.fontSize == null ? 20 : widget.fontSize as double,
            color: switcherIndex == index ? Colors.white : Color_TextSecondary,
            fontFamily: switcherIndex == index ? Inter_Bold : Inter_SemiBold,
          ),
        ),
      ));
      index++;
    }
    return returnValue;
  }
}
