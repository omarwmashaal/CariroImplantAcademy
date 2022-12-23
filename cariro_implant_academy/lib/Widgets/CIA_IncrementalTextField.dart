import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _widgetController extends GetxController {
  static List<Widget> myBuild = <Widget>[_myWidget()].obs;
}

String label = "";

class CIA_IncrementalTextField extends StatefulWidget {
  CIA_IncrementalTextField({Key? key, required this.label}) : super(key: key);

  String label;
  @override
  State<CIA_IncrementalTextField> createState() =>
      _CIA_IncrementalTextFieldState();
}

class _CIA_IncrementalTextFieldState extends State<CIA_IncrementalTextField> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: _widgetController.myBuild,
        ));
  }

  @override
  void initState() {
    label = widget.label;
  }
}

class _myWidget extends StatelessWidget {
  const _myWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: new CIA_TextFormField(
                    label: label,
                    controller: new TextEditingController(),
                  )),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        _widgetController.myBuild.add(SizedBox(
                          height: 10,
                        ));
                        _widgetController.myBuild.add(_myWidget());
                      },
                      icon: Icon(Icons.add))),
            ],
          ),
        ),
        Expanded(flex: 4, child: SizedBox())
      ],
    );
  }
}
