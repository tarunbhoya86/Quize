import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<MockAuthService>();

    if (!authService.isLoggedIn) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}