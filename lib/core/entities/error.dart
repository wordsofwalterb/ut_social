class Failure {
  final String message;
  final String code;

  Failure(this.message, this.code);

  @override
  String toString() => 'Message: $message, Code: $code';
}
