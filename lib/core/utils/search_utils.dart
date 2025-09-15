class SearchUtils {
  SearchUtils._();

  static String? suggestionAlgorithm(String value, List<String> words) {
    if (value.isEmpty) return null;

    final matches = words
        .where((word) => word.toLowerCase().startsWith(value.toLowerCase()))
        .toList();

    if (matches.isEmpty) return null;

    List<String> filtered = matches;
    if (matches.length > 1) {
      filtered = matches
          .where((w) => w.toLowerCase() != value.toLowerCase())
          .toList();
    }

    if (filtered.isEmpty) {
      filtered = matches;
    }

    filtered.sort((a, b) {
      final lengthCompare = a.length.compareTo(b.length);
      return lengthCompare != 0 ? lengthCompare : a.compareTo(b);
    });

    return filtered.first;
  }
}
