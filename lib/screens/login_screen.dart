// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:provider/provider.dart';
import '../services/mock_auth_service.dart';
import '../theme/app_styles.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });
      try {
        await context.read<MockAuthService>().login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } catch (e) {
        if (!mounted) return;
        _showSnackBar(context, e.toString().replaceFirst('Exception: ', ''));
      } finally {
        if (mounted) { setState(() { _isLoading = false; }); }
      }
    }
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    setState(() { _isLoading = true; });
    try {
      await context.read<MockAuthService>().signInWithGoogle();
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppStyles.incorrectColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppStyles.backgroundColor,
            child: CircularParticle(
              key: UniqueKey(),
              numberOfParticles: 100,
              speedOfParticles: 0.8,
              height: screenHeight,
              width: screenWidth,
              particleColor: AppStyles.primaryColor.withAlpha(80),
              connectDots: true,
              isRandomColor: false,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: AppStyles.surfaceColor.withOpacity(1.0
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.quiz_rounded, color: AppStyles.primaryColor, size: 60),
                          const SizedBox(height: 20),
                          const Text("Welcome Back", style: AppStyles.title),
                          const SizedBox(height: 8),
                          const Text("Sign in to continue", style: AppStyles.body),
                          const SizedBox(height: 30),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter your email';
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Please enter a valid email';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter your password';
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          if (_isLoading)
                            const CircularProgressIndicator(color: AppStyles.primaryColor)
                          else
                            Column(
                              children: [
                                _NeonActionButton(
                                  text: 'LOGIN',
                                  color: AppStyles.primaryColor,
                                  onTap: () => _handleLogin(context),
                                ),
                                const SizedBox(height: 20),
                                _NeonActionButton(
                                  isGoogle: true,
                                  text: 'CONTINUE WITH GOOGLE',
                                  color: Colors.white,
                                  onTap: () => _handleGoogleSignIn(context),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSignUpButton(context),
                  ],
                ).animate().fadeIn(duration: 500.ms),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // UPDATED: This widget is now fixed to ensure text is visible
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: AppStyles.primaryColor, size: 20),
        // FIX: Added fill color and updated borders
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppStyles.primaryColor, width: 1.5),
        ),
        errorStyle: const TextStyle(color: AppStyles.incorrectColor),
      ),
      validator: validator,
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const SignUpScreen(),
            transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
            transitionDuration: 400.ms,
          ),
        );
      },
      child: Text("Don't have an account? Sign Up", style: AppStyles.body.copyWith(fontWeight: FontWeight.w500)),
    );
  }
}

class _NeonActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final bool isGoogle;

  const _NeonActionButton({
    required this.text,
    required this.color,
    required this.onTap,
    this.isGoogle = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: AppStyles.neonBorder(color),
          boxShadow: [AppStyles.neonGlow(color)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGoogle) ...[
              Image.network(
                'https://i.pinimg.com/1200x/59/7f/11/597f11b631d7d94492f1adb95110cc44.jpg',
                height: 20.0,
              ),
              const SizedBox(width: 12),
            ],
            Text(text, style: AppStyles.body.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}