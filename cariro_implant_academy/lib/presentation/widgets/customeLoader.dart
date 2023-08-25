import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CustomLoader {
  static show(BuildContext context) {
    Loader.show(
      context,
      progressIndicator: LoadingWidget(),
      overlayColor: Colors.transparent
    );
  }

  static hide() {
    Loader.hide();
  }
}
