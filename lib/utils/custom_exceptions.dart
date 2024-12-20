class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() => message;
}

class EmptyFieldException extends CustomException {
  EmptyFieldException(String fieldName) : super('$fieldName cannot be empty.');
}

class InvalidPhoneException extends CustomException {
  InvalidPhoneException()
      : super('Phone number must be 10 digits and start with 09.');
}

class InvalidPasswordException extends CustomException {
  InvalidPasswordException()
      : super('Password must be at least 8 characters long.');
}

class AuthenticationException extends CustomException {
  AuthenticationException(String error)
      : super('Authentication failed: $error');
}

class SupabaseException extends CustomException {
  SupabaseException(super.message);
}
