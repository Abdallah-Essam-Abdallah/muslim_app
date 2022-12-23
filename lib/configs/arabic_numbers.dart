library arabic_numbers;

class ArabicNumbers {
  static String convert(Object value) {
    assert(
      value is int || value is String,
      "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return toArabicNumbers(value.toString());
    } else {
      return toArabicNumbers(value as String);
    }
  }

  static String toArabicNumbers(String value) {
    return value
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }
}

extension IntExtensions on int {
  String get toArabicNumbers {
    return ArabicNumbers.convert(this);
  }
}

extension StringExtensions on String {
  String get toArabicNumbers {
    return ArabicNumbers.convert(this);
  }
}
