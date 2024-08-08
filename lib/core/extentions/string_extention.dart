extension StringEx on String {
  DateTime parseStringToDate() {
    try {
      DateTime? data = DateTime.tryParse(this);
      if (data == null) {
        return DateTime.now();
      }
      return data;
    } catch (ex) {
      return DateTime.now();
    }
  }

  String getFirstAndLastUserCharacter() {
    List<String> names = split(' ');
    if (names.isEmpty) return '';
    return '${names.first[0]}${names.last[0]}';
  }
}
