class ValidationException implements Exception {
  final String code;

  ValidationException(this.code);
  String get fullError => 'Amount should be greater than zero';
}
