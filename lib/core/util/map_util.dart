Map<String, dynamic> convertDynamicMap(dynamic map) {
  Map<String, dynamic> convertedMap = {};

  if (map is Map<String, dynamic>) {
    map.forEach((key, value) {
      convertedMap[key] = value;
    });
  }

  return convertedMap;
}
