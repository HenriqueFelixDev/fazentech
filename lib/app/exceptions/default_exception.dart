class DefaultException extends Error {
  String code;
  String message;
  DefaultException(this.message, [this.code = '500']);
}