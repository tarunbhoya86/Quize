// lib/screens/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:provider/provider.dart';
import '../services/mock_auth_service.dart';
import '../theme/app_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });
      try {
        await context.read<MockAuthService>().register(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _displayNameController.text.trim().isEmpty ? null : _displayNameController.text.trim(),
        );
        if (!mounted) return;
        _showSnackBar(context, 'Account created! Please log in.', true);
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        _showSnackBar(context, e.toString().replaceFirst('Exception: ', ''), false);
      } finally {
        if (mounted) { setState(() { _isLoading = false; }); }
      }
    }
  }

  void _showSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? AppStyles.phpColor : AppStyles.incorrectColor,
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
              particleColor: AppStyles.phpColor.withAlpha(80),
              connectDots: true,
              isRandomColor: false,
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
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
                        color: AppStyles.surfaceColor.withOpacity(1.0),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person_add_alt_1_rounded, color: AppStyles.phpColor, size: 60),
                          const SizedBox(height: 20),
                          const Text("Create Account", style: AppStyles.title),
                          const SizedBox(height: 8),
                          const Text("Start your quiz journey", style: AppStyles.body),
                          const SizedBox(height: 30),
                          _buildTextField(
                            controller: _displayNameController,
                            label: 'Display Name (Optional)',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 20),
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
                              if (value == null || value.isEmpty) return 'Please enter a password';
                              if (value.length < 6) return 'Password must be at least 6 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            icon: Icons.check_circle_outline,
                            isPassword: true,
                            validator: (value) {
                              if (value != _passwordController.text) return 'Passwords do not match';
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          if (_isLoading)
                            const CircularProgressIndicator(color: AppStyles.phpColor)
                          else
                            _NeonActionButton(
                              text: 'SIGN UP',
                              color: AppStyles.phpColor,
                              onTap: () => _handleSignUp(context),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLoginButton(context),
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
        prefixIcon: Icon(icon, color: AppStyles.phpColor, size: 20),
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
          borderSide: const BorderSide(color: AppStyles.phpColor, width: 1.5),
        ),
        errorStyle: const TextStyle(color: AppStyles.incorrectColor),
      ),
      validator: validator,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Already have an account? Login", style: AppStyles.body.copyWith(fontWeight: FontWeight.w500)),
    );
  }
}

class _NeonActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _NeonActionButton({
    required this.text,
    required this.color,
    required this.onTap,
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
        child: Center(
          child: Text(text, style: AppStyles.body.copyWith(color: color, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}