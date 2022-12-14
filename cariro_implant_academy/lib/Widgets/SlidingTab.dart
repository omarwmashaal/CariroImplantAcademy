import 'package:cariro_implant_academy/Constants/Colors.dart';
import 'package:cariro_implant_academy/Constants/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:slide_switcher/slide_switcher.dart';

class SlidingTab extends StatefulWidget {
  SlidingTab({Key? key, required this.titles, required this.onChange,required this.weight}) : super(key: key);

  List<String> titles;
  Function onChange;
  double weight;
  @override
  State<SlidingTab> createState() => _SlidingTabState();
}

class _SlidingTabState extends State<SlidingTab> {

  int switcherIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SlideSwitcher(
        children: BuildItems(),
        onSelect: (int index) => setState(() => switcherIndex = index),
        containerColor: Colors.transparent,
        containerBorder: Border.all(color: Color_TextFieldBorder),
        slidersColors: [Color_AccentGreen],
        containerHeight: 50,
        containerWight: widget.weight,
        containerBorderRadius: 8,



      )
    ;
  }

  List<Widget> BuildItems()
  {
    List<Widget> returnValue = <Widget>[];
    int index = 0;
    for(String title in widget.titles)
      {
        returnValue.add(Container(
          padding: switcherIndex==index? null:null,//EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: switcherIndex==index? null:null,/*BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color_TextFieldBorder,
              )
          )*/
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color:
              switcherIndex == index ? Colors.white : Color_TextSecondary,
              fontFamily:
              switcherIndex == index ? Inter_Bold : Inter_SemiBold,
            ),
          ),
        ));
        index++;
      }
    return returnValue;
  }

}
