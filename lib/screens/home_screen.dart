// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/classic_quiz_category_screen.dart';
import 'package:quiz_app/screens/kids_challenge_category_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/screens/profile_screen.dart';
import '../models/user_model.dart';
import '../services/leaderboard_service.dart';
import '../services/mock_auth_service.dart';
import '../theme/app_styles.dart';
import '../widgets/feature_card.dart';
import 'ai_challenge_category_screen.dart';
import 'leaderboard_screen.dart';
import 'quiz_category_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This method displays a confirmation dialog before logging out.
  Future<void> _showLogoutConfirmationDialog(BuildContext context, MockAuthService authService) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppStyles.primaryColor,
          // ▼▼▼▼▼ CHANGES ARE HERE ▼▼▼▼▼
          // Use a Stack to apply glowing effect around the dialog content
          contentPadding: EdgeInsets.zero, // Remove default content padding
          insetPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0), // Adjust outer padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Increased border radius
            side: const BorderSide(
              color: AppStyles.primaryColor, // Ensure border color matches glow
              width: 3.0, // Increased border width for better visibility
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(24.0), // Padding inside the dialog for content
            decoration: BoxDecoration(
              color: AppStyles.surfaceColor.withOpacity(0.95), // Slightly transparent surface color
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: AppStyles.primaryColor.withOpacity(0.6), // Glowing effect
                  blurRadius: 15,
                  spreadRadius: -2, // Spread to create a tighter glow
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: AppStyles.primaryColor.withOpacity(0.3), // Secondary softer glow
                  blurRadius: 25,
                  spreadRadius: -5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Confirm Logout', style: AppStyles.title.copyWith(color: Colors.white)),
                const SizedBox(height: 16),
                const Text('Are you sure you want to log out?', style: AppStyles.body),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Logout', style: TextStyle(color: AppStyles.incorrectColor, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        authService.logout();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // No need for title and actions outside content since they are now inside
          title: null,
          actions: null,
          // ▲▲▲▲▲ CHANGES END HERE ▲▲▲▲▲
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final authService = context.watch<MockAuthService>();
    final leaderboardService = context.watch<LeaderboardService>();
    final MockUser? currentUser = authService.currentUser;
    final userRank = leaderboardService.getUserRank(currentUser?.displayName ?? '');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text('Dashboard', style: AppStyles.title.copyWith(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutConfirmationDialog(context, authService),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Stack(
        children: [
          CircularParticle(
            key: UniqueKey(),
            numberOfParticles: 80,
            speedOfParticles: 0.8,
            maxParticleSize: 4,
            particleColor: AppStyles.primaryColor.withAlpha(120),
            height: screenHeight,
            width: screenWidth,
            connectDots: false,
            isRandomColor: false,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentUser != null) _ProfileHeader(user: currentUser, rank: userRank),
                const SizedBox(height: 24),
                Text(
                  'Start a Challenge',
                  style: AppStyles.heading.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.95,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final items = [
                      _GridCard(
                        icon: Icons.timer,
                        title: 'Practice Quiz',
                        color: AppStyles.primaryColor,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizCategoryScreen())),
                      ),
                      _GridCard(
                        icon: Icons.playlist_add_check_circle,
                        title: 'Classic Quiz',
                        color: Colors.teal,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ClassicQuizCategoryScreen())),
                      ),
                      _GridCard(
                        icon: Icons.psychology_rounded,
                        title: 'AI Challenge',
                        color: AppStyles.secondaryColor,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AiChallengeCategoryScreen())),
                      ),
                      _GridCard(
                        icon: Icons.child_care,
                        title: 'Kids Quiz',
                        color: Colors.orange,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const KidsChallengeCategoryScreen())),
                      ),
                      _GridCard(
                        icon: Icons.leaderboard_rounded,
                        title: 'Leaderboard',
                        color: AppStyles.correctColor,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LeaderboardScreen())),
                      ),
                    ];
                    return items[index];
                  },
                ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideX(begin: -0.2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final MockUser user;
  final int rank;
  const _ProfileHeader({required this.user, required this.rank});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppStyles.surfaceColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppStyles.primaryColor,
                child: CircleAvatar(
                  radius: 27,
                  backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                  child: user.photoUrl == null ? Icon(Icons.person_rounded, size: 30, color: AppStyles.backgroundColor) : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, ${user.displayName ?? 'Quizzer'}!', style: AppStyles.heading.copyWith(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 4),
                    Text("Ready for a new challenge?", style: AppStyles.body),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: Colors.white70),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
                tooltip: 'Edit Profile',
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 30),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 60.0,
            runSpacing: 16.0,
            children: [
              _StatItem(
                label: 'Global Rank',
                value: rank != -1 ? '#$rank' : 'N/A',
                color: AppStyles.primaryColor,
              ),
              _StatItem(
                label: 'Total Score',
                value: (user.totalScore ?? 0).toString(),
                color: AppStyles.correctColor,
              ),
              _StatItem(
                label: 'Quizzes',
                value: (user.completedQuizzes ?? []).length.toString(),
                color: AppStyles.secondaryColor,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatItem({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppStyles.title.copyWith(fontSize: 22, color: color)),
        const SizedBox(height: 4),
        Text(label, style: AppStyles.body.copyWith(fontSize: 12)),
      ],
    );
  }
}

class _GridCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const _GridCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });
  @override
  State<_GridCard> createState() => __GridCardState();
}

class __GridCardState extends State<_GridCard> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: 200.ms,
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppStyles.surfaceColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isPressed ? widget.color : Colors.white.withOpacity(0.2),
              width: _isPressed ? 2.5 : 1,
            ),
            boxShadow: _isPressed ? [AppStyles.neonGlow(widget.color)] : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 48, color: widget.color),
              const SizedBox(height: 12),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: AppStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}