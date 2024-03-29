import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:flutter/cupertino.dart';

import '../Constants/Controllers.dart';
import 'CIA_PrimaryButton.dart';
import 'CIA_SecondaryButton.dart';

class MedicalSlidingBar extends StatefulWidget {
  MedicalSlidingBar({Key? key, required this.pages}) : super(key: key);

  List<MedicalSlidingModel> pages;

  @override
  State<MedicalSlidingBar> createState() => _MedicalSlidingBarState();
}

class _MedicalSlidingBarState extends State<MedicalSlidingBar> {
  @override
  Widget build(BuildContext context) {
    int i = 0;
    widget.pages.forEach((element) {
      element.setIndex(i);
      i++;
    });
    return Row(
      key: GlobalKey(),
      children: widget.pages.map((e) {
        Widget _widget = Text("");
        if (e.isSelected)
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CIA_PrimaryButton(label: e.name.replaceAll("Clinic", ""), height: 50,width: 100, onTab: () {}),
          );
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CIA_SecondaryButton(
              label: e.name.replaceAll("Clinic", ""),
              height: 50,
              width: 100,
              onTab: () async {
                bool changePage = true;
                if (widget.pages.firstWhere((element) => element.isSelected == true).onSave != null)
                  await widget.pages.firstWhere((element) => element.isSelected == true).onSave!();
                if(e.onTap!=null) e.onTap!();
                /*await CIA_ShowPopUpSaveRequest(
                    context: context,
                    onSave: () {
                      widget.pages
                          .firstWhere((element) => element.isSelected == true)
                          .onSave!();
                      changePage = true;
                    },
                    onCancel: () {
                      changePage = false;
                    },
                    onDontSave: () {
                      changePage = true;
                    });*/

                e.isSelected = true;
                for (var ff in widget.pages) {
                  if (ff.getIndex() == e.getIndex())
                    ff.isSelected = true;
                  else
                    ff.isSelected = false;
                }

                setState(() {});
              }),
        );

        return _widget;
      }).toList(),
    );
  }

  @override
  void initState() {
    int i = 0;
    widget.pages.forEach((element) {
      element.setIndex(i);
     // element.isSelected = i == 0;
      i++;
    });
  }
}

class MedicalSlidingModel {
  String name;
  int _index = 0;
  bool isSelected = false;
  Function? onSave;
  Function? onTap;

  setIndex(int i) {
    _index = i;
  }

  getIndex() {
    return _index;
  }

  MedicalSlidingModel({this.onSave, required this.name, this.isSelected = false,this.onTap});
}
