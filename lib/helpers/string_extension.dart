extension StringExtension on String {
  String capitalize() {
    var words = this.split(" ");

    var s = "";

    for (var word in words) {
      s += "${word[0].toUpperCase()}${word.substring(1)} ";
    }

    return s;
  }
}
