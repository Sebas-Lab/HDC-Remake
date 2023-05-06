List<String> generateFilterRanges(int totalHymns, {int rangeSize = 50}) {
  List<String> filterRanges = [];
  int currentStart = 1;

  while (currentStart <= totalHymns) {
    int currentEnd = currentStart + rangeSize - 1;
    if (currentEnd > totalHymns) {
      currentEnd = totalHymns;
    }
    filterRanges.add('$currentStart - $currentEnd');
    currentStart = currentEnd + 1;
  }

  return filterRanges;
}