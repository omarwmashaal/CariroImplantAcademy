String AddSpacesToSentence(String text) {
  int i = 0;
  List<String> word = [];
  for (String s in text.split("")) {
    if (i == 0)
      word.add(s.toUpperCase());
    else {
      if (s.toUpperCase() == s) {
        if (word.last.toUpperCase() != word.last) word.add(" ");
      }
      word.add(s);
    }

    i++;
  }

  String returnValue = "";
  word.forEach((element) {
    returnValue += element;
  });
  return returnValue;
}
