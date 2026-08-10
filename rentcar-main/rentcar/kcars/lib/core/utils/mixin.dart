mixin CleanMapMixin {
  Map<String, dynamic> cleanedMap({bool removeEmptyStrings = true}) {
    final dynamic self = this;
    if ((self.toMap is! Function)) {
      throw Exception('Class must implement toMap() method.');
    }
    final map = self.toMap() as Map<String, dynamic>;

    dynamic cleanValue(dynamic value) {
      if (value == null) return null;
      if (value == -1) return null;
      if (value is CleanMapMixin) {
        return value.cleanedMap(removeEmptyStrings: removeEmptyStrings);
      }

      if (value is List) {
        final cleanedList = value
            .map((e) => cleanValue(e))
            .where((e) => e != null)
            .toList();

        return cleanedList.isEmpty ? null : cleanedList;
      }

      if (value is Map<String, dynamic>) {
        final cleanedMap = <String, dynamic>{};
        value.forEach((k, v) {
          final cv = cleanValue(v);
          if (cv != null &&
              (!removeEmptyStrings || !(cv is String && cv.trim().isEmpty))) {
            cleanedMap[k] = cv;
          }
        });
        return cleanedMap.isEmpty ? null : cleanedMap;
      }

      if (removeEmptyStrings && value is String && value.trim().isEmpty) {
        return null;
      }

      return value;
    }

    final cleaned = <String, dynamic>{};
    for (final entry in map.entries) {
      final cleanedVal = cleanValue(entry.value);
      if (cleanedVal != null) {
        cleaned[entry.key] = cleanedVal;
      }
    }

    return cleaned;
  }
}
