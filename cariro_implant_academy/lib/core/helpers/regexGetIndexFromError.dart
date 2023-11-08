int? getIndexFromError(String error)
{
  RegExp match = RegExp(r"(\[)([0-9]+)(\])");
  final firstMatch = match.firstMatch(error);
  if(firstMatch!=null)
    return int.parse(firstMatch.group(2).toString());
  return null;
}