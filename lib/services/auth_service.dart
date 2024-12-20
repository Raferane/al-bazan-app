import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/password_hash.dart';
import '../utils/custom_exceptions.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Register a new user
  Future<void> register(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password,
  ) async {
    try {
      // Hash the password
      final hashedPassword = PasswordHash.hashPassword(password);

      // Insert user data into the Supabase database
      final response = await _supabase.from('users').insert({
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'email': email.isNotEmpty ? email : null,
        'password': hashedPassword,
      }).select();

      if (response.isEmpty) {
        throw SupabaseException('Registration failed: Unable to insert user.');
      }
    } on PostgrestException catch (e) {
      throw SupabaseException('Supabase error: ${e.message}');
    } catch (e) {
      throw SupabaseException('An unexpected error occurred: $e');
    }
  }

  // Login a user
  Future<void> login(String phone, String password) async {
    try {
      // Hash the password
      final hashedPassword = PasswordHash.hashPassword(password);

      // Fetch the user by phone number
      final response = await _supabase
          .from('users')
          .select('password')
          .eq('phone', phone)
          .maybeSingle(); // Fetch a single matching record or null

      if (response == null) {
        throw SupabaseException('User not found.');
      }

      final userPassword = response['password'] as String?;
      if (userPassword != hashedPassword) {
        throw SupabaseException('Incorrect password.');
      }
    } on PostgrestException catch (e) {
      throw SupabaseException('Supabase error: ${e.message}');
    } catch (e) {
      throw SupabaseException('An unexpected error occurred: $e');
    }
  }
}
