class AppMath {
  static const gigabyte = 1000000000;

  static String divideAndFormat({
    int data = 0,
    divideWith = gigabyte,
  }) {
    var result = data / divideWith;
    return result.toStringAsFixed(2).replaceAll(".", ",");
  }
}
