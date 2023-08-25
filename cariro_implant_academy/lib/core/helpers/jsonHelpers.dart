List<T>? jsonToList<T>({required List<dynamic>? jsonList, required T Function(Map<String, dynamic>) conversionMethod}) {
  if (jsonList == null) return null;

  return jsonList.map((e) => conversionMethod(e)).toList();
}
