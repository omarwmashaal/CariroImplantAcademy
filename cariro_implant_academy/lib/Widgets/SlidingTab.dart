import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:cariro_implant_academy/Controllers/PagesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:slide_switcher/slide_switcher.dart';

class SlidingTabModel {
  String title;
  String namedDirectory;
  String? compareName;
  Map<String, String>? pathParameters;

  SlidingTabModel({
    required this.title,
    required this.namedDirectory,
    this.compareName,
    this.pathParameters,
  });
}

class SlidingTab extends StatefulWidget {
  SlidingTab(
      {Key? key,
      required this.tabs,
      this.onChange,
      required this.weight,
      this.height,
      this.fontSize,
      this.adapt,
      this.selectedColor,
})
      : super(key: key);

  bool? adapt = false;

  List<SlidingTabModel> tabs;
  Function? onChange;
  double weight;
  double? height;
  double? fontSize;
  Color? selectedColor;
  late List<Widget> ItemsWidget;

  @override
  State<SlidingTab> createState() => _SlidingTabState();
}

class _SlidingTabState extends State<SlidingTab> {
  int switcherIndex = 0;
  var path = "";

  @override
  Widget build(BuildContext context) {
    path = GoRouter.of(context).location.split("/").last;
    switcherIndex =  widget.tabs.indexWhere((element) =>(element.compareName?? element.namedDirectory) ==path) == -1 ? 0 : widget.tabs.indexWhere((element) => (element.compareName?? element.namedDirectory) == path);
    siteController.title = widget.tabs[switcherIndex].title;
    return SlideSwitcher(
      children: BuildItems(),
      initialIndex: widget.tabs.indexWhere((element) => (element.compareName?? element.namedDirectory) == path) == -1 ? 0 : widget.tabs.indexWhere((element) => (element.compareName?? element.namedDirectory)== path),
      onSelect: (int index) {
        setState(() => switcherIndex = index);
          context.goNamed(widget.tabs[index].namedDirectory, pathParameters: widget.tabs[index].pathParameters ?? Map<String, String>());
        if (widget.onChange != null)
          widget.onChange!(index);
        else
          print("");
         // widget.controller.index.value = index;
      },
      containerColor: Colors.transparent,
      containerBorder: Border.all(color: Color_TextFieldBorder),
      slidersColors: [(widget.selectedColor == null ? Color_Accent : widget.selectedColor as Color)],
      containerHeight: widget.height == null ? 50 : widget.height as double,
      containerWight: widget.weight,
      containerBorderRadius: 8,
    );
  }

  @override
  void initState() {
  //  widget.controller.index.value = switcherIndex;

  }

  List<Widget> BuildItems() {
    List<Widget> returnValue = <Widget>[];
    int index = 0;


    for (SlidingTabModel tab in widget.tabs) {
      returnValue.add(Container(
        key: GlobalKey(),
        //padding: switcherIndex==index? null:null,//EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        /*decoration: switcherIndex==index? null:null,BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color_TextFieldBorder,
              )
          )*/
        child: Text(
          textAlign: TextAlign.center,
          tab.title,
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
