class Parser {
  static String parse(Map<String, dynamic> query) {
    List<String> parsedParams = [];
    query.forEach(
      (key, value) {
        if (value is List) {
          for (int i = 0; i < value.length; i++) {
            parsedParams.add('$key[$i]=${value[i]}');
          }
        } else {
          parsedParams.add('$key=$value');
        }
      },
    );

    return parsedParams.join('&');
  }

  static String getcookie(cookiementah, pattern) {
    try {
      RegExp exp = RegExp(pattern);
      RegExpMatch? match = exp.firstMatch(cookiementah.toString());
      var cookie = match![0].toString();
      return (cookie);
    } catch (e) {
      rethrow;
    }
  }
}
