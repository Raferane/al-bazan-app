import 'package:al_bazan_app/screens/home_screen.dart';
import 'package:al_bazan_app/screens/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    void login() async {
      final error = await ref.read(authProvider.notifier).handleLogin(
            phoneController.text.trim(),
            passwordController.text.trim(),
          );

      if (!context.mounted) return;

      if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone')),
          TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password')),
          ElevatedButton(onPressed: login, child: const Text('Login')),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RegistrationScreen(),
                ),
              );
            },
            child: const Text('Go to Registry page'),
          ),
        ],
      ),
    );
  }
}
