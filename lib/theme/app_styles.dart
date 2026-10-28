// lib/theme/app_styles.dart

import 'package:flutter/material.dart';

class AppStyles {
  // --- COLORS ---
  static const Color primaryColor = Color(0xFF00BFFF); // Deep Sky Blue
  static const Color secondaryColor = Color(0xFFF83BB6); // Hollywood Cerise
  static const Color correctColor = Color(0xFF39FF14); // Neon Green
  static const Color incorrectColor = Color(0xFFFF3131); // Neon Red
  static const Color backgroundColor = Color(0xFF121212); // Near Black
  static const Color surfaceColor = Color(0xFF1E1E1E); // Dark Grey
  static const Color androidColor = Color(0xFFA4C639); //  Lime Green
  static const Color flutterColor = Color(0xFF027DFD); // Bright Blue
  static const Color javaColor = Color(0xFFF89820); // Vibrant Orange
  static const Color phpColor = Color(0xFF7A86B8); // Indigo
  static const Color pythonColor = Color(0xFF306998); // Royal Blue
  static const Color movieColor = Color(0xFFD9006C); //  Vibrant Magenta
  static const Color politicsColor = Color(0xFFB22234); // Crimson Red
  static const Color sportsColor = Color(0xFFFFB600); // Energetic Gold
  static const Color scienceColor = Color(0xFF00C4A5); // Bright Teal
  static const Color whitebgcolor = Color(0xFFFFFFFF); // Bright Teal


  // --- GLOW EFFECTS ---
  static BoxShadow neonGlow(Color color) {
    return BoxShadow(
      color: color.withOpacity(0.6),
      blurRadius: 15,
      spreadRadius: 2,
    );
  }

  // NEW: Added a classic, soft shadow style
  static BoxShadow softShadow() {
    return BoxShadow(
      color: Colors.black.withOpacity(0.25),
      blurRadius: 12,
      offset: const Offset(0, 6),
    );
  }

  // ... (Borders and Text Styles remain the same)
  static Border neonBorder(Color color) {
    return Border.all(color: color.withOpacity(0.8), width: 1.5);
  }

  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.2,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  static const TextStyle score = TextStyle(
    fontFamily: 'monospace',
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
