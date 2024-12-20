import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../utils/custom_exceptions.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(AuthService());
});

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(false);

  // Handle Login
  Future<String?> handleLogin(String phone, String password) async {
    try {
      if (phone.isEmpty) throw EmptyFieldException('Phone number');
      if (!RegExp(r'^09[0-9]{8}$').hasMatch(phone)) {
        throw InvalidPhoneException();
      }
      if (password.isEmpty) throw EmptyFieldException('Password');
      if (password.length < 8) throw InvalidPasswordException();

      await _authService.login(phone, password);

      state = true; // Set authenticated state
      return null; // Success
    } on CustomException catch (e) {
      return e.message;
    } catch (e) {
      return 'An unexpected error occurred.';
    }
  }

  // Handle Registration
  Future<String?> register(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password,
  ) async {
    try {
      if (firstName.isEmpty) throw EmptyFieldException('First Name');
      if (lastName.isEmpty) throw EmptyFieldException('Last Name');
      if (phone.isEmpty) throw EmptyFieldException('Phone Number');
      if (!RegExp(r'^09[0-9]{8}$').hasMatch(phone)) {
        throw InvalidPhoneException();
      }
      if (password.isEmpty) throw EmptyFieldException('Password');
      if (password.length < 8) throw InvalidPasswordException();

      await _authService.register(firstName, lastName, phone, email, password);

      state = true; // Set authenticated state
      return null; // Success
    } on CustomException catch (e) {
      return e.message;
    } catch (e) {
      return 'An unexpected error occurred.';
    }
  }
}
