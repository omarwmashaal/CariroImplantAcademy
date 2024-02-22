import 'package:flutter/cupertino.dart';

class DialogHelper {
  int currentDialogueCount = 0;
  int trials = 0;

  DialogHelper() {
    print("dialog helper: Constructor $currentDialogueCount}");
  }

  dismissSingle(BuildContext context) {
    print("dialog helper: single start $currentDialogueCount}");
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

    print("dialog helper: single end $currentDialogueCount}");
  }

  dismissAll(BuildContext context) {

    print("dialog helper: all start $currentDialogueCount}");
    while (currentDialogueCount != 0) {
      dismissSingle(context);
    }

    print("dialog helper: all end $currentDialogueCount}");
  }
  clear()=>currentDialogueCount=0;


  increaseCount() {

    print("dialog helper: increase start $currentDialogueCount}");
     currentDialogueCount++;

    print("dialog helper: increase end $currentDialogueCount}");
  }
}
