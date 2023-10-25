import 'package:flutter/cupertino.dart';

class DialogHelper {
  int currentDialogueCount = 0;
  int trials = 0;

  DialogHelper() {}

  dismissSingle(BuildContext context) {
    if (  currentDialogueCount != 0) {
      Navigator.of(context, rootNavigator: true).pop();
      currentDialogueCount--;
      trials = 0;
    }
    else{
      trials++;
    }
    if(trials ==2)
      {
        Navigator.of(context, rootNavigator: true).pop();
        trials = 0;
      }
  }

  dismissAll(BuildContext context) {
    while (currentDialogueCount != 0) {
      dismissSingle(context);
    }
  }
  clear()=>currentDialogueCount=0;


  increaseCount() => currentDialogueCount++;
}
