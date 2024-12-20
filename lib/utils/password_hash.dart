import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordHash {
  // Hash the password using SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert password to bytes
    final digest = sha256.convert(bytes); // Perform SHA-256 hashing
    return digest.toString(); // Return the hashed password as a string
  }
}
