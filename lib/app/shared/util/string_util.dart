class StringUtil {
  static String toFirstLetterUpperCase(String text) {
    assert(text != null);
    text = text.trim();

    if(text.isEmpty) return '';

    final firstLetter = text.substring(0, 1);
    final wordEnd = text.substring(1);

    return firstLetter.toUpperCase() + wordEnd;
  }

  static String toWordsFirstLetterUpperCase(String text) {
    assert(text != null);
    text = text.trim();
    if(text.isEmpty) return '';

    final words = text.split(' ');
    final modifiedWords = words.map((word) => toFirstLetterUpperCase(word));

    return modifiedWords.join(' ');
  }
}