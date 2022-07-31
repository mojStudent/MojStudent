extension StringExtension on String {
  String capitalize() {
    var words = this.split(" ");

    var s = "";

    for (int i = 0; i < words.length; i++) {
      if (i != 0) {
        s += " ";
      }
      var word = words[i];
      s += "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
    }
    return s;
  }
}
