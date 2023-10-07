import 'package:flutter/cupertino.dart';

class DialogHelper {
  int currentDialogueCount = 0;

  DialogHelper() {}

  dismissSingle(BuildContext context) {
    if (currentDialogueCount != 0) {
      Navigator.of(context, rootNavigator: true).pop();
      currentDialogueCount--;
    }
  }

  dismissAll(BuildContext context) {
    while (currentDialogueCount != 0) {
      dismissSingle(context);
    }
  }

  increaseCount() => currentDialogueCount++;
}
